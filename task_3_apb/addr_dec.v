`timescale 1ns / 1ps

module addr_dec  #(parameter AWIDTH = 4,
                   parameter DWIDTH = 8,
                   parameter REGWN  = 5, 
                   parameter REGRN  = 3,
                   parameter REGR_ADDR_OFFSET = 5)(
                   input  wire                         PSEL,
                   input  wire                         PWRITE,
                   input  wire                         PENABLE,
                   input  wire [AWIDTH-1:0]            PADDR,
                   output reg                          PSLVERR,
                   output reg  [REGWN-1:0]             pselw,
                   output reg  [REGRN-1:0]             pselr);
                   
                   integer nbit=0;

always @(*) begin
 PSLVERR = 0;
 pselw = 'b0;
 pselr = 'b0;
             if (( PADDR > (REGR_ADDR_OFFSET+REGRN-1)) || ((PWRITE == 0) && (PADDR >= REGR_ADDR_OFFSET )))
                    PSLVERR = 1; 
                    else if (PENABLE || PSEL) begin    
                         if ( PADDR < REGR_ADDR_OFFSET ) // RW-reg
                             for ( nbit = 0;  nbit < REGWN; nbit = nbit + 1) begin   
                                                       if( nbit == PADDR) pselw[nbit] = 1;
                                                           else pselw[nbit] = 0; end


                         if ( PADDR >= REGR_ADDR_OFFSET ) // RO-reg
                             for ( nbit = 0;  nbit < REGRN; nbit = nbit + 1) begin   
                                                       if( nbit == PADDR-REGR_ADDR_OFFSET) pselr[nbit] = 1;
                                                           else pselr[nbit] = 0; end  
                    end
end
endmodule