`timescale 1ns / 1ps

module Fibonacci_TB( );
    reg clk;
    reg [3:0] k;
    reg rst;
    
    wire [15:0] out;
    Fibonacci UUT(clk, rst, k, out);
    
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
        k = 4'b0101;
        #10 rst = 1;
        #100;
        
        #10 rst = 0;
        k = 4'b1000;
        #10 rst = 1;
        #100;
        $stop;
    end
    
    initial $monitor("Time = %2t ns| rst = %b | curr = %d",  $time, clk, rst, out);
endmodule
