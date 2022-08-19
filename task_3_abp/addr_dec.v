`timescale 1ns / 1ps

module decod #( parameter REGWN  = 5, 
                parameter REGRN  = 3,
                parameter REGR_ADDR_OFFSET = 5)(
                input  sel_vector[REGWN+REGRN-1:0], 
                input  mode, 
                input  addr, 
                output rewhrite_w[REGWN-1:0], 
                output rewhrite_r[REGWN-1:0],
                output status[REGRN-1:0]);

               integer bit;

if (mode == 1'b 1 && sel_vector[addr] == 1'b 1) //write RW-reg
         for ( bit = 0;  bit < REGWN; bit = bit + 1) begin   
                                   if( bit == addr) rewhrite_w[bit] = 1;
                                       else rewhrite_w[bit] = 0; end
                                      
if (mode == 1'b 0 && sel_vector[addr] == 1'b 1) //read RW-reg
         for ( bit = 0;  bit < REGWN; bit = bit + 1) begin   
                                   if( bit == addr) rewhrite_r[bit] = 1;
                                       else rewhrite_r[bit] = 0; end
                                       

if (mode == 1'b 0 && sel_vector[addr-REGR_ADDR_OFFSET] == 1'b 1) //read RO-reg
         for ( bit = 0;  bit < REGRN; bit = bit + 1) begin   
                                   if( bit == addr-REGR_ADDR_OFFSET) status[bit] = 1;
                                       else status[bit] = 0; end                                      


endmodule



module addr_dec  #(parameter AWIDTH = 4,
                   parameter REGWN  = 5, 
                   parameter REGRN  = 3,
                   parameter REGR_ADDR_OFFSET = 5)(
                   input  wire                         PCLK,
                   input  wire                         PSLVERR,
                   input  wire [REGWN+REGRN-1:0]       PSEL,
                   input  wire                         PWRITE,
                   input  wire [AWIDTH-1:0]            PADDR,
                   output reg  [REGWN-1:0]             pselw_w,
                   output reg  [REGWN-1:0]             pselw_r,
                   output reg  [REGRN-1:0]             pselr);
                   
integer my_int_addr;
always @( PADDR )
    my_int_addr = PADDR;

always @(posedge PCLK) begin
                       if(!PSLVERR)    
                                       decod d1(  .sel_vector (PSEL[REGWN+REGRN-1:0]),   
                                                  .mode       (PWRITE),   
                                                  .addr       (my_int_addr),
                                                  .rewhrite_w   (pselw_w[REGWN-1:0]), 
                                                  .rewhrite_r   (pselw_r[REGWN-1:0]), 
                                                  .status     (pselr[REGRN-1:0])); 
end

endmodule