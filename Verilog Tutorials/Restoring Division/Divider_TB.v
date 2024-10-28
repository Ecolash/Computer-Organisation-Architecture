`timescale 1ns / 1ps

module restoring_div_tb;
    reg [7:0] A, B;
    reg clk, rst;
    wire done;
    wire [7:0] Q, R;

    restoring_div uut (
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .done(done),
        .Q(Q),
        .R(R)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        A = 8'd25;
        B = 8'd3;
        #10 rst = 0;
        #100;

        rst = 1;
        A = 8'd50;
        B = 8'd4;
        #10 rst = 0;
        #100;

        rst = 1;
        A = 8'd101;
        B = 8'd7;
        #10 rst = 0;
        #100 $finish;
    end
endmodule
