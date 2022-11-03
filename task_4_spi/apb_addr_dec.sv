`timescale 1ns / 1ps

module apb_addr_dec #(parameter AWIDTH = 0,
                      parameter REGN  = 0)(
                      apb_intf DECOD,
                      output reg  [REGN-1:0]     pselw);
                   
integer nbit=0;

always @(*) begin
 DECOD.PSLVERR = 0;
 pselw = 'b0;
             if ( DECOD.PADDR > (REGN-1))
                    DECOD.PSLVERR = 1; 
                    else if (DECOD.PENABLE || DECOD.PSEL)    
                             for ( nbit = 0;  nbit < REGN; nbit = nbit + 1)   
                                                       if( nbit == DECOD.PADDR) pselw[nbit] = 1; 
                                                           else pselw[nbit] = 0; 
end
   
endmodule
