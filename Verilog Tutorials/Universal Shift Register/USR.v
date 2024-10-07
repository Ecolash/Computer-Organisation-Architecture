`timescale 1ns / 1ps

module DFF(D, data, clk, reset);
    input D, clk;
    input reset;
    output reg data;
    
    always @(posedge clk or negedge reset) begin
        if (reset == 1'b0) data <= 1'b0;
        else data <= D;
    end
endmodule

module MUX8_1(d, sel, y);
    input [0:7] d; 
    input [2:0] sel; 
    output reg y;    
    always @(*) begin
        case (sel)
            3'b000: y = d[0]; 
            3'b001: y = d[1]; 
            3'b010: y = d[2]; 
            3'b011: y = d[3]; 
            3'b100: y = d[4]; 
            3'b101: y = d[5]; 
            3'b110: y = d[6]; 
            3'b111: y = d[7]; 
            default: y = 1'b0; 
        endcase
    end
endmodule

// Universal Shift Register Functionality
// ----------------------------------------
// Select Inputs  | Operation
// ----------------------------------------
// 000            | Hold current state
// 001            | Shift right (with 0)
// 010            | Shift left (with 0)
// 011            | Rotate right 
// 100            | Rotate left
// 101            | Shift right with load 1
// 110            | Shift left with load 1
// 111            | Load data from parallel input


module USR_4BIT(data, clk, clear, select, parallel_in);
    input clk, clear;
    input [2:0] select; 
    input [0:3] parallel_in; 
    output [0:3] data;
    wire [0:3] D_temp;

    MUX8_1 M1({data[0],    1'b0, data[1], data[3], data[1],    1'b1, data[1], parallel_in[0]}, select, D_temp[0]);
    MUX8_1 M2({data[1], data[0], data[2], data[0], data[2], data[0], data[2], parallel_in[1]}, select, D_temp[1]);
    MUX8_1 M3({data[2], data[1], data[3], data[1], data[3], data[1], data[3], parallel_in[2]}, select, D_temp[2]);
    MUX8_1 M4({data[3], data[2],    1'b0, data[2], data[0], data[2],    1'b1, parallel_in[3]}, select, D_temp[3]);

    DFF D1(D_temp[0], data[0], clk, clear);
    DFF D2(D_temp[1], data[1], clk, clear);
    DFF D3(D_temp[2], data[2], clk, clear);
    DFF D4(D_temp[3], data[3], clk, clear);
endmodule
