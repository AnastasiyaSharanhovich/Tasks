`timescale 1ns / 1ps

interface apb_intf #(parameter AWIDTH = 4,
                     parameter DWIDTH = 8)( 
       input PCLK,
       input PRESETn
    );
    logic                           PSEL;
    logic                           PENABLE;
    logic                           PWRITE;
    logic   [AWIDTH-1:0]            PADDR;
    logic   [DWIDTH-1:0]            PWDATA;
    logic                           PSLVERR;
    logic   [DWIDTH-1:0]            PRDATA;
    logic                           PREADY;
    

    modport TB_EX ( input PCLK, PRESETn, PSLVERR, PRDATA, PREADY, output PSEL, PENABLE, PWRITE, PADDR, PWDATA ); //from TB perspective
    
    modport APB_EX ( input PCLK, PRESETn, PSEL, PENABLE, PWRITE, PADDR, PWDATA, output PREADY); //from top perspective
    
    modport DECOD_EX ( input PSEL, PENABLE, PADDR, output PSLVERR); //from apb_addr_dec perspective
    
    modport FIFO_TX_EX ( input PCLK, PRESETn, PWDATA); //from fifo_tx perspective
    
    modport FIFO_RX_EX ( input PCLK, PRESETn, output PRDATA); //from fifo_rx perspective
    
endinterface
