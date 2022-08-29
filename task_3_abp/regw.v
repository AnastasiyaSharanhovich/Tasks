`timescale 1ns / 1ps

module regw__0  #(    parameter DWIDTH = 8,
                      parameter REGWN  = 5 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PSEL,
                      input  wire [REGWN-1:0]             pselw_r,       
                      input  wire [REGWN-1:0]             pselw_w, 
                      input  wire [DWIDTH-1:0]            regw_in_0, 
                      input  wire [DWIDTH-1:0]            PWDATA,       
                      output reg  [DWIDTH-1:0]            PRDATA,
                      output reg  [DWIDTH-1:0]            regw_out_0 );
                   
reg [DWIDTH-1:0]   regw_0;


always @(posedge PCLK) begin

  if (pselw_r[0] == 1 ) begin  regw_0 = regw_in_0; 
                               if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) PRDATA = regw_0;
                        end  
  
  
  if (pselw_w[0] == 1 ) begin  regw_0 = PWDATA; 
                               if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) regw_out_0 = regw_0;
         
                        end                        
end

endmodule


module regw__1  #(    parameter DWIDTH = 8,
                      parameter REGWN  = 5 )(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PSEL,
                      input  wire [REGWN-1:0]             pselw_r,       
                      input  wire [REGWN-1:0]             pselw_w, 
                      input  wire [DWIDTH-1:0]            regw_in_1, 
                      input  wire [DWIDTH-1:0]            PWDATA,       
                      output reg  [DWIDTH-1:0]            PRDATA,
                      output reg  [DWIDTH-1:0]            regw_out_1 );
                   
reg [DWIDTH-1:0]   regw_1;


always @(posedge PCLK) begin

  if (pselw_r[1] == 1 ) begin  regw_1 = regw_in_1; 
                               if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) PRDATA = regw_1;
                        end  
  
  
  if (pselw_w[1] == 1 ) begin  regw_1 = PWDATA; 
                               if ( PSEL == 1'b 1 && PENABLE == 1'b 0 ) regw_out_1 = regw_1;
         
                        end                        
end

endmodule


----------/////////////---------------