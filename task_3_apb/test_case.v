`timescale 1ns / 1ps

module test_case;

logic [7:0] readval;

initial
begin : main_test_flow
    i_tb.i_apb_driver.initialization();
    
    #5
    
    i_tb.i_apb_driver.write_data(4'b0001, 8'hAA); // Write AA at address 0001
    i_tb.i_apb_driver.write_data(4'b0010, 8'h55); // Write 55 at address 0010
    
    #15
    
    i_tb.i_apb_driver.read_data(4'b0001, readval); // Read value at address 0001 into variable 'readval'
    
    if (readval != 8'hAA)
    begin
        $display("ERROR");
        $stop;
    end
    
    #25
    
    $display("SUCCESS");
    $stop;
end

testbench i_tb();
apb_driver i_apb_driver();

endmodule
