`timescale 1ns / 1ps

module MUX #(parameter WIDTH = 8) (
    input wire [WIDTH-1:0] in0,
    input wire [WIDTH-1:0] in1,
    input wire [WIDTH-1:0] in2,
    input wire [WIDTH-1:0] in3,
    input wire [1:0] sel,
    output reg [WIDTH-1:0] out
);
    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = in0;
        endcase
    end
endmodule

module PIPO #(parameter WIDTH = 8) (
    input wire [WIDTH-1:0] data_in,
    input wire clk,
    input wire rst,
    input wire load,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) data_out <= {WIDTH{1'b0}};  
        else if (load) data_out <= data_in;       
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// --------------------------------DATA PATH--------------------------------------
//////////////////////////////////////////////////////////////////////////////////

module MUL_datapath(clk, rst, ain, bin, cout, eqf, ldA, ldB, ldP, selB, sel, Q0);
    input wire clk, rst;
    input wire ldA, ldB, ldP;
    input wire [1:0] selB, sel;
    
    input wire [7:0] ain, bin;
    output wire [15:0] cout;
    output reg eqf;
    output wire Q0;
    
    wire [7:0] a;
    wire [8:0] sum;
    wire [16:0] zero, a0, a1, a2, mux;
    wire [16:0] pout;
    wire [3:0] b, bm1, bmux;

    assign sum = pout[15:8] + a;
    assign zero = 17'b0;
    assign a0 = {1'b0, pout[16:1]};
    assign a1 = {1'b0, sum, pout[7:1]};
    assign a2 = {9'b0, bin};
    assign bm1 = b - 1'b1;  
    assign cout = pout[15:0];
    assign Q0 = pout[0];

    PIPO #(8) M(.data_in(ain), .clk(clk), .rst(rst), .load(ldA), .data_out(a));
    PIPO #(4) cnt(.data_in(bmux), .clk(clk), .rst(rst), .load(ldB), .data_out(b));
    PIPO #(17) P(.data_in(mux), .clk(clk), .rst(rst), .load(ldP), .data_out(pout));

    MUX #(17) MUX(.in0(zero), .in1(a0), .in2(a1), .in3(a2), .sel(sel), .out(mux));
    MUX #(4) MUX1(.in0(bm1), .in1(4'b1000), .in2(bm1), .in3(bm1), .sel(selB), .out(bmux));

    always @(*) begin
        if (b == 0) eqf = 1;
        else eqf = 0;
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////
//// -----------------------------CONTROL PATH--------------------------------------
////////////////////////////////////////////////////////////////////////////////////

module MUL_controlpath(
    input wire clk,
    input wire rst,
    input wire run,
    input wire eqf,
    input wire Q0,
    output reg ldA, ldB, ldP,
    output reg [1:0] selB,
    output reg [1:0] sel,
    output reg done_
);
    
    // FSM - Design
    reg [2:0] curr, next;
    parameter 
        start = 3'b000,
        inp1 = 3'b001,
        test = 3'b010,
        add0 = 3'b011,
        add1 = 3'b100,
        decb = 3'b101,
        done = 3'b110;
        
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) curr <= start;
        else curr <= next;
    end
    
    always @(*) begin
    case(curr) 
        start: 
        if (run == 1) next <= inp1;
        else next <= start;
            
        inp1: next <= test;

        test:
        if (eqf == 1) next <= done;
        else if (Q0 == 1'b1) next <= add1;
        else next <= add0;
        
        add0: next <= decb;
        add1: next <= decb;
        
        decb: next <= test;
        done: next <= done;
        default: next <= start;
    endcase
    end
    
    always @(*) begin
    ldA = 0; ldB = 0; ldP = 0; selB = 2'b00; sel = 2'b00;
    case(curr) 
        start: done_ = 0;
        inp1: begin sel = 2'b11; selB = 2'b01; ldA = 1; ldB = 1; ldP = 1; end
        add0: begin ldP = 1; sel = 2'b01;  end
        add1: begin ldP = 1; sel = 2'b10;  end
        decb: begin selB = 2'b11; ldB = 1; end
        done: done_ = 1;
        default: ;
    endcase
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////
//// ----------------------------FINAL MUL MODULE-----------------------------------
////////////////////////////////////////////////////////////////////////////////////
module MUL2(clk, rst, run, A, B, P, done);
    input wire clk, rst, run;
    input wire [7:0] A, B;
    output wire [15:0] P;
    output wire done;        
    
    wire ldA, ldB, ldP, eqf, Q0;
    wire [1:0] selB, sel;
    wire [15:0] cout;

    MUL_datapath dp(
        .clk(clk), 
        .rst(rst), 
        .ain(A), 
        .bin(B), 
        .cout(cout), 
        .eqf(eqf), 
        .ldA(ldA), 
        .ldB(ldB), 
        .ldP(ldP), 
        .selB(selB), 
        .sel(sel), 
        .Q0(Q0)
    );

    MUL_controlpath cp(
        .clk(clk), 
        .rst(rst), 
        .run(run), 
        .eqf(eqf), 
        .Q0(Q0), 
        .ldA(ldA), 
        .ldB(ldB), 
        .ldP(ldP), 
        .selB(selB), 
        .sel(sel), 
        .done_(done)
    );

    assign P = cout;
endmodule
