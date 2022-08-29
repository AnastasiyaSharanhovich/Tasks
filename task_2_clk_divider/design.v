`timescale 1ns / 1ps

module clk_divider #(parameter N= 4) // parametrizable data width N

		(
		output 	reg		clkout ,                     // outputs	
		input 	wire	[N-1 : 0] divmd,				        // inputs
		input 	wire	n_reset, 
		input 	wire	enable, 
		input 	wire	clk
		);
		
// Initialize

reg     [N-1 : 0]	cnt = 0 ;	
reg flag = 0;

initial begin
         clkout <= 1'b 0;
end

//// Always block to update the states
	always @ (posedge clk or negedge n_reset)  // to synchronous reset delete (or negedge n_reset)
		begin	
			if(n_reset == 1'b 0)   
					clkout <= 1'b 0;
			else if(enable == 1'b 1) 
			           case (flag)
                                      0:   case( cnt )
                                              divmd-1  : begin   cnt = 0; clkout <= 1'b 1 ; flag = 1;  end  
                                              default  : cnt = cnt + 1;          
                                           endcase 
                                      1:   case( cnt )
                                              divmd-1  : begin   cnt = 0; clkout <= 1'b 0 ; flag = 0;  end  
                                              default  : cnt = cnt + 1;          
                                           endcase
                      endcase
		end
endmodule
