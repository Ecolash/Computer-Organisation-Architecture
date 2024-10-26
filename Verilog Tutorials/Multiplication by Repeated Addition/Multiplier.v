`timescale 1ns / 1ps

module MUX #(parameter WIDTH = 8) (
    input wire [WIDTH-1:0] in0,
    input wire [WIDTH-1:0] in1,
    input wire sel,
    output reg [WIDTH-1:0] out
);
    always @(*) begin
        case (sel)
            1'b0: out = in0;
            1'b1: out = in1;
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

module MUL_datapath(clk, rst, ain, bin, cout, eqf, ldA, ldB, ldP, selB);
    input wire clk, rst;
    input wire ldA, ldB, ldP;
    input wire selB;
    
    input wire [3:0] ain, bin;
    output wire [7:0] cout;
    output reg eqf;
    
    wire [7:0] a__, prod, pin;
    wire [3:0] a, b, bm1, bmux;

    assign a__ = {4'b0000, a};
    assign pin = prod + a__;
    assign bm1 = b - 1;
    assign cout = prod;

    MUX #(4) MB (bm1, bin, selB, bmux);
    PIPO #(4) A (ain, clk, rst, ldA, a);
    PIPO #(4) B (bmux, clk, rst, ldB, b);
    PIPO #(8) P (pin, clk, rst, ldP, prod);

    always @(*) begin
        if (b == 0) eqf = 1;
        else eqf = 0;
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// -----------------------------CONTROL PATH--------------------------------------
//////////////////////////////////////////////////////////////////////////////////

module MUL_controlpath(clk, rst, run, eqf, selB, ldA, ldB, ldP, done_);
    input wire clk, rst, run;
    input wire eqf;

    output reg selB = 0;
    output reg ldA = 0;
    output reg ldB = 0;    
    output reg ldP = 0;
    output reg done_ = 0;
    
    // FSM - Design
    reg [2:0] curr = 0, next;
    parameter 
        strt = 3'b000,
        inp1 = 3'b001,
        test = 3'b010,
        add1 = 3'b011,
        done = 3'b100;
        
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) curr <= strt;
        else curr <= next;
    end
    
    always @(*) begin
    case(curr) 
        strt: 
        if (run == 1) next <= inp1;
        else next <= strt;
            
        inp1: next <= test;
        test:
        if (eqf == 1) next <= done;
        else next <= add1;
        
        add1: next <= test;
        done: next <= done;
        default next <= strt;
    endcase
    end
    
    always @(*) begin
    ldA = 0; ldB = 0; ldP = 0; selB = 0; 
    case(curr) 
        strt: done_ = 0;
        inp1: begin ldA = 1; ldB = 1; selB = 1; end
        add1: begin ldP = 1; ldB = 1; end
        done: done_ = 1;
        default;
    endcase
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// ----------------------------FINAL MUL MODULE-----------------------------------
//////////////////////////////////////////////////////////////////////////////////
module MUL(clk, rst, run, A, B, P, done);
    input wire clk, rst, run;
    input wire [3:0] A, B;

    output wire [7:0] P;
    output wire done;        
    
    wire selB, ldA, ldB, ldP, eqf;
    wire [7:0] cout;
    MUL_datapath DP(clk, rst, A, B, cout, eqf, ldA, ldB, ldP, selB);
    MUL_controlpath CP(clk, rst, run, eqf, selB, ldA, ldB, ldP, done_);

    assign done = done_;
    assign P = cout;
endmodule
