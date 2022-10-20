`timescale 1ns / 1ps

module fifo #(    parameter REGTX_ADDR_OFFSET = 0, 
                  parameter REGSTATUS_ADDR_OFFSET = 0,
                  parameter FIFO_DEPTH    = 0,
                  parameter REGN    = 0)
       ( input wire               PCLK,
         input wire               CNT,
         input wire  [FIFO_DEPTH-1:0]   SEL_NUMBER_IN,
         output reg  [FIFO_DEPTH-1:0]   SEL_NUMBER_OUT,
         output reg               EMPTY,
         output reg               FULL
       );
       
 localparam pointer_width = $clog2 (FIFO_DEPTH);
 logic [pointer_width - 1:0] wr_ptr = 0, rd_ptr = 0;
 //reg [width - 1:0] data [0: depth - 1]; MASSIVE WHERE I PUT wr_ptr TO SEL_NUMBER_OUT
      
always @ (SEL_NUMBER_IN) begin
   if (CNT == FIFO_DEPTH) FULL = 1; 
   if (CNT == 0) EMPTY =1; 
   if (SEL_NUMBER_IN > REGSTATUS_ADDR_OFFSET &&   SEL_NUMBER_IN <= REGTX_ADDR_OFFSET) wr_ptr = wr_ptr+1;
end

endmodule