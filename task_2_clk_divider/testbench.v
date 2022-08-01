`timescale 1ns / 1ps

module testflow();

// Inputs
    reg n_reset;
    reg enable;
    reg clk;
    reg [3:0] divmd;
    
// Outputs
        wire clkout;
        
clk_divider UUT (
            .clkout(clkout),
            .divmd(divmd), 
            .n_reset(n_reset), 
            .enable(enable), 
            .clk(clk)
            );


// Initialize Inputs

initial begin

                    divmd  = 3;
                    enable = 0;
                    n_reset = 0;
                    clk = 0;
                    
              
 #35   n_reset =  1;    enable = 1;           


 
 end
        
always
  #10 clk = ~clk;
                
 
endmodule
