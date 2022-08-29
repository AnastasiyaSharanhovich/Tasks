`timescale 1ns / 1ps

module addr_dec  #(parameter AWIDTH = 4,
                   parameter DWIDTH = 8,
                   parameter REGWN  = 5, 
                   parameter REGRN  = 3,
                   parameter REGR_ADDR_OFFSET = 5)(
                   input  wire                         PCLK,
                   input  wire                         PRESETn,
                   input  wire                         PSEL,
                   input  wire                         PWRITE,
                   input  wire                         PENABLE,
                   input  wire [AWIDTH-1:0]            PADDR,
                   output reg  [DWIDTH-1:0]            PRDATA,
                   output reg                          PSLVERR,
                   output reg  [REGWN-1:0]             pselw_w,
                   output reg  [REGWN-1:0]             pselw_r,
                   output reg  [REGRN-1:0]             pselr);
                   
                   integer bit;
                   

always @(posedge PCLK or PRESETn) begin
        if(!PRESETn) begin
            PSLVERR = 1;
            PRDATA = 0;
            end
        else if (( PADDR > (REGR_ADDR_OFFSET+REGRN-1)) || ((PWRITE == 0) && (PADDR >= REGR_ADDR_OFFSET )))
                    PSLVERR = 1; 
                    else if (PENABLE) begin    
                         if (PWRITE == 1'b 1 && PSEL == 1'b 1) //write RW-reg
                             for ( bit = 0;  bit < REGWN; bit = bit + 1) begin   
                                                       if( bit == PADDR) pselw_w[bit] = 1;
                                                           else pselw_w[bit] = 0; end
                                                          
                         if (PWRITE == 1'b 0 && PSEL == 1'b 1 && PADDR < REGR_ADDR_OFFSET ) //read RW-reg
                             for ( bit = 0;  bit < REGWN; bit = bit + 1) begin   
                                                       if( bit == PADDR) pselw_r[bit] = 1;
                                                           else pselw_r [bit] = 0; end
                                                           
                    
                         if (PWRITE == 1'b 0 && PSEL == 1'b 1 && PADDR >= REGR_ADDR_OFFSET ) //read RO-reg
                             for ( bit = 0;  bit < REGRN; bit = bit + 1) begin   
                                                       if( bit == PADDR-REGR_ADDR_OFFSET) pselr[bit] = 1;
                                                           else pselr[bit] = 0; end  
                    end
end

endmodule