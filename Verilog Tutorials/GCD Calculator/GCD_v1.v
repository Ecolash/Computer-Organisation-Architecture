module GCD(clk, rst, run, xin, yin, gcd, done);
    input wire clk, rst, run;
    input wire [3:0] xin, yin;
    output wire [3:0] gcd;
    output reg done;    
    
    reg [3:0] x, y;
    reg [3:0] gcd_out;
    assign gcd = gcd_out;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x <= xin;
            y <= yin;
            done <= 1'b0;
        end else begin 
            if (x == 0) begin gcd_out <= y; done <= 1; end
            else if (y == 0) begin gcd_out <= y; done <= 1; end
            else if (x > y) x <= x - y;
            else if (y > x) y <= y - x;
            else begin gcd_out <= y; done <= 1'b1; end
        end
        end
endmodule
