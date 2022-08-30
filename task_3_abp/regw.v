`timescale 1ns / 1ps

module regw_RW  #(    parameter DWIDTH = 8)(
                      input  wire                         PCLK,
                      input  wire                         PENABLE,
                      input  wire                         PWRITE,
                      input  wire                         PSEL,       
                      input  wire [DWIDTH-1:0]            PWDATA,       
                      output reg  [DWIDTH-1:0]            PRDATA,
                      output reg  [DWIDTH-1:0]            regw_out );
                   
reg [DWIDTH-1:0]   regw;

always @(posedge PCLK) begin
   case ( PWRITE ) 
          0:  if (PSEL == 1 && PENABLE == 1'b 1) begin regw_out = regw; PRDATA = regw; end
          1:  regw=PWDATA;
   endcase               
end

endmodule

