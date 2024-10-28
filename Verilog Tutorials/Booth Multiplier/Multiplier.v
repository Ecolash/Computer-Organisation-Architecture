`timescale 1ns / 1ps

module MUL(q, m, clk, rst, prod, done);
    input [7:0] q, m;
    input clk, rst;
    output reg [15:0] prod = 0;
    output reg done;

    reg [4:0] counter;
    reg [16:0] pout;
    wire [1:0] sel;
    wire [7:0] apm, amm;

    assign sel = pout[1:0];
    assign apm = pout[16:9] + m;
    assign amm = pout[16:9] - m;

    always @(posedge clk or posedge rst) begin 
        if (rst) begin
            counter <= 4'd8;
            pout <= {8'b0, q, 1'b0};
            done <= 1'b0;
            prod <= 16'b0;
        end else begin
            if (counter == 0) begin
                prod <= pout[16:1];
                done <= 1'b1;
            end else begin
                case (sel)
                    2'b01: pout <= {apm[7], apm, pout[8:1]};
                    2'b10: pout <= {amm[7], amm, pout[8:1]};
                    default: pout <= {pout[16], pout[16:1]};
                endcase
                counter <= counter - 1;
            end
        end
    end
endmodule
