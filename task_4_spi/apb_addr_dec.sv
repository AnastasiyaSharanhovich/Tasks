`timescale 1ns / 1ps

module apb_addr_dec #(parameter AWIDTH = 0,
                      parameter REGN  = 0,
                      parameter REGTX_ADDR_OFFSET = 0)(
                   input  wire                         PSEL,
                   input  wire                         PENABLE,
                   input  wire [AWIDTH-1:0]            PADDR,
                   output reg                          PSLVERR,
                   output reg  [REGN-1:0]              pselw);
                   
                   integer nbit=0;

always @(*) begin
 PSLVERR = 0;
 pselw = 'b0;
             if ( PADDR > (REGN-1))
                    PSLVERR = 1; 
                    else if (PENABLE || PSEL) begin    
                         if ( PADDR<=REGTX_ADDR_OFFSET ) // REGTX NUMBER
                             for ( nbit = 0;  nbit < REGN; nbit = nbit + 1) begin   
                                                       if( nbit == PADDR) begin pselw[nbit] = 1; pselw[4]=1; end
                                                           else pselw[nbit] = 0; end
                                                           
                         if ( PADDR>REGTX_ADDR_OFFSET ) // REGRX NUMBER
                             for ( nbit = 0;  nbit < REGN; nbit = nbit + 1) begin   
                                                       if( nbit == PADDR) begin pselw[nbit] = 1; pselw[5]=1; end
                                                           else pselw[nbit] = 0; end

                    end
end
   
endmodule
