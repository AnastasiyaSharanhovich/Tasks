`timescale 1ns / 1ps

module reg_status (
                      input  wire                         PRESETn,
                      input  wire                         PSEL,       
                      output wire                         STATUS_DATA );

reg  reg_status = 1'b0;
assign STATUS_DATA = reg_status;
                      
always @(PSEL or negedge PRESETn) begin
       if (!PRESETn)   reg_status = 1'b0;
             else if (PSEL) reg_status = 1'b1;
end

endmodule
