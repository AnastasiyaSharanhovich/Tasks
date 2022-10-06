`timescale 1ns / 1ps


module regr  #(    parameter DWIDTH = 8 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PWRITE,
                      input  wire                         PSEL,   
                      input  wire [DWIDTH-1:0]            regr_in,        
                      output reg  [DWIDTH-1:0]            PRDATA);
                   
reg [DWIDTH-1:0]  regr_RO;

always @(posedge PCLK) begin
   regr_RO = regr_in; 
   if (PSEL == 1 && PENABLE == 1'b 1)  PRDATA = regr_RO; else PRDATA = 0; 
end

endmodule
