`timescale 1ns / 1ps

module top_module_tb;
    // Testbench signals
    reg [15:0] instruction;
    reg clk;
    wire [15:0] out;

    // Instantiate the top module
    top uut (
        .out(out),
        .instruction(instruction),
        .clk(clk)
        ,.rst(rst)
    );

    // Clock generation (50 MHz simulated clock)
    always begin
        #10 clk = ~clk; // 20 time units period (50 MHz clock)
    end

    // Task for providing an instruction and checking output
    task execute_instruction(input [15:0] instr);
    begin
        instruction = instr;
        @(posedge clk); // Wait for clock cycle
    end
    endtask

    initial begin
        // Initialize the clock
        clk = 0;

        // Test 1: Load initial values into registers
        execute_instruction(16'h1234); // Example instruction
        #200;
        execute_instruction(16'h5120);
        #2000;
        
        
        // Monitor the output values
        $monitor("Time: %0d, Instruction: %h, Output: %h", $time, instruction, out);

        // Test 2: Perform ALU operations (customize instructions as needed)

        // Finish simulation after a few cycles
        $stop;
    end
endmodule

