`timescale 1ns / 1ps

module reg_cnt #( parameter FIFO_DEPTH                = 0,
                  parameter N=$clog2(FIFO_DEPTH+1))(


                      input  wire                         PRESETn,
                      input  wire                         PSEL,       
      
                      output wire  [N-1:0]                CNT_DATA);
                      
             
reg [N-1:0]   reg_cnt =0;
assign CNT_DATA = reg_cnt;
                      
always @(PSEL or negedge PRESETn) begin
       if (!PRESETn)   reg_cnt = 'b0;
             else if (PSEL) reg_cnt=reg_cnt+1;   
end


endmodule
