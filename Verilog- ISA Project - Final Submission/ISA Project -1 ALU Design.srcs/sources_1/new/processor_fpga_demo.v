

module wrapper_processor(in, out, reset, clk);
    input[3:0] in;
    output reg [15:0] out;
    input reset, clk;
    wire new_clk;
    wire [31:0] ALUout;

    clock_div clock(new_clk, clk, reset);
    processor_top processor(ALUout, new_clk, reset,in);
    always @(posedge new_clk or posedge reset) begin
        if (reset) out <= 16'b0;
        else out <= ALUout[15:0];
    end
endmodule
