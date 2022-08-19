`timescale 1ns / 1ps


module regr  #(    parameter AWIDTH = 4,
                   parameter DWIDTH = 8,
                   parameter REGWN  = 5, 
                   parameter REGRN  = 3,
                   parameter REGR_ADDR_OFFSET = 5)(
                   input  wire [REGRN-1:0]             pselr,           
                   output reg  [DWIDTH-1:0]            PRDATA );
                   
reg [DWIDTH-1:0]  regr_status_0;
reg [DWIDTH-1:0]  regr_status_1;
reg [DWIDTH-1:0]  regr_status_2;

always @(pselr) begin
                   case( pselr )
                       0       :    PRDATA = regr_status_0; 
                       1       :    PRDATA = regr_status_1; 
                       2       :    PRDATA = regr_status_2;          
                   endcase 
                     
end

endmodule