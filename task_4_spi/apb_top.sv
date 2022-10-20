`timescale 1ns / 1ps

module apb_top  #(parameter AWIDTH  = 4,
                  parameter DWIDTH  = 8,
                  parameter FIFO_DEPTH    = 5,
                  parameter N=$clog2(FIFO_DEPTH+1),
                  
                  parameter REGN   = 16,
                  parameter REGTXN   = 5,
                  parameter REGRXN   = 5,
                  parameter REGTX_ADDR_OFFSET = 10, 
                  parameter REGSTATUS_ADDR_OFFSET = 5,
                  parameter CLK_DIV = 2)(
                  
// Registers signals              
                  output  wire  [DWIDTH-1:0]            regw_out_0,
                  output  wire  [DWIDTH-1:0]            regw_out_1,
                  output  wire  [DWIDTH-1:0]            regw_out_2,
                  output  wire  [DWIDTH-1:0]            regw_out_3,
                  output  wire  [DWIDTH-1:0]            regw_out_4,
                  output  wire  [DWIDTH-1:0]            regw_out_5,
                  output  wire  [DWIDTH-1:0]            regw_out_6,
                  output  wire  [DWIDTH-1:0]            regw_out_7,
                  output  wire  [DWIDTH-1:0]            regw_out_8,
                  output  wire  [DWIDTH-1:0]            regw_out_9,
                  
// SPI signals
                 output  wire                          SPI_CLK,

 // APB signals             
     
                  input  wire                          PRESETn, 
                  input  wire                          PCLK,  
                  input  wire                          PSEL,
                  input  wire                          PENABLE,
                  input  wire                          PWRITE,
                  input  wire  [AWIDTH-1:0]            PADDR, 
                  input  wire  [DWIDTH-1:0]            PWDATA,
                  
                  output wire                          PSLVERR,
                  output wire  [DWIDTH-1:0]            PRDATA
                  );
                  

                  
reg [REGN-1:0] pselw;
                  
reg [DWIDTH-1:0]            prdata_regw0;
reg [DWIDTH-1:0]            prdata_regw1;
reg [DWIDTH-1:0]            prdata_regw2;
reg [DWIDTH-1:0]            prdata_regw3;
reg [DWIDTH-1:0]            prdata_regw4;
reg [DWIDTH-1:0]            prdata_regw5;
reg [DWIDTH-1:0]            prdata_regw6;
reg [DWIDTH-1:0]            prdata_regw7;
reg [DWIDTH-1:0]            prdata_regw8;
reg [DWIDTH-1:0]            prdata_regw9;

reg [N-1:0] TXFIFO_CNT;
reg [N-1:0] RXFIFO_CNT;
reg TXFIFO_FULL;
reg TXFIFO_EMPTY;
reg RXFIFO_FULL;
reg RXFIFO_EMPTY;


assign PRDATA  = prdata_regw5 | prdata_regw6 | prdata_regw7 | prdata_regw8 | prdata_regw9;
                  
  apb_intf intf ();  
  
  clk_divider #(.CLK_DIV(CLK_DIV)) i_clk_divider (
  .PCLK (PCLK),
  .PRESETn(PRESETn),
  .SPI_CLK(SPI_CLK)
  );
  
  apb_addr_dec #(.AWIDTH(AWIDTH), .REGN(REGN), .REGTX_ADDR_OFFSET(REGTX_ADDR_OFFSET)) i_apd_addr_dec (
    .PSEL (PSEL),
    .PENABLE(PENABLE),
    .PADDR(PADDR),
    .PSLVERR(PSLVERR),
    .pselw(pselw)
    );
    
  // instasce of TX FIFO
  
  fifo  #(.REGTX_ADDR_OFFSET(REGTX_ADDR_OFFSET), .REGSTATUS_ADDR_OFFSET(REGSTATUS_ADDR_OFFSET), .FIFO_DEPTH(FIFO_DEPTH), .REGN(REGN)) i_fifo_TX (
      .PCLK (PCLK),
      .CNT(TXFIFO_CNT),
      .SEL_NUMBER_IN(pselw[REGTX_ADDR_OFFSET+REGRXN:REGSTATUS_ADDR_OFFSET+1] << REGRXN),
      .SEL_NUMBER_OUT(),
      .EMPTY(TXFIFO_EMPTY),
      .FULL(TXFIFO_FULL)
      );
      
 // instasce of RX FIFO
 
   fifo  #(.REGTX_ADDR_OFFSET(REGTX_ADDR_OFFSET), .REGSTATUS_ADDR_OFFSET(REGSTATUS_ADDR_OFFSET), .FIFO_DEPTH(FIFO_DEPTH), .REGN(REGN)) i_fifo_RX (
     .PCLK (PCLK),
     .CNT(RXFIFO_CNT),
     .SEL_NUMBER_IN(),
     .SEL_NUMBER_OUT(),
     .EMPTY(RXFIFO_EMPTY),
     .FULL(RXFIFO_FULL)
     );

  // STATUS REG
  
  reg_status i_TXFIFO_EMPTY(
  .PRESETn(PRESETn),
  .PSEL(pselw[0]),
  .STATUS_DATA(TXFIFO_EMPTY)
  );
  
  reg_status i_TXFIFO_FULL(
  .PRESETn(PRESETn),
  .PSEL(pselw[1]),
  .STATUS_DATA(TXFIFO_FULL)
  );
 
   reg_status i_RXFIFO_EMPTY(
  .PRESETn(PRESETn),
  .PSEL(pselw[2]),
  .STATUS_DATA(TXFIFO_EMPTY)
  );
  
  reg_status i_RXFIFO_FULL(
  .PRESETn(PRESETn),
  .PSEL(pselw[3]),
  .STATUS_DATA(RXFIFO_FULL)
  ); 
  
  reg_cnt #(.FIFO_DEPTH(FIFO_DEPTH)) i_TXFIFO_CNT (
    .PRESETn(PRESETn),
    .PSEL(pselw[4]),
    .CNT_DATA(TXFIFO_CNT)
    );
    
  reg_cnt #(.FIFO_DEPTH(FIFO_DEPTH)) i_RXFIFO_CNT (
      .PRESETn(PRESETn),
      .PSEL(pselw[5]),
      .CNT_DATA(RXFIFO_CNT)
      );
      
 // REGS OF TX FIFO
  
  regw #(.DWIDTH(DWIDTH)) regw0 (
    .PENABLE (PENABLE),
    .PWRITE  (PWRITE),
    .PRESETn(PRESETn),
    .PSEL(pselw[6]),
    .PWDATA(PWDATA),
    .PRDATA(prdata_regw0),
    .regw_out(regw_out_0)
    );
    
   regw #(.DWIDTH(DWIDTH)) regw1 (
       .PENABLE (PENABLE),
       .PWRITE  (PWRITE),
       .PRESETn(PRESETn),
       .PSEL(pselw[7]),
       .PWDATA(PWDATA),
       .PRDATA(prdata_regw1),
       .regw_out(regw_out_1)
       );
       
    regw #(.DWIDTH(DWIDTH)) regw2 (
           .PENABLE (PENABLE),
           .PWRITE  (PWRITE),
           .PRESETn(PRESETn),
           .PSEL(pselw[8]),
           .PWDATA(PWDATA),
           .PRDATA(prdata_regw2),
           .regw_out(regw_out_2)
           );
           
   regw #(.DWIDTH(DWIDTH)) regw3 (
               .PENABLE (PENABLE),
               .PWRITE  (PWRITE),
               .PRESETn(PRESETn),
               .PSEL(pselw[9]),
               .PWDATA(PWDATA),
               .PRDATA(prdata_regw3),
               .regw_out(regw_out_3)
               );
              
    regw #(.DWIDTH(DWIDTH)) regw4 (
                           .PENABLE (PENABLE),
                           .PWRITE  (PWRITE),
                           .PRESETn(PRESETn),
                           .PSEL(pselw[10]),
                           .PWDATA(PWDATA),
                           .PRDATA(prdata_regw4),
                           .regw_out(regw_out_4)
                           ); 
                           
 // REGS OF RX FIFO
 
    regw #(.DWIDTH(DWIDTH)) regw5 (
                          .PENABLE (PENABLE),
                          .PWRITE  (PWRITE),
                          .PRESETn(PRESETn),
                          .PSEL(pselw[11]),
                          .PWDATA(PWDATA),
                          .PRDATA(prdata_regw5),
                          .regw_out(regw_out_5)
                          );
                                   
    regw #(.DWIDTH(DWIDTH)) regw6 (
                         .PENABLE (PENABLE),
                         .PWRITE  (PWRITE),
                         .PRESETn(PRESETn),
                         .PSEL(pselw[12]),
                         .PWDATA(PWDATA),
                         .PRDATA(prdata_regw6),
                         .regw_out(regw_out_6)
                         );  
                         
    regw #(.DWIDTH(DWIDTH)) regw7 (
                        .PENABLE (PENABLE),
                        .PWRITE  (PWRITE),
                        .PRESETn(PRESETn),
                        .PSEL(pselw[13]),
                        .PWDATA(PWDATA),
                        .PRDATA(prdata_regw7),
                        .regw_out(regw_out_7)
                        );
                        
    regw #(.DWIDTH(DWIDTH)) regw8 (
                        .PENABLE (PENABLE),
                        .PWRITE  (PWRITE),
                        .PRESETn(PRESETn),
                        .PSEL(pselw[14]),
                        .PWDATA(PWDATA),
                        .PRDATA(prdata_regw8),
                        .regw_out(regw_out_8)
                         ); 
                         
   regw #(.DWIDTH(DWIDTH)) regw9 (
                        .PENABLE (PENABLE),
                        .PWRITE  (PWRITE),
                        .PRESETn(PRESETn),
                        .PSEL(pselw[15]),
                        .PWDATA(PWDATA),
                        .PRDATA(prdata_regw9),
                        .regw_out(regw_out_9)
                         );                                 
  
                
                  
endmodule
