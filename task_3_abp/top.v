`timescale 1ns / 1ps    

module apb  #(parameter AWIDTH = 4,
              parameter DWIDTH = 8,
              parameter REGWN  = 5, 
              parameter REGRN  = 3,
              parameter REGR_ADDR_OFFSET = 5)(
              input  wire                         PRESETn,
              input  wire                         PCLK,
              input  wire [REGWN+REGRN-1:0]       PSEL,
              input  wire                         PENABLE,
              input  wire                         PWRITE,
              input  wire [AWIDTH-1:0]            PADDR,
              output reg  [DWIDTH-1:0]            PRDATA,
              output                              PREADY,
              output reg                          PSLVERR);
        
 
assign PREADY  = 1'b1;

integer my_int_addr;
always @( PADDR )
    my_int_addr = PADDR;

always @(posedge PCLK or PRESETn) begin
        if(!PRESETn) begin
            PSLVERR = 1;
            PRDATA = 0;
            end
        else if(PSEL && PENABLE && ((my_int_addr > (REGR_ADDR_OFFSET+REGRN-1)) || ((PWRITE == 0) && (my_int_addr >= REGR_ADDR_OFFSET ))) ) 
        PSLVERR = 1; 
                else PSLVERR = 0;
end
       
endmodule





