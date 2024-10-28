`timescale 1ns / 1ps

module restoring_div(
    input [7:0] A, B,
    input clk, rst,
    output reg done,
    output reg [7:0] Q, R
);
    reg [15:0] div_reg;
    wire [7:0] rmb;
    reg [3:0] counter;

    assign rmb = div_reg[14:7] - B;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            div_reg <= {8'd0, A};  
            counter <= 4'd8;
            done <= 1'b0;      
        end else begin
            if (counter == 4'b0) begin
                Q = div_reg[7:0];
                R = div_reg[15:8];
                done = 1;
            end else begin
                case (rmb[7])
                    1'b0: div_reg <= {rmb, div_reg[6:0], 1'b1};
                    1'b1: div_reg <= {div_reg[14:0], 1'b0};
                endcase
                counter = counter - 1;
            end
        end
    end
endmodule
