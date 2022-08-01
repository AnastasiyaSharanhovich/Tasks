`timescale 1ns / 1ps

module testflow();

// Inputs
    reg n_reset;
    reg enable;
    reg clk;
    reg dn_up;
    reg [3:0] cnt_th;
    
// Outputs

        wire timeout;
        wire [3:0] cntout;
        
task_1 UUT (
            .cnt_th(cnt_th),
            .dn_up(dn_up), 
            .timeout(timeout), 
            .cntout(cntout), 
            .n_reset(n_reset), 
            .enable(enable), 
            .clk(clk)
            );


// Initialize Inputs

initial begin
                    cnt_th = 12;
                    dn_up  = 0;
                    enable = 0;
                    n_reset = 0;
                    clk = 0;
                    
 #15   dn_up = 1;                   
 #35   n_reset =  1; 
 #35   enable = 1;           
 #105   enable = 0;
 #195   enable = 1;
 #300   dn_up = 0;
 
 end
        
always
  #10 clk = ~clk;
                
 
endmodule