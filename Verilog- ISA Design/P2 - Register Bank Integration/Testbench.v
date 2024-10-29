`timescale 1ns / 1ps

module top_module_tb;
    reg [15:0] instruction;
    reg clk;
    wire [15:0] out;
    top UUT (
        .out(out),
        .instruction(instruction),
        .clk(clk),
        .rst(rst)
    );

    always #2 clk = ~clk;
    task execute_instruction(input [15:0] instr);
    begin
        instruction = instr;
        @(posedge clk);
    end
    endtask

    initial begin
        clk = 0;
        execute_instruction(16'h1234); #200;
        execute_instruction(16'h5120); #200;
        execute_instruction(16'h0000); #200;
        execute_instruction(16'h1111); #200;
        execute_instruction(16'h2522); #200;
        $monitor("Time: %0d, Instruction: %h, Output: %h", $time, instruction, out);
        $stop;
    end
endmodule
