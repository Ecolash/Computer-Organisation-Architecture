`timescale 1ns / 1ps

module adder(x, y, z);
    input [7:0] x, y;
    output [7:0] z;
    assign z = x + y;
endmodule

module subtr(x, y, z);
    input [7:0] x, y;
    output [7:0] z;
    assign z = x - y;
endmodule

module LUT(theta, k);
    input [7:0] theta;
    output reg [2:0] k;
    always @(*) begin
    case(theta)
        8'd0: k <= 3'b100;
        8'd10: k <= 3'b011;
        8'd20: k <= 3'b010;
        8'd30: k <= 3'b001;
        8'd40: k <= 3'b000;
        8'd60: k <= 3'b111;
        8'd70: k <= 3'b110;
        8'd80: k <= 3'b101;
        default k <= 3'b100;
    endcase
    end
endmodule

module shift(x, k, xs);
  input [7:0] x;
  input [2:0] k;
  output reg [7:0] xs;
    always @(*) begin
    case(k)
        3'b100: xs <= 8'b0;
        3'b011: xs <= {x[7], x[7], x[7], x[7:3]};
        3'b010: xs <= {x[7], x[7], x[7:2]};
        3'b001: xs <= {x[7], x[7:1]};
        3'b000: xs <= x;
        3'b111: xs <= {x[6:0], 1'b0};
        3'b110: xs <= {x[5:0], 2'b0};
        3'b101: xs <= {x[4:0], 3'b0};
        default xs <= 8'b0;
    endcase
    end
endmodule


module rotator(x, y, theta, x1, y1);
    input [7:0] x, y, theta;
    output [7:0] x1, y1;
    wire [2:0] k;
    
    wire [7:0] xs, ys;
    LUT T1(theta, k);
    shift X1(x, k, xs);
    shift Y1(y, k, ys);
    adder ADD1(y, xs, y1);
    subtr SUB1(x, ys, x1);
endmodule


