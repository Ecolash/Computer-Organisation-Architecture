module mux2X1 (
    input in0,
    input in1,
    input sel,
    output out
);
    assign out = (sel == 1'b0) ? in0 : in1;
endmodule

module barrel_shifter_v1 (
    input [7:0] a,
    input [2:0] amt,
    output reg [7:0] y
);
    always @(*) begin
        case (amt)
            3'b000: y = a;
            3'b001: y = {a[0], a[7:1]};
            3'b010: y = {a[1:0], a[7:2]};
            3'b011: y = {a[2:0], a[7:3]};
            3'b100: y = {a[3:0], a[7:4]};
            3'b101: y = {a[4:0], a[7:5]};
            3'b110: y = {a[5:0], a[7:6]};
            3'b111: y = {a[6:0], a[7]};
            default: y = a;
        endcase
    end
endmodule

module barrel_shifter_v2 (
    input [7:0] in,
    input [2:0] ctrl,
    output [7:0] out
);
    wire [7:0] x, y;

    // 4-bit shift right
    mux2X1 ins_17 (.in0(in[7]), .in1(1'b0), .sel(ctrl[2]), .out(x[7]));
    mux2X1 ins_16 (.in0(in[6]), .in1(1'b0), .sel(ctrl[2]), .out(x[6]));
    mux2X1 ins_15 (.in0(in[5]), .in1(1'b0), .sel(ctrl[2]), .out(x[5]));
    mux2X1 ins_14 (.in0(in[4]), .in1(1'b0), .sel(ctrl[2]), .out(x[4]));
    mux2X1 ins_13 (.in0(in[3]), .in1(in[7]), .sel(ctrl[2]), .out(x[3]));
    mux2X1 ins_12 (.in0(in[2]), .in1(in[6]), .sel(ctrl[2]), .out(x[2]));
    mux2X1 ins_11 (.in0(in[1]), .in1(in[5]), .sel(ctrl[2]), .out(x[1]));
    mux2X1 ins_10 (.in0(in[0]), .in1(in[4]), .sel(ctrl[2]), .out(x[0]));

    // 2-bit shift right
    mux2X1 ins_27 (.in0(x[7]), .in1(1'b0), .sel(ctrl[1]), .out(y[7]));
    mux2X1 ins_26 (.in0(x[6]), .in1(1'b0), .sel(ctrl[1]), .out(y[6]));
    mux2X1 ins_25 (.in0(x[5]), .in1(x[7]), .sel(ctrl[1]), .out(y[5]));
    mux2X1 ins_24 (.in0(x[4]), .in1(x[6]), .sel(ctrl[1]), .out(y[4]));
    mux2X1 ins_23 (.in0(x[3]), .in1(x[5]), .sel(ctrl[1]), .out(y[3]));
    mux2X1 ins_22 (.in0(x[2]), .in1(x[4]), .sel(ctrl[1]), .out(y[2]));
    mux2X1 ins_21 (.in0(x[1]), .in1(x[3]), .sel(ctrl[1]), .out(y[1]));
    mux2X1 ins_20 (.in0(x[0]), .in1(x[2]), .sel(ctrl[1]), .out(y[0]));

    // 1-bit shift right
    mux2X1 ins_07 (.in0(y[7]), .in1(1'b0), .sel(ctrl[0]), .out(out[7]));
    mux2X1 ins_06 (.in0(y[6]), .in1(y[7]), .sel(ctrl[0]), .out(out[6]));
    mux2X1 ins_05 (.in0(y[5]), .in1(y[6]), .sel(ctrl[0]), .out(out[5]));
    mux2X1 ins_04 (.in0(y[4]), .in1(y[5]), .sel(ctrl[0]), .out(out[4]));
    mux2X1 ins_03 (.in0(y[3]), .in1(y[4]), .sel(ctrl[0]), .out(out[3]));
    mux2X1 ins_02 (.in0(y[2]), .in1(y[3]), .sel(ctrl[0]), .out(out[2]));
    mux2X1 ins_01 (.in0(y[1]), .in1(y[2]), .sel(ctrl[0]), .out(out[1]));
    mux2X1 ins_00 (.in0(y[0]), .in1(y[1]), .sel(ctrl[0]), .out(out[0]));
endmodule
