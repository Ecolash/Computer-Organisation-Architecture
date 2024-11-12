`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2024 15:13:01
// Design Name: 
// Module Name: LFSR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LFSR(seed,rst,sel,clk,state);
    input [3:0] seed;
    input wire rst,sel,clk;
    output [3:0] state;
    
    wire w1int, w2int, w3int, w4int;
    wire w1, w2, w3, w4, w5;

    MUX_2TO1 M3(.in1(seed[3]), .in2(w1), .sel(sel), .out(w1int));
    MUX_2TO1 M2(.in1(seed[2]), .in2(w2), .sel(sel), .out(w2int));
    MUX_2TO1 M1(.in1(seed[1]), .in2(w3), .sel(sel), .out(w3int));
    MUX_2TO1 M0(.in1(seed[0]), .in2(w4), .sel(sel), .out(w4int));
    
    xor XR(w1, w4, w5);
    DFF D3(.clk(clk), .rst(rst), .D(w1int), .Q(w2));
    DFF D2(.clk(clk), .rst(rst), .D(w2int), .Q(w3));
    DFF D1(.clk(clk), .rst(rst), .D(w3int), .Q(w4));
    DFF D0(.clk(clk), .rst(rst), .D(w4int), .Q(w5));

    assign state[3] = w2;
    assign state[2] = w3;
    assign state[1] = w4;
    assign state[0] = w5;

endmodule