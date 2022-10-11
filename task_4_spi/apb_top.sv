`timescale 1ns / 1ps

module apb_top  #(parameter AWIDTH  = 4,
                  parameter DWIDTH  = 32,
                  parameter REGWN   = 5, 
                  parameter REGRN   = 3,
                  parameter CLK_DIV = 2)(
                  
// Registers signals              
                  input wire   [DWIDTH-1:0]            regr_in_0,
                  input wire   [DWIDTH-1:0]            regr_in_1,
                  input wire   [DWIDTH-1:0]            regr_in_2,
                  
                  output  wire  [DWIDTH-1:0]            regw_out_0,
                  output  wire  [DWIDTH-1:0]            regw_out_1,
                  output  wire  [DWIDTH-1:0]            regw_out_2,
                  output  wire  [DWIDTH-1:0]            regw_out_3,
                  output  wire  [DWIDTH-1:0]            regw_out_4,
                  
// SPI signals
                 output  wire                          SPI_CLK,

 // APB signals             
     
                  input  wire                          PRESETn, 
                  input  wire                          PCLK,  
                  input  wire                          PSEL,
                  input  wire                          PENABLE,
                  input  wire                          PWRITE,
                  input  wire  [AWIDTH-1:0]            PADDR, 
                  input  wire  [DWIDTH-1:0]            PWDATA,
                  
                  output wire                          PSLVERR,
                  output wire  [DWIDTH-1:0]            PRDATA
                  );
                  
  apb_intf intf ();  
  
  clk_divider #(.CLK_DIV(CLK_DIV)) i_clk_divider (
  .PCLK (PCLK),
  .PRESETn(PRESETn),
  .SPI_CLK(SPI_CLK)
  );
                
                  
endmodule
