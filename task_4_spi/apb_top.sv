`timescale 1ns / 1ps

module apb_top  #(parameter AWIDTH  = 4,
                  parameter DWIDTH  = 8,
                  parameter FIFO_DEPTH    = 5,
                  parameter N=$clog2(FIFO_DEPTH+1),
                  parameter REGN  = 6,
                  parameter CLK_DIV = 2)
                  (apb_intf APB);

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

reg [DWIDTH-1:0] SPI_DATA_IN;
reg [DWIDTH-1:0] SPI_DATA_OUT;

assign APB.PREADY  = 1'b1;
    

  apb_addr_dec #(.AWIDTH(AWIDTH), .REGN(REGN)) i_apd_addr_dec (
  apb_intf.DECOD
  .pselw(pselw)
  );
    
  // instasce of TX FIFO
  
  fifo  #(.DWIDTH(DWIDTH), .FIFO_DEPTH(FIFO_DEPTH)) i_fifo_TX (
      apb_intf.FIFO_TX
      .read_data_to_spi(SPI_DATA_IN)
      .EMPTY(TXFIFO_EMPTY)
      .FULL(TXFIFO_FULL)
      .cnt(TXFIFO_CNT)
      );
      
 // instasce of RX FIFO
 
//   fifo  #(.REGTX_ADDR_OFFSET(REGTX_ADDR_OFFSET), .REGSTATUS_ADDR_OFFSET(REGSTATUS_ADDR_OFFSET), .FIFO_DEPTH(FIFO_DEPTH), .REGN(REGN)) i_fifo_RX (
//     .PCLK (PCLK),
//     .CNT(RXFIFO_CNT),
//     .SEL_NUMBER_IN(),
//     .SEL_NUMBER_OUT(),
//     .EMPTY(RXFIFO_EMPTY),
//     .FULL(RXFIFO_FULL)
//     );

  // STATUS REGS
  
  reg_status i_TXFIFO_STATUS(
 // .PSEL(pselw[0]),
  .TXFIFO_FULL(TXFIFO_FULL),
  .TXFIFO_EMPTY(TXFIFO_EMPTY),
  .RXFIFO_FULL(RXFIFO_FULL),
  .RXFIFO_EMPTY(RXFIFO_EMPTY)
  );

  reg_cnt #(.FIFO_DEPTH(FIFO_DEPTH)) i_TXFIFO_CNT (
  //  .PSEL(pselw[4]), я понимаю что получается "форточка" но тогда не совсем полимаю что значит фраза 
  // Минимальный набор настроек, доступных в регистрах на APB-шине из ТЗ
    .CNT_DATA(TXFIFO_CNT)
    );
    
  reg_cnt #(.FIFO_DEPTH(FIFO_DEPTH)) i_RXFIFO_CNT (
     // .PSEL(pselw[5]),
      .CNT_DATA(RXFIFO_CNT)
      );
                       
endmodule
