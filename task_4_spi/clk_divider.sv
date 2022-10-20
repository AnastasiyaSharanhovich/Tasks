`timescale 1ns / 1ps

module clk_divider #(parameter CLK_DIV=0)( 
                     input wire PClK,
                     input wire PRESETn,
                     output reg SPI_CLK
    );
    
localparam   N=$clog2(CLK_DIV+1);
reg     [N-1 : 0]	cnt = 0 ;  

initial begin
SPI_CLK = 0; end
    
	always @ (posedge PClK or negedge PRESETn) // Do I need a reset here ??
        begin    
            if(!PRESETn)   
                    SPI_CLK = 0;
                else begin
                    if (cnt==CLK_DIV-1) begin cnt=0; SPI_CLK=~SPI_CLK; end
                    cnt=cnt+1; 
                end
end
   
   
   
endmodule
