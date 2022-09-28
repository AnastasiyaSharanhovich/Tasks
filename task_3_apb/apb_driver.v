`timescale 1ns / 1ps

module apb_driver
              #(parameter                
                       AWIDTH = 4,               
                       DWIDTH = 8              //data width
               )
               (
                  // General signals
                   input                     pclk ,
                  // APB signals
                   input        [DWIDTH-1:0] prdata,
                   output logic              penable,
                   output logic [AWIDTH-1:0] paddr,
                   output logic              psel,
                   output logic              pwrite,
                   output logic [DWIDTH-1:0] pwdata
                  
               );
     
   
   task initialization ();
        penable = 0;
        paddr = 0;
        psel = 0;
        pwrite = 0;
        pwdata = 0;
   endtask: initialization 
   
   
      task write_data
               (
                    input  [AWIDTH-1:0] addr,
                    input  [DWIDTH-1:0] data
               );
               
               // SETUP STATE
               @(posedge pclk);
               #1;
               psel = 1;
               penable = 0;
               pwrite = 1;
               paddr =  addr;
               pwdata = data;
               
               $display("Write single data: addr =%d, data =%d",addr, data);
               
               
               // WRITE STATE
               @(posedge pclk);
               #1;
               penable = 1;
               
               @(posedge pclk);
               #1;
               psel = 0;
               penable = 0;
           
      endtask: write_data
    
 
    
   task read_data
            (
                 input  [AWIDTH-1:0] addr, 
                 output [DWIDTH-1:0] rdata 
            );
            
                // SETUP STATE
                @(posedge pclk);
                #1;
                psel = 1;
                penable = 0;
                pwrite = 0;
                paddr = addr;
                
                // READ STATE
                @(posedge pclk);
                #1;
                penable = 1;
             
                
                @(posedge pclk);
                #1;
                psel = 0;
                penable = 0;
                rdata = prdata;
                
                $display(" Read: addr =%d, data =%b",addr, rdata); 
               
   endtask: read_data
                    
endmodule
