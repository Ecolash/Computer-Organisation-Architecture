`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module reg4(d, clk, load, reset, q);
    input [3:0] d;
    input clk;
    input load;
    input reset;
    output reg [3:0] q;
    
    always @(posedge clk or posedge reset) begin
        if (reset) q <= 4'b0000;
        else if (load) q <= d;
    end
endmodule

module mux4(a, b, sel, y);
    input [3:0] a, b;
    input sel;
    output [3:0] y;
    assign y = (sel) ? b : a;
endmodule

//////////////////////////////////////////////////////////////////////////////////
// --------------------------------DATA PATH--------------------------------------
//////////////////////////////////////////////////////////////////////////////////

module GCD_datapath(clk, rst, selx, sely, xld, yld, gld, xin, yin, gcd, eqf, ltf);
    input wire clk;
    input wire rst;
    input wire selx, sely;
    input wire xld, yld, gld;
    
    input wire [3:0] xin, yin;
    output wire [3:0] gcd;
    output reg eqf, ltf;
    
    wire [3:0] xmy, ymx, gcd_out;
    wire [3:0] x, y, xl, yl;
    
    mux4 MX(xmy, xin, selx, xl);
    mux4 MY(ymx, yin, sely, yl);
    
    reg4 X(xl, clk, xld, rst, x);
    reg4 Y(yl, clk, yld, rst, y);
    reg4 G(x, clk, gld, rst, gcd_out);
    
    assign xmy = x - y;
    assign ymx = y - x;
    assign gcd = gcd_out;

    always @(*) begin
        if (x == y) eqf = 1;
        else eqf = 0;
    end
    
    always @(*) begin
        if (x < y) ltf = 1;
        else ltf = 0;
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// -----------------------------CONTROL PATH--------------------------------------
//////////////////////////////////////////////////////////////////////////////////

module GCD_controlpath(clk, rst, run, eqf, ltf, selx, sely, xld, yld, gld, done_);
    input wire clk, rst, run;
    input wire eqf, ltf;
    output reg selx = 0;
    output reg sely = 0;   
     
    output reg xld = 0;
    output reg yld = 0;    
    output reg gld = 0;
    output reg done_ = 0;
    
    // FSM - Design
    reg [2:0] curr = 0, next;
    parameter 
        start = 3'b000,
        inp1 =  3'b001,
        test1 = 3'b010,
        test2 = 3'b011,
        upd1 =  3'b100,
        upd2 =  3'b101,
        done =  3'b110;
              
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) curr <= start;
        else curr <= next;
    end
    
    always @(*) begin
    case(curr) 
        start: 
        if (run == 1) next <= inp1;
        else next <= start;
            
        test1: 
        if(eqf == 1) next <= done;
        else next <= test2;
        
        test2: 
        if(ltf == 1) next <= upd1;
        else next <= upd2;
        
        inp1: next <= test1;
        upd1: next <= test1;
        upd2: next <= test1;
        done: next <= done;
        
        default next <= start;
    endcase
    end
    
    always @(*) begin
    xld = 0; yld = 0; gld = 0;
    selx = 0; sely = 0;
    case(curr) 
        start: done_ = 0;
        inp1: begin xld = 1; yld = 1; selx = 1; sely = 1; end
        upd1: yld = 1;
        upd2: xld = 1;
        done: begin gld = 1; done_ = 1; end
        default;
    endcase
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// ----------------------------FINAL GCD MODULE-----------------------------------
//////////////////////////////////////////////////////////////////////////////////
module GCD(clk, rst, run, xin, yin, gcd, done);
    input wire clk, rst, run;
    input wire [3:0] xin, yin;
    output wire [3:0] gcd;
    output wire done;        
    
    wire selx, sely, xld, yld, gld;
    wire eqf, ltf, done_;
    GCD_datapath DP1 (
        .clk(clk),
        .rst(rst),
        .selx(selx),
        .sely(sely),
        .xld(xld),
        .yld(yld),
        .gld(gld),
        .xin(xin),
        .yin(yin),
        .gcd(gcd),
        .eqf(eqf),
        .ltf(ltf)
    );
    
    GCD_controlpath CP1 (
        .clk(clk),
        .rst(rst),
        .run(run),
        .eqf(eqf),
        .ltf(ltf),
        .selx(selx),
        .sely(sely),
        .xld(xld),
        .yld(yld),
        .gld(gld),
        .done_(done_)
    );
    assign done = done_;
endmodule
