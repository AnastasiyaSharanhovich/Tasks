`timescale 1ns / 1ps



module APB_SLAVE  #(parameter AWIDTH  = 4,
                    parameter DWIDTH  = 8,
                    parameter FIFO_DEPTH    = 5,
                    parameter N=$clog2(FIFO_DEPTH+1),
                    parameter REGN  = 6,
                    parameter CLK_DIV = 2)
                   (apb_intf APB,
                   output wire   [REGN-1:0]              pselw,
                   output  wire  [DWIDTH-1:0]            regw_out_0);
                  
reg [DWIDTH-1:0]            prdata_regw0;
reg [DWIDTH-1:0]            prdata_regw1;
reg [DWIDTH-1:0]            prdata_regw2;
reg [DWIDTH-1:0]            prdata_regw3;


reg [N-1:0] TXFIFO_CNT;
reg [N-1:0] RXFIFO_CNT;
reg TXFIFO_FULL;
reg TXFIFO_EMPTY;
reg RXFIFO_FULL;
reg RXFIFO_EMPTY;

assign APB.PREADY  = 1'b1;
assign APB.PRDATA  = prdata_regw0 | prdata_regw1 | prdata_regw2;
    

  apb_addr_dec #(.AWIDTH(AWIDTH), .REGN(REGN)) i_apd_addr_dec (
  apb_intf.DECOD
  .pselw(pselw)
  );
   
   
   regw regw0
 (
 .PENABLE (APB.PENABLE),
 .PRESETn (APB.PRESETn),
 .PSEL (pselw[2]),
 .PWRITE (APB.PWRITE),
 .PWDATA (APB.PWDATA),
 .PRDATA (prdata_regw0),
 .regw_out (regw_out_0)
 );
  
  
  
//--------//---------


endmodule

