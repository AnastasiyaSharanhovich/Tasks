`timescale 1ns / 1ps


module regr_RO  #(    parameter DWIDTH = 8 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PWRITE,
                      input  wire                         PSEL,   
                      input  wire [DWIDTH-1:0]            regr_in,        
                      output reg  [DWIDTH-1:0]            PRDATA);
                   
reg [DWIDTH-1:0]  regr;

always @(posedge PCLK) begin
   regr = regr_in; 
   if (PSEL == 1 && PENABLE == 1'b 1)  PRDATA = regr; 
end

endmodule
