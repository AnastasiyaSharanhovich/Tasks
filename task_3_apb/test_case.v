`timescale 1ns / 1ps

module test_case#(parameter                
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
 
     logic                    pclk ;
     logic                    pslverr ;
     logic                    presetn; 
     logic                    pready;
     logic [DWIDTH-1:0]       prdata;
     logic                    penable;
     logic [AWIDTH-1:0]       paddr;
     logic                    psel;
     logic                    pwrite;
     logic [DWIDTH-1:0]       pwdata;




logic [7:0] readval;

initial
begin : main_test_flow
    i_tb.i_apb_driver.initialization();
    
    #5
    
    i_tb.i_apb_driver.write_data(4'b0001, 8'hAA); // Write AA at address 0001
    i_tb.i_apb_driver.write_data(4'b0010, 8'h55); // Write 55 at address 0010
    
    #15
    
    i_tb.i_apb_driver.read_data(4'b0001, readval); // Read value at address 0001 into variable 'readval'
    
    if (readval != 8'hAA)
    begin
        $display("ERROR");
        $stop;
    end
    
    #25
    
    $display("SUCCESS");
    $stop;
end

testbench i_tb(
.regr_in_0 (regr_in_0),
.regr_in_1 (regr_in_1),
.regr_in_2 (regr_in_2),
.regw_out_0 (regw_out_0),
.regw_out_1 (regw_out_1),
.regw_out_2 (regw_out_2),
.regw_out_3 (regw_out_3),
.regw_out_4 (regw_out_4),
.pclk (pclk),
.pslverr (pslverr),
.presetn (presetn),
.pready (pready),
.prdata (prdata),
.penable (penable),
.paddr (paddr),
.psel (psel),
.pwrite (pwrite),
.pwdata (pwdata)
);

endmodule
