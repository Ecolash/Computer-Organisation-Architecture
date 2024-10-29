module clock_div(clk_out,clk_in,reset);
	input clk_in;
	input reset;
	output clk_out;
    reg [24:0] counter;

	assign clk_out = counter[24];
	always @(negedge clk_in or posedge reset)
    begin
        if(reset) counter = 25'b0;
        else counter = counter + 1;
    end
endmodule

module wrapper(out,instruction,reset,clk);
	 output [15:0]out;
	 input[15:0]instruction;
	 input reset,clk;

	 wire new_clk;
	 clock_div clk_inst(new_clk,clk,reset);
	 top_module wrap_inst(out,instruction,reset,new_clk);
endmodule
