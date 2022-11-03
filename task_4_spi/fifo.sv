`timescale 1ns / 1ps


module fifo # (parameter DWIDTH = 0,
               parameter FIFO_DEPTH = 0,
               parameter counter_width = $clog2 (FIFO_DEPTH + 1))
( input wire                        CLK,
  input wire                        RESETn,
  input wire                        PUSH,
  input wire                        POP,
  input wire [DWIDTH - 1:0]         DATA_IN,
  output reg [DWIDTH - 1:0]         DATA_OUT,
  output reg                        EMPTY,
  output reg                        FULL,
  output reg [counter_width - 1:0]  CNT
);

  localparam pointer_width = $clog2 (FIFO_DEPTH);
  localparam [counter_width - 1:0] max_ptr = counter_width' (FIFO_DEPTH - 1);
  
  logic [pointer_width - 1:0] wr_ptr, rd_ptr;
  
  reg [DWIDTH - 1:0] DATA [0: FIFO_DEPTH - 1];

  always @ (posedge CLK or negedge RESETn )
    if (!RESETn) begin
      wr_ptr = '0;
      rd_ptr = '0; end
    else begin 
           if (PUSH)
      wr_ptr = (wr_ptr == max_ptr) ? '0 : wr_ptr + 1'b1;
           if (POP)
      rd_ptr = (rd_ptr == max_ptr) ? '0 : rd_ptr + 1'b1;
      end

  always @ (posedge FIFO_TX.PCLK) begin
    if (PUSH)
      DATA [wr_ptr] = DATA_IN;
    if (POP)
      DATA_OUT = DATA [rd_ptr];
end


  always @ (posedge CLK or negedge RESETn)
    if (!RESETn)
      CNT = '0;
    else if (PUSH & ~ POP)
      CNT <= CNT + 1'b1;
    else if (POP & ~ PUSH)
      CNT <= CNT - 1'b1;

  assign EMPTY = ~| CNT;
  assign FULL  = & CNT; 

endmodule