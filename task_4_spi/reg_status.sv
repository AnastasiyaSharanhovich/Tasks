`timescale 1ns / 1ps

module reg_status #(parameter WIDTH = 4)(
                  //    input  wire                         PSEL,       
                      output wire                         TXFIFO_FULL,
                      output wire                         TXFIFO_EMPTY,
                      output wire                         RXFIFO_FULL,
                      output wire                         RXFIFO_EMPTY );

reg [WIDTH-1:0] reg_status = 'b0;
assign TXFIFO_FULL = reg_status[0];
assign TXFIFO_EMPTY = reg_status[1];
assign RXFIFO_FULL = reg_status[2];
assign RXFIFO_EMPTY = reg_status[2];

endmodule
