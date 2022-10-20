
module regw  #( parameter DWIDTH = 0)(
                      input  wire                         PENABLE,
                      input  wire                         PWRITE,
                      input  wire                         PRESETn,
                      input  wire                         PSEL,       
                      input  wire  [DWIDTH-1:0]           PWDATA,       
                      output wire  [DWIDTH-1:0]           PRDATA,
                      output wire  [DWIDTH-1:0]           regw_out );
                   
reg [DWIDTH-1:0]   regw_RW;
assign regw_out = regw_RW;
assign PRDATA = (!PWRITE && PSEL && PENABLE) ? regw_RW : 'b0;

always @(PSEL or negedge PRESETn) begin
     if (!PRESETn)   regw_RW = 'b0;
     else if (PWRITE && PSEL && !PENABLE) regw_RW=PWDATA;
end
     
endmodule