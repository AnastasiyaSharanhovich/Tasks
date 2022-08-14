`timescale 1ns / 1ps

module regr()   
PSEL=0;
endmodule

module regw()
PSEL=0;
endmodule


module addr_dec #(
endmodule
    

module abp  #(parameter AWIDTH = 4,
              parameter DWIDTH = 8,
              parameter REGWN  = 5, 
              parameter REGRN  = 3,
              parameter REGR_ADDR_OFFSET = 5)(
              input  wire                         PRESETn,
              input  wire                         PCLK,
              input  wire                         PSEL,
              input  wire                         PENABLE,
              input  wire                         PWRITE,
              input  wire [AWIDTH-1:0]            PADDR,
              input  wire [DWIDTH-1:0]            PWDATA,
              output reg  [DWIDTH-1:0]            PRDATA,
              output reg                          PREADY,
              output reg                          PSLVERR);
        
 


always @(posedge PCLK or PRESETn) begin

        if(!PRESETn) begin
            PREADY = 0;
            PSLVERR = 0;
            PRDATA = 0;
        end
        else begin
            if(!PSEL && !PENABLE) begin  //IDLE
                PREADY = 0;
                PSLVERR = 0;
            end
            else if(PSEL && !PENABLE) begin   //SETUP
                    PREADY = 1;
                    PSLVERR = 0;
            end
            else if(PSEL && PENABLE) begin   //ACCESS
                    PREADY = 1;   
                    addr_dec(PSEL, PADDR);
                 if(PADDR < REGR_ADDR_OFFSET) begin
                 case (PWRITE)
                     0:  regr[PWDATA,PADDR]; 
                     1:  PRDATA = regr[PADDR];
                 endcase     
                        PSLVERR = 0;
                      end
                 else if((PWRITE == 0) && (PADDR >= REGR_ADDR_OFFSET ))  begin
                        PRDATA = regw[PADDR];
                        PSLVERR = 0;
                     end
                      else PSLVERR = 1;
                end
                
                @(posedge PCLK);
                PREADY = 0;
            end
        end
    end
    
endmodule





