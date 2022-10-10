`timescale 1ns / 1ps


module regr  #(    parameter DWIDTH = 8 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PWRITE,
                      input  wire                         PSEL,  
                      input  wire                         PRESETn, 
                      input  wire [DWIDTH-1:0]            regr_in,        
                      output wire [DWIDTH-1:0]            PRDATA);
                   
reg [DWIDTH-1:0]  regr_RO;
assign PRDATA = (PSEL && PENABLE) ? regr_RO : 'b0;

always @(posedge PCLK or negedge PRESETn) begin //add presetn
   if(!PRESETn) regr_RO = 'b0;
   regr_RO = regr_in; 
end

endmodule
