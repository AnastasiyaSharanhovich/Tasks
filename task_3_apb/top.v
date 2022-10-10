`timescale 1ns / 1ps    

module top  #(parameter AWIDTH = 4,
              parameter DWIDTH = 8,
              parameter REGWN  = 5, 
              parameter REGRN  = 3,
              parameter REGR_ADDR_OFFSET = 5)(
          
              input wire   [DWIDTH-1:0]            regr_in_0,
              input wire   [DWIDTH-1:0]            regr_in_1,
              input wire   [DWIDTH-1:0]            regr_in_2,
              
              output  wire  [DWIDTH-1:0]            regw_out_0,
              output  wire  [DWIDTH-1:0]            regw_out_1,
              output  wire  [DWIDTH-1:0]            regw_out_2,
              output  wire  [DWIDTH-1:0]            regw_out_3,
              output  wire  [DWIDTH-1:0]            regw_out_4,
              
              input  wire                          PRESETn, 
              input  wire                          PCLK,  
              input  wire                          PSEL,
              input  wire                          PENABLE,
              input  wire                          PWRITE,
              input  wire  [AWIDTH-1:0]            PADDR, 
              input  wire  [DWIDTH-1:0]            PWDATA,
              
              output wire                          PSLVERR,
              output wire  [DWIDTH-1:0]            PRDATA,
              output wire                          PREADY);
        
 
reg [REGWN-1:0] pselw;
reg [REGRN-1:0] pselr;

              
reg [DWIDTH-1:0]            prdata_regw0;
reg [DWIDTH-1:0]            prdata_regw1;
reg [DWIDTH-1:0]            prdata_regw2;
reg [DWIDTH-1:0]            prdata_regw3;
reg [DWIDTH-1:0]            prdata_regw4;
              
reg  [DWIDTH-1:0]            prdata_regr0;
reg  [DWIDTH-1:0]            prdata_regr1;
reg  [DWIDTH-1:0]            prdata_regr2;

assign PREADY  = 1'b1;
assign PRDATA  = prdata_regw0 | prdata_regw1 | prdata_regw2 | prdata_regw3 | prdata_regw4 | prdata_regr0 | prdata_regr1 | prdata_regr2;


addr_dec decode
(
.PENABLE (PENABLE),
.PSEL (PSEL),
.PWRITE (PWRITE),
.PADDR (PADDR),
.PSLVERR (PSLVERR),
.pselw (pselw),
.pselr (pselr)
);  
   
   
 regw regw0
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PRESETn (PRESETn),
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
.PRESETn (PRESETn),
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
.PRESETn (PRESETn),
.PSEL (pselw[2]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw2), 
.regw_out (regw_out_2)
);

regw regw3
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PRESETn (PRESETn),
.PSEL (pselw[3]),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw3), 
.regw_out (regw_out_3)
);

regw regw4
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PSEL (pselw[4]),
.PRESETn (PRESETn),
.PWRITE (PWRITE),
.PWDATA (PWDATA),
.PRDATA (prdata_regw4), 
.regw_out (regw_out_4)
);

regr regr0
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PRESETn (PRESETn),
.PSEL (pselr[0]),
.PWRITE (PWRITE),
.PRDATA (prdata_regr0), 
.regr_in (regr_in_0)
);

regr regr1
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PRESETn (PRESETn),
.PSEL (pselr[1]),
.PWRITE (PWRITE),
.PRDATA (prdata_regr1), 
.regr_in (regr_in_1)
);

regr regr2
(
.PCLK (PCLK),
.PENABLE (PENABLE),
.PRESETn (PRESETn),
.PSEL (pselr[2]),
.PWRITE (PWRITE),
.PRDATA (prdata_regr2), 
.regr_in (regr_in_2)
);

 
endmodule





