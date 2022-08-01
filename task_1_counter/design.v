`timescale 1ns / 1ps

module task_1 #(parameter N= 4) // parametrizable data width N

		(
		output 	reg		timeout ,                     // outputs	
		output 	reg 	[N-1 : 0]	cntout ,	
		input 	wire	dn_up,				        // inputs
		input 	wire	n_reset, 
		input 	wire	enable, 
		input 	wire	clk,
		input   wire    [N-1 : 0]	cnt_th
		);
		
// Initialize

reg     [N-1 : 0]	cnt = 0 ;	

initial begin
         timeout= 1'b 0;
         cntout = {N {1'b 0} };
end

//// Always block to update the states
	always @ (posedge clk or negedge n_reset)  // to synchronous reset delete (or negedge n_reset)
		begin	
			if(n_reset == 1'b 0)   
			   begin
					cnt = 0;
                    cntout <= {N {1'b 0} };
					timeout <= 1'b 0;
				end
			else if(enable == 1'b 1) 
                     case( dn_up )
                         1'b 1 :  begin 
                                         case( cnt )
                                              cnt_th-1  : begin   cnt <= 0;  timeout <= 1'b 1 ;  end  
                                              default : begin   cnt = cnt + 1; timeout <= 1'b 0 ;  end           
                                          endcase 
                                  end
                         1'b 0 :  begin 
                                         case( cnt )
                                              0       : begin   cnt <= cnt_th-1;  timeout <= 1'b 1 ;  end
                                              default : begin   cnt = cnt - 1; timeout <= 1'b 0 ;  end           
                                         endcase 
                                  end
                     endcase
		end
	always @ (cnt) cntout <= cnt;
endmodule
