`timescale 1ns / 1ps

module MUL_TB;
    reg clk, rst, run;
    reg [7:0] a, b;
    wire [15:0] ans;
    wire done_;

    MUL2 UUT(clk, rst, run, a, b, ans, done_);
    initial begin
        clk = 0; rst = 1; run = 0; a = 0; b = 0;
        #10 rst = 0; run = 1; a = 5; b = 6;
        #200 run = 0;

        rst = 1;
        #10 rst = 0; run = 1; a = 2; b = 22;
        #200 run = 0;
        
        rst = 1;
        #10 rst = 0; run = 1; a = 32; b = 32;
        #200 run = 0;
        
        rst = 1;
        #10 rst = 0; run = 1; a = 21; b = 21;
        #200 run = 0;

        rst = 1; 
        #10 rst = 0; run = 1; a = 9; b = 0;
        #200 $finish;
    end

    always #2 clk = ~clk;
    initial begin
        $monitor($time, " a=%d, b=%d, ans=%d done=%b",  a, b, ans, done_);
    end
    
endmodule