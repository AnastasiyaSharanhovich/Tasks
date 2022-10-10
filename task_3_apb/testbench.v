`timescale 1ns / 1ps

module testbench  #(parameter                
         AWIDTH = 4,               
         DWIDTH = 8              
 );
     logic   [DWIDTH-1:0]            regr_in_0;
     logic   [DWIDTH-1:0]            regr_in_1;
     logic   [DWIDTH-1:0]            regr_in_2;
 
     logic  [DWIDTH-1:0]            regw_out_0;
     logic  [DWIDTH-1:0]            regw_out_1;
     logic  [DWIDTH-1:0]            regw_out_2;
     logic  [DWIDTH-1:0]            regw_out_3;
     logic  [DWIDTH-1:0]            regw_out_4;
 
     logic                    pclk;
     logic                    pslverr;
     logic                    presetn; 
     logic                    pready; 
     logic [DWIDTH-1:0]       prdata;
     logic                    penable;
     logic [AWIDTH-1:0]       paddr;
     logic                    psel;
     logic                    pwrite;
     logic [DWIDTH-1:0]       pwdata;
    
 initial begin
 presetn =  0;
      #5   presetn =  1;        
 end

initial begin
pclk = 1;
forever   #5 pclk = !pclk;      
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