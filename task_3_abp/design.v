`timescale 1ns / 1ps    

module top  #(parameter AWIDTH = 4,
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
              output reg  [DWIDTH-1:0]            PRDATA,
              output                              PREADY,
              output reg                          PSLVERR);
        
 
assign PREADY  = 1'b1;

addr_dec UUT ( 
/*
            .cnt_th(cnt_th),
            .dn_up(dn_up), 
            .timeout(timeout), 
            .cntout(cntout), 
            .n_reset(n_reset), 
            .enable(enable), 
            .clk(clk)*/
            );
            
regw__0 UUT (
                    /*    .cnt_th(cnt_th),
                        .dn_up(dn_up), 
                        .timeout(timeout), 
                        .cntout(cntout), 
                        .n_reset(n_reset), 
                        .enable(enable), 
                        .clk(clk)*/
                        );
 
 regr__0 U (/*
                                    .cnt_th(cnt_th),
                                    .dn_up(dn_up), 
                                    .timeout(timeout), 
                                    .cntout(cntout), 
                                    .n_reset(n_reset), 
                                    .enable(enable), 
                                    .clk(clk) */
                                    );

 ------/////-----------      
 
 
endmodule





