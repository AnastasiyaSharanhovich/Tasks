`timescale 1ns / 1ps


module regr__0  #(    parameter DWIDTH = 8,
                      parameter REGRN  = 3 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PSEL,
                      input  wire [REGRN-1:0]             pselr,   
                      input  wire [DWIDTH-1:0]            regr_in_0,        
                      output reg  [DWIDTH-1:0]            PRDATA );
                   
reg [DWIDTH-1:0]  regr_0;

always @(posedge PCLK) begin

   if (pselr[0] == 1 ) begin  regr_0 = regr_in_0; 
                              if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) PRDATA = regr_0;
                       end
     
end

endmodule

module regr__1  #(    parameter DWIDTH = 8,
                      parameter REGRN  = 3 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PSEL,
                      input  wire [REGRN-1:0]             pselr,   
                      input  wire [DWIDTH-1:0]            regr_in_1,        
                      output reg  [DWIDTH-1:0]            PRDATA );
                   
reg [DWIDTH-1:0]  regr_1;

always @(posedge PCLK) begin

   if (pselr[1] == 1 ) begin  regr_1 = regr_in_1; 
                              if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) PRDATA = regr_1;
                       end
     
end

endmodule


module regr__2  #(    parameter DWIDTH = 8,
                      parameter REGRN  = 3 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PSEL,
                      input  wire [REGRN-1:0]             pselr,   
                      input  wire [DWIDTH-1:0]            regr_in_2,        
                      output reg  [DWIDTH-1:0]            PRDATA );
                   
reg [DWIDTH-1:0]  regr_2;

always @(posedge PCLK) begin

   if (pselr[2] == 1 ) begin  regr_2 = regr_in_2; 
                              if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) PRDATA = regr_2;
                       end
     
end

endmodule