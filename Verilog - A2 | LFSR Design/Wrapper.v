`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2024 15:19:35
// Design Name: 
// Module Name: CLK_DIV
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

module CLK_DIV(clk_in, reset, clk_out);
    input wire clk_in;       
    input wire reset;       
    output reg clk_out;
       
    parameter DIVISOR = 2**28;
    reg [27:0] counter;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter >= (DIVISOR / 2 - 1)) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule


module WRAPPER(seed, rst, sel, clk, state);
    input [3:0] seed;
    input wire rst,sel,clk;
    output [3:0] state;
    wire clkdiv;

    CLK_DIV clk_div(.clk_in(clk), .reset(rst), .clk_out(clkdiv));
    LFSR lfsr(.seed(seed), .rst(rst), .sel(sel), .clk(clkdiv), .state(state));
endmodule
