`timescale 1ns / 1ps

module GCD_tb;
    reg clk, rst, run;
    reg [3:0] xin, yin;
    wire [3:0] gcd;
    wire done;

    GCD uut (.clk(clk), .rst(rst), .run(run), .xin(xin), .yin(yin), .gcd(gcd), .done(done));

    always #5 clk = ~clk;
    initial begin
        clk = 0; rst = 1; run = 0; xin = 4'b0000; yin = 4'b0000; #10;
        rst = 0; run = 1; xin = 4'b1010; yin = 4'b0110; #300;
        rst = 1; #10; rst = 0; run = 1; xin = 4'b1100; yin = 4'b1000; #300;
        rst = 1; #10; rst = 0; run = 1; xin = 4'b1101; yin = 4'b0111; #300;
        $stop;
    end
endmodule
