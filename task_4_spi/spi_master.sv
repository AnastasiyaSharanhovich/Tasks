`timescale 1ns / 1ps

// Parameters:  SPI_MODE, can be 0, 1, 2, 3.
//              Can be configured in one of 4 modes:
//              Mode | Clock Polarity (CPOL/CKP) | Clock Phase (CPHA)
//               0   |             0             |        0
//               1   |             0             |        1
//               2   |             1             |        0
//               3   |             1             |        1

module spi_master #(parameter SPI_MODE = 0,
                    parameter CLK_DIV = 0)(
   input        PRESETn,    
   input        PCLK,    
   
   // TX (MOSI) Signals
   input [7:0]  DATA_BYTE_IN,    
   input        TX_DV,         
   output reg   TX_READY,      
   
   // RX (MISO) Signals
   output reg       RX_DV,  
   output reg [7:0] DATA_BYTE_OUT, 

   // SPI Interface
   output reg SPI_CLK,
   input      SPI_MISO,
   output reg SPI_MOSI,
   output reg SPI_CSN  
   );
   
  assign SPI_CSN  = 0;

  wire CPOL;     // Clock polarity
  wire CPHA;     // Clock phase

  reg [$clog2(CLK_DIV*2)-1:0] SPI_CLK_CNT;
  reg reg_SPI_CLK;
  reg [4:0] SPI_CLK_EDGES;
  reg Leading_Edge;
  reg Trailing_Edge;
  reg       reg_TX_DV;
  reg [7:0] TX_BYTE;

  reg [2:0] RX_BIT_CNT;
  reg [2:0] TX_BIT_CNT;

  // CPOL: Clock Polarity
  // CPOL=0 means clock idles at 0, leading edge is rising edge.
  // CPOL=1 means clock idles at 1, leading edge is falling edge.
  assign CPOL  = (SPI_MODE == 2) | (SPI_MODE == 3);

  // CPHA: Clock Phase
  // CPHA=0 means the "out" side changes the data on trailing edge of clock
  //              the "in" side captures data on leading edge of clock
  // CPHA=1 means the "out" side changes the data on leading edge of clock
  //              the "in" side captures data on the trailing edge of clock
  assign CPHA  = (SPI_MODE == 1) | (SPI_MODE == 3);



  // Purpose: Generate SPI Clock correct number of times when DV pulse comes
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (!PRESETn)
    begin
      TX_READY       = 0;
      SPI_CLK_EDGES  = 0;
      Leading_Edge   = 0;
      Trailing_Edge  = 0;
      reg_SPI_CLK    = CPOL; 
      SPI_CLK_CNT    = 0;
    end
    else
    begin

      Leading_Edge   = 0;
      Trailing_Edge  = 0;
      
      if (TX_DV)
      begin
        TX_READY       = 0;
        SPI_CLK_EDGES  = 16;  // Total # edges in one byte ALWAYS 16
      end
      else if (SPI_CLK_EDGES > 0)
      begin
      
        TX_READY  = 0;

        if (SPI_CLK_CNT == CLK_DIV*2-1)
        begin
         SPI_CLK_EDGES  = SPI_CLK_EDGES - 1;
         Trailing_Edge = 1;
         SPI_CLK_CNT = 0;
         reg_SPI_CLK       = ~reg_SPI_CLK;
        end
        else if (SPI_CLK_CNT == CLK_DIV-1)
        begin
          SPI_CLK_EDGES = SPI_CLK_EDGES - 1;
          Leading_Edge  = 1;
          SPI_CLK_CNT   = SPI_CLK_CNT + 1;
          reg_SPI_CLK   = ~reg_SPI_CLK;
        end
        else
        begin
          SPI_CLK_CNT = SPI_CLK_CNT + 1;
        end
      end  
      else
      begin
        TX_READY = 1;
      end
      
      
    end 
  end 


  // Purpose: Register TX_BYTE when Data Valid is pulsed.
  // Keeps local storage of byte in case higher level module changes the data
  
  always @(posedge PCLK or negedge  PRESETn)
  begin
    if (!PRESETn)
    begin
      TX_BYTE      = 'b00;
      reg_TX_DV    = 0;
    end
    else
      begin
        reg_TX_DV = TX_DV; 
        if (TX_DV)
        begin
          TX_BYTE = DATA_BYTE_IN;
        end
      end 
  end 


  // Purpose: Generate MOSI data
  // Works with both CPHA=0 and CPHA=1
  
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (!PRESETn)
    begin
      SPI_MOSI    = 0;
      TX_BIT_CNT  = 3'b111; 
    end
    else
    begin
      // If ready is high, reset bit counts to default
      if (TX_READY)
      begin
        TX_BIT_CNT  = 3'b111;
      end
      // Catch the case where we start transaction and CPHA = 0
      else if (reg_TX_DV & ~CPHA)
      begin
        SPI_MOSI    = TX_BYTE[3'b111];
        TX_BIT_CNT  = 3'b110;
      end
      else if ((Leading_Edge & CPHA) | (Trailing_Edge & ~CPHA))
      begin
       TX_BIT_CNT    = TX_BIT_CNT - 1;
       SPI_MOSI     = TX_BYTE[TX_BIT_CNT];
      end
    end
  end


  // Purpose: Read in MISO data.
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (!PRESETn)
    begin
      DATA_BYTE_OUT  = 'b00;
      RX_DV          = 1'b0;
      RX_BIT_CNT     = 3'b111;
    end
    else
    begin

      RX_DV   = 1'b0;

      if (TX_READY) // Check if ready is high, if so reset bit count to default
      begin
        RX_BIT_CNT = 3'b111;
      end
      else if ((Leading_Edge & ~CPHA) | (Trailing_Edge & CPHA))
      begin
        DATA_BYTE_OUT[RX_BIT_CNT] = SPI_MISO;  // Sample data
        RX_BIT_CNT = RX_BIT_CNT - 1;
        if (RX_BIT_CNT == 3'b000)
        begin
              = 1'b1;   // Byte done, pulse Data Valid
        end
      end
    end
  end
  
  
  // Purpose: Add clock delay to signals for alignment.
  
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (!PRESETn)
    begin
      SPI_CLK  = CPOL;
    end
    else
      begin
        SPI_CLK = reg_SPI_CLK;
      end 
  end 
  

endmodule
