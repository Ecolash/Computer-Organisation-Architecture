`timescale 1ns / 1ps
module MUL_TB;
    reg clk, rst, run;
    reg [3:0] a, b;
    wire [7:0] ans;
    wire done_;

    MUL UUT(clk, rst, run, a, b, ans, done_);
    initial begin
        clk = 0; rst = 1; run = 0; a = 0; b = 0;
        #10 rst = 0; run = 1; a = 3; b = 4;
        #100 run = 0;

        rst = 1;
        #10 rst = 0; run = 1; a = 5; b = 6;
        #100 run = 0;

        rst = 1;
        #10 rst = 0; run = 1; a = 7; b = 8;
        #100 run = 0;

        rst = 1; 
        #10 rst = 0; run = 1; a = 9; b = 0;
        #100 $finish;
    end

    always #2 clk = ~clk;
    initial begin
        $monitor($time, " a=%d, b=%d, ans=%d done=%b",  a, b, ans, done_);
    end
    
endmodule