`timescale 1ns/1ps

//--------------------------------------------------------------------
// Design Specifications:
//--------------------------------------------------------------------

// This Verilog code generates the Fibonacci sequence up to the K-th term.
// The design consists of three modules:

// 1. Fibonacci: Generates the Fibonacci sequence based on the input clock and reset signals.
// 2. clkdiv: A clock divider that slows down the input clock signal.
// 3. wrapper: Integrates the Fibonacci and clkdiv modules to produce the final output.

// INPUTS - clock, reset, 4-bit K
// OUTPUT - F0, F1, F2 ... Fk in cycle
//--------------------------------------------------------------------
module Fibonacci(clk, rst, k, out);
    input clk;
    input rst;
    input [3:0] k;
    output [15:0] out;
    reg [15:0] num1, num2;
    reg [3:0] count;
    
    always @(posedge clk or negedge rst)
    begin
        if (~rst) begin
            num1 <= 16'h0000;
            num2 <= 16'h0001;
            count <= 0;
        end else begin 
            if (count < k - 1)
            begin 
                num1 <= num2;
                num2 <= num1 + num2;
                count <= count + 1;
            end else begin 
                num1 <= 16'h0000;
                num2 <= 16'h0001;
                count <= 0;
            end
        end
    end
    assign out = num1 + num2;
endmodule
//--------------------------------------------------------------------
module clkdiv (clk_in, clk_out, rst);
    input wire clk_in;
    input wire rst;
    output reg clk_out;
    reg [25:0] count; 
    
    always @(posedge clk_in or posedge rst) begin
        if (~rst) begin
            count <= 26'b0;
            clk_out <= 1'b0;
        end else begin
            count <= count + 1'b1;
            if (count == 26'h3FFFFFFFF) begin 
                clk_out <= ~clk_out;  
                count <= 26'b0;       
            end
        end
    end
endmodule
//--------------------------------------------------------------------
module wrapper(clk, rst, k, out);
    input clk;
    input rst;
    input [3:0] k;
    output [15:0] out;
    wire slwclk;
    
    clkdiv C1(clk, slwclk, rst);
    Fibonacci F(slwclk, rst, k, out);
 endmodule
