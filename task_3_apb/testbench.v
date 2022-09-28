`timescale 1ns / 1ps

module testbench  #(parameter                
         AWIDTH = 4,               
         DWIDTH = 8              
 )
 (   output logic   [DWIDTH-1:0]            regr_in_0,
     output logic   [DWIDTH-1:0]            regr_in_1,
     output logic   [DWIDTH-1:0]            regr_in_2,
 
     output logic  [DWIDTH-1:0]            regw_out_0,
     output logic  [DWIDTH-1:0]            regw_out_1,
     output logic  [DWIDTH-1:0]            regw_out_2,
     output logic  [DWIDTH-1:0]            regw_out_3,
     output logic  [DWIDTH-1:0]            regw_out_4,
 
     output logic                    pclk ,
     output logic                    pslverr ,
     output logic                    presetn, 
     output logic                    pready, 
     output logic [DWIDTH-1:0]       prdata,
     output logic                    penable,
     output logic [AWIDTH-1:0]       paddr,
     output logic                    psel,
     output logic                    pwrite,
     output logic [DWIDTH-1:0]       pwdata
    
 );

initial begin
 #35   presetn =  1;        
 end

always begin
 #5 pclk=!pclk;
 end 

apb_driver i_apb_driver(
.pclk (pclk),
.prdata (prdata),
.penable (penable),
.paddr (paddr),
.psel (psel),
.pwrite (pwrite),
.pwdata (pwdata)
);

top i_top(
.regr_in_0 (regr_in_0),
.regr_in_1 (regr_in_1),
.regr_in_2 (regr_in_2),
.regw_out_0 (regw_out_0),
.regw_out_1 (regw_out_1),
.regw_out_2 (regw_out_2),
.regw_out_3 (regw_out_3),
.regw_out_4 (regw_out_4),
.PRESETn (presetn),
.PCLK (pclk),
.PSEL (psel),
.PENABLE (penable),
.PWRITE (pwrite),
.PADDR (paddr),
.PWDATA (pwdata),
.PSLVERR (pslverr),
.PRDATA (prdata),
.PREADY (pready)
);




endmodule