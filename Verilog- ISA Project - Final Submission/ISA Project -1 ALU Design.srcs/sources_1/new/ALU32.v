`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 16:27:01
// Design Name: 
// Module Name: ALU32
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


module ALU32(input [3 : 0] alu_func, input [31 : 0] A, B, output [31 : 0] Y,output sign);
    wire [31:0] out0, out1, out2, out3, out4, out5, out6, out7,out8,out9, out10, out11, out12, out13, out14, out15;
    wire OVERFLOW, UNDERFLOW;
    wire [7:0] weight;
    
    assign sign=out12[0];
    
    ADD32 add(.A(A), .B(B), .C(out0), .cout(OVERFLOW));
    SUB32 sub(.A(A), .B(B), .diff(out1), .borrow(UNDERFLOW));
    NOT32 not32(.A(A), .C(out2));
    SLL32 sll(.A(A), .B(B), .C(out3));
    AND32 and32(.A(A), .B(B), .C(out4));
    OR32 or32(.A(A), .B(B), .C(out5));
    SRL32 srl(.A(A), .B(B), .C(out6));
    SRA32 sra(.A(A), .B(B), .C(out7));
    XOR32 xor32(.A(A), .B(B), .C(out8));
    NOR32 nor32(.A(A), .B(B),.C(out9));
    INCA32 incA(.A(A), .C(out10));
    DECA32 decA(.A(A), .C(out11));
    SLT32 sltbox(.A(A), .B(B),.out(out12));
    SGT32 sgtbox(.A(A),.B(B),.out(out13));
    LUI32 lui(.A(A), .out(out14));
    HAM_32 hamA(.A(A), .weight(weight));
    assign out15 = {24'd0, weight};
    MUX32BIT mux(.d0(out0), .d1(out1), .d2(out2), .d3(out3), .d4(out4), .d5(out5), .d6(out6), .d7(out7), .d8(out8), .d9(out9), .d10(out10), .d11(out11), .d12(out12), .d13(out13), .d14(out14), .d15(out15), .sel(alu_func), .y(Y));
endmodule

