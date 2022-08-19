`timescale 1ns / 1ps

module regr  #(    parameter AWIDTH = 4,
                   parameter DWIDTH = 8,
                   parameter REGWN  = 5, 
                   parameter REGRN  = 3,
                   parameter REGR_ADDR_OFFSET = 5)(
                   input  wire [REGWN-1:0]             pselw_r,       
                   input  wire [REGWN-1:0]             pselw_w,  
                   input  wire [DWIDTH-1:0]            PWDATA,       
                   output reg  [DWIDTH-1:0]            PRDATA );
                   
reg [DWIDTH-1:0]   regw_rewhrite_0;
reg [DWIDTH-1:0]   regw_rewhrite_1;
reg [DWIDTH-1:0]   regw_rewhrite_2;
reg [DWIDTH-1:0]   regw_rewhrite_3;
reg [DWIDTH-1:0]   regw_rewhrite_4;

always @(pselw_r) begin
      case( pselw_r )
          0       :    PRDATA = regw_rewhrite_0;  
          1       :    PRDATA = regw_rewhrite_1;  
          2       :    PRDATA = regw_rewhrite_2;     
          3       :    PRDATA = regw_rewhrite_3;   
          4       :    PRDATA = regw_rewhrite_4;           
      endcase    
end

always @(pselw_w) begin
      case( pselw_r )
          0       :  regw_rewhrite_0 = PWDATA;
          1       :  regw_rewhrite_1 = PWDATA;  
          2       :  regw_rewhrite_2 = PWDATA;     
          3       :  regw_rewhrite_3 = PWDATA;   
          4       :  regw_rewhrite_4 = PWDATA;          
      endcase    
end

endmodule