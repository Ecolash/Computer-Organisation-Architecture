`timescale 1ns / 1ps

module test_MUL_TB;
    reg [7:0] q, m;
    reg clk, rst;
    wire [15:0] prod;
    wire done;

    MUL uut (.q(q), .m(m), .clk(clk), .rst(rst), .prod(prod), .done(done));

    initial begin
        clk = 0;
        forever #2 clk = ~clk;
    end

    initial begin
        rst = 1; q = 5; m = 6;
        #10 rst = 0;
        
        #100 rst = 1; q = -5; m = 5;
        #10 rst = 0;
        
        #100 rst = 1; q = -5; m = -5;
        #10 rst = 0;
        
        #100 $finish;
    end
    
endmodule