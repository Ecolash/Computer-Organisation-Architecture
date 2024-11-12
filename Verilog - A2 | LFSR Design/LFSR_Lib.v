`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2024 15:11:52
// Design Name: 
// Module Name: DFF
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


module DFF(clk, rst, D, Q);
    input wire clk, rst, D;
    output reg Q;
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            begin
                Q <= 1'b0;
            end
        else
            begin
                Q <= D;
            end
    end
endmodule

module MUX_2TO1 (in1, in2, sel, out);
 input in1, in2; 
 input sel;
 output reg out;
 always @(*)
    begin
        case (sel)
            1'b0: out = in1;
            1'b1: out = in2;
            default: out = 1'bx;
        endcase
    end
endmodule