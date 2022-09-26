`timescale 1ns / 1ps

module apb_fifo #(
  parameter AWIDTH = 4,
  parameter DWIDTH = 8,
  parameter fifodeep = 256)(
   // system
   input             reset_n,
   input             enable,  

   // APB
   input             pclk,            
   input[AWIDTH-1:0] paddr,   
   input             pwrite,
   input             psel,
   input             penable,
   input      [DWIDTH-1:0] pwdata,
   output reg [DWIDTH-1:0] prdata,
   output            pready,
   output            pslverr,

   // Interface
   output            ff_write,
   output            ff_read,
   output reg        ff_clear,
  // input       [7:0] ff_rdata,
   input             ff_full,
   input             ff_empty,
  // input       [8:0] ff_level
  
);

wire apb_write = psel & penable & pwrite;
wire apb_read  = psel & ~pwrite;

   assign pready  = 1'b1;
   assign pslverr = 1'b0; 

  // assign ff_write = psel & penable & pwrite &??;
 //  assign ff_read = psel & penable & ~pwrite & ??;
   
   always @(posedge pclk or negedge reset_n)
   begin
      if (!reset_n)
      begin
         ff_clear <= 1'b0;
       //  prdata   <= DWIDTH'b0; -- how can i write it?
      end 
      else if (enable)
      begin         
         ff_clear <= 1'b0;
         
         if (apb_write)
         begin
            case (paddr)
            4'h4 :  ff_clear <= pwdata[0]; 
            endcase
         end 
         
         if (apb_read)
         begin
            case (paddr)
          //  4'h0 :  prdata  <= {24'h0,ff_rdata};
          //  4'h4 :  prdata  <= { 15'h0, ff_level, 6'h0,ff_full,ff_empty};
            endcase
         end
         else
            prdata <= 32'h0;
      end 
   end 
   
endmodule