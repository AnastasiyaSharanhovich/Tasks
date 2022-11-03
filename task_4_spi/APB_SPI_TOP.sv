`timescale 1ns / 1ps

module APB_SPI_TOP  #(parameter AWIDTH  = 4,
                      parameter SPI_MODE = 3, // CPOL = 1, CPHA = 1
                      parameter DWIDTH  = 8,
                      parameter FIFO_DEPTH    = 5,
                      parameter N=$clog2(FIFO_DEPTH+1),
                      parameter REGN  = 6,
                      parameter CLK_DIV = 2)
                     (apb_intf APB_SPI_TOP);
                   
reg [DWIDTH-1:0] DATA_TO_SPI_MASTER;
reg [DWIDTH-1:0] DATA_FROM_SPI_MASTER;
                   
spi_master  #(.SPI_MODE(SPI_MODE), .CLK_DIV(CLK_DIV)) i_spi_master(
           .PRESETn(APB_SPI_TOP.PRESETn),
           .PCLK(APB_SPI_TOP.PCLK),
           .DATA_BYTE_IN( DATA_TO_SPI_MASTER),
           .TX_DV(TX_DV),
           .TX_READY(TX_READY),
           .RX_DV(RX_DV),
           .DATA_BYTE_OUT(DATA_FROM_SPI_MASTER),
           .SPI_CLK(SPI_CLK),
           .SPI_MISO(SPI_MISO),
           .SPI_MOSI(SPI_MOSI),
           .SPI_CSN(SPI_CSN)
           );                   
                   
// instasce of TX FIFO
                   
fifo  #(.DWIDTH(DWIDTH), .FIFO_DEPTH(FIFO_DEPTH)) i_fifo_TX (
                       .CLK(APB_SPI_TOP.PCLK),
                       .RESETn(APB_SPI_TOP.PRESETn),
                       .PUSH(pselw[0]),
                       .POP(TX_READY), //from spi_master
                       .DATA_OUT(DATA_TO_SPI_MASTER),
                       .DATA_IN(PRDATA),
                       .EMPTY(TXFIFO_EMPTY),
                       .FULL(TXFIFO_FULL),
                       .CNT(TXFIFO_CNT)
                       );
                       
// instasce of RX FIFO
                                          
fifo  #(.DWIDTH(DWIDTH), .FIFO_DEPTH(FIFO_DEPTH)) i_fifo_TX (
                       .CLK(APB_SPI_TOP.PCLK),
                       .RESETn(APB_SPI_TOP.PRESETn),
                       .PUSH(RX_DV),
                       .POP(pselw[1]), 
                       .DATA_OUT(PWDATA),
                       .DATA_IN(DATA_FROM_SPI_MASTER),
                       .EMPTY(RXFIFO_EMPTY),
                       .FULL(RXFIFO_FULL),
                       .CNT(RXFIFO_CNT)
                       );
                   
endmodule