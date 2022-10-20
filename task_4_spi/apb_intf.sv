`timescale 1ns / 1ps

interface apb_intf #(parameter AWIDTH = 4,
                     parameter DWIDTH = 8)( 
      logic                           PRESETn, 
      logic                           PCLK,  
      logic                           PSEL,
      logic                           PENABLE,
      logic                           PWRITE,
      logic   [AWIDTH-1:0]            PADDR, 
      logic   [DWIDTH-1:0]            PWDATA,
        
      logic                           PSLVERR,
      logic   [DWIDTH-1:0]            PRDATA,
      logic                           PREADY
    );
    assign PREADY  = 1'b1;
endinterface
