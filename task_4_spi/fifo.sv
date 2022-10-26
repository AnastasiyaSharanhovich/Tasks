`timescale 1ns / 1ps


module fifo # (parameter DWIDTH = 0,
               parameter FIFO_DEPTH = 0,
               parameter counter_width = $clog2 (FIFO_DEPTH + 1))
( apb_intf FIFO_TX,
 // apb_int FIFO_RX
  input wire                        PUSH,
  input wire                        POP,
 // input  [DWIDTH - 1:0] write_data_from_spi,
  output reg [DWIDTH - 1:0]         read_data_to_spi,
  output reg                        EMPTY,
  output reg                        FULL,
  output reg [counter_width - 1:0]  cnt
);

  localparam pointer_width = $clog2 (FIFO_DEPTH);
  localparam [counter_width - 1:0] max_ptr = counter_width' (FIFO_DEPTH - 1);
  
  logic [pointer_width - 1:0] wr_ptr, rd_ptr;
  
  reg [DWIDTH - 1:0] DATA [0: FIFO_DEPTH - 1];

  always @ (posedge FIFO_TX.PCLK)
    if (!FIFO_TX.PRESETn) begin
      wr_ptr = '0;
      rd_ptr = '0; end
    else if (PUSH)
      wr_ptr = (wr_ptr == max_ptr) ? '0 : wr_ptr + 1'b1;
       else if (POP)
         rd_ptr = (rd_ptr == max_ptr) ? '0 : rd_ptr + 1'b1;

  always @ (posedge FIFO_TX.PCLK) begin
    if (PUSH)
      DATA [wr_ptr] = FIFO_TX.PWDATA;
    if (POP)
      read_data_to_spi = DATA [rd_ptr];
end


  always @ (posedge FIFO_TX.PCLK)
    if (!FIFO_TX.PRESETn)
      cnt = '0;
    else if (PUSH & ~ POP)
      cnt <= cnt + 1'b1;
    else if (POP & ~ PUSH)
      cnt <= cnt - 1'b1;

  assign EMPTY = ~| cnt;
  assign FULL  = ~& cnt; 

endmodule