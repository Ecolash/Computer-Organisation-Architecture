`timescale 1ns / 1ps

module MUL(q, m, clk, rst, prod, done);
    input [7:0] q, m;
    input clk, rst;
    output [15:0] prod;
    output reg done;

    reg [4:0] counter;
    reg [16:0] pout;
    wire [1:0] sel;
    wire [7:0] apm, amm;

    assign sel = pout[1:0];
    assign prod = pout[16:1];
    assign apm = pout[16:9] + m;
    assign amm = pout[16:9] - m;
    always @(posedge clk or posedge rst)
    begin 
        if (rst) begin
            counter = 4'b1000;
            pout = {8'b0, q, 1'b0};
            done = 1'b0;
        end else begin
            if (counter == 0) done = 1'b1;
            else begin
                if (sel == 01) pout = {apm, pout[8:0]};
                if (sel == 10) pout = {amm, pout[8:0]};
                pout = {pout[15], pout[15:1]};
                counter = counter - 1;
            end
        end
    end

endmodule