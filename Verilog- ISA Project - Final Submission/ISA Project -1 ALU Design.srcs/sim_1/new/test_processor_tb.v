`timescale 1ns/1ps

module test_processor_tb;
    reg[3:0] reg_select;
    reg clk,rst;
    wire[31:0] regval;
    
    processor_top uut(.regval(regval),.clk(clk),.rst(rst),.reg_select(reg_select));
    
    always #5 clk=~clk;
    
    initial begin
        clk=0;
        reg_select=4'd2;
        rst=1;
        
        #10 rst=0;
        
        
    end
    
endmodule
