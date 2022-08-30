`timescale 1ns / 1ps    

module top  #(parameter AWIDTH = 4,
              parameter DWIDTH = 8,
              parameter REGWN  = 5, 
              parameter REGRN  = 3,
              parameter REGR_ADDR_OFFSET = 5)(
             
              inout  wire  [REGWN-1:0]             pselw,
              inout  wire  [REGWN-1:0]             pselr,
              
              input  wire  [DWIDTH-1:0]            prdata_regw0, // input or inout ?
              input  wire  [DWIDTH-1:0]            prdata_regw1,
              input  wire  [DWIDTH-1:0]            prdata_regw2,
              input  wire  [DWIDTH-1:0]            prdata_regw3,
              input  wire  [DWIDTH-1:0]            prdata_regw4,
              
              input wire   [DWIDTH-1:0]            prdata_regr0,
              input wire   [DWIDTH-1:0]            prdata_regr1,
              input wire   [DWIDTH-1:0]            prdata_regr2,
              
              
              input wire   [DWIDTH-1:0]            regr_in_0,  // input or inout ?
              input wire   [DWIDTH-1:0]            regr_in_1,
              input wire   [DWIDTH-1:0]            regr_in_2,
              
              input  wire  [DWIDTH-1:0]            regw_out_0,  // input or inout ?
              inout  wire  [DWIDTH-1:0]            regw_out_1,
              inout  wire  [DWIDTH-1:0]            regw_out_2,
              inout  wire  [DWIDTH-1:0]            regw_out_3,
              inout  wire  [DWIDTH-1:0]            regw_out_4,
              
              inout  wire                          PRESETn, // because the signal comes from the tesbench and goes to the other modules
              inout  wire                          PCLK,   // -//-
              inout  wire                          PSEL,
              inout  wire                          PENABLE,
              inout  wire                          PWRITE,
              inout  wire  [AWIDTH-1:0]            PADDR, 
              input  wire  [DWIDTH-1:0]            PWDATA,
              
              inout  wire                          PSLVERR,
              output wire  [DWIDTH-1:0]            PRDATA,
              output wire                          PREADY);
        
 
assign PREADY  = 1'b1;
assign PRDATA  = prdata_regw0 || prdata_regw1 || prdata_regw2 || prdata_regw3 || prdata_regw4;



addr_dec decode
(
.PCLK (PCLK),
.PRESETn (PRESETn),
.PENABLE (PENABLE),
.PSEL (PSEL),
.PWRITE (PWRITE),
.PENABLE (PENABLE),
.PADDR (PADDR),
.PRDATA (PRDATA),
.PSLVERR (PSLVERR),
.pselw (pselw),
.pselr (pselr)
);  
   
   
 regw regw0
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselw[0]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw0),
.regw_out (regw_out_0)
);

regw regw1
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselw[1]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw1), 
.regw_out (regw_out_1)
);

regw regw2
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselw[2]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw1), 
.regw_out (regw_out_1)
);

regw regw3
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselw[3]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw1), 
.regw_out (regw_out_1)
);

regw regw4
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselw[4]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw1), 
.regw_out (regw_out_1)
);

regr regr0
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselr[0]),
.PWRITE (PWRITE),
.PRDATA (prdata_regr0), 
.regr_in (regr_in_0)
);

regr regr1
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselr[1]),
.PWRITE (PWRITE),
.PRDATA (prdata_regr1), 
.regr_in (regr_in_1)
);

regr regr2
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselr[2]),
.PWRITE (PWRITE),
.PRDATA (prdata_regr2), 
.regr_in (regr_in_2)
);

 
endmodule





