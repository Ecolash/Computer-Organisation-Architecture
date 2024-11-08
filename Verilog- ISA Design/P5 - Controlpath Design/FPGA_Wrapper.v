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

module fpga_top(output reg [15:0] out, input clk, input INT, input myclk);
    wire slowclk;
    reg [25:0] counter;
    always @(posedge clk) counter <= counter+1;
    assign slowclk = counter[2];

    integer state;
    reg swit;   
    initial begin
        counter <= 0;
        out <= 16'b1111111111111111;
        state <= 0;
        swit <= 0;
    end

    wire fpclk;
    assign fpclk = (swit)?(slowclk):0;

    // From top
    wire [31:0] testREGval; // Reg 15
    wire [5:0] fpstate; // State of Control Unit
    top T(testREGval, fpstate, INT, fpclk);

    always @(posedge slowclk) begin
        case(state)
            0: begin
                if (fpstate == 0) begin
                // If CU at state 0, pause top and print the output on LEDs
                    swit <= 0;
                    state <= 1;
                    out <= 16'b1111111111111111;
                end
                else begin
                // Run top normally
                    swit <= 1;
                    state <= 0;
                    out[5:0] <= fpstate;
                end
                
            end
            1: begin
                out <= 16'b1111111111111111;
                state <= 2;
            end
            2: begin
                // Print high 16 bits of Reg 15
                out <= testREGval[31:16];
                state <= 3;
                swit <= 0;
            end
            3: begin
                // Print low 16 bits of Reg 15
                out <= testREGval[15:0];
                // If switch myclk is enabled, go to next instruction, otherwise keep on printing current value of Reg 15
                if (myclk) begin
                    state <= 0;
                    swit <= 1;
                end
                else state <= 1;
            end
        endcase
    end
endmodule