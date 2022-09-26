`timescale 1ns / 1ps

module testbench;

 reg presetn;
 reg pclk;
 
initial begin
              
 #35   presetn =  1;        

 end

always
  #5 pclk=!pclk;
  
test_case i_test_case();

endmodule