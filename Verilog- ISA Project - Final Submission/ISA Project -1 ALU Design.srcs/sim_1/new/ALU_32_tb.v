`timescale 1ns / 1ps
module ALU32_tb;

    // Testbench variables
    reg [3:0] alu_func;
    reg [31:0] A, B;
    wire [31:0] Y;

    // Instantiate the ALU32 module
    ALU32 uut (
        .alu_func(alu_func),
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Stimulus process
    initial begin
        // Monitor output
        $monitor("time = %0t | alu_func = %b | A = %h | B = %h | Y = %h", $time, alu_func, A, B, Y);
        
        // Test case 1: ADD32
        A = 32'h00000010;
        B = 32'h00000005;
        alu_func = 4'b0000;  // ADD
        #10;

        // Test case 2: SUB32
        A = 32'h00000010;
        B = 32'h00000005;
        alu_func = 4'b0001;  // SUB
        #10;

        // Test case 3: NOT32
        A = 32'hFFFFFFFF;
        B = 32'h00000000;  // B is not used here
        alu_func = 4'b0010;  // NOT
        #10;

        // Test case 4: SLL32
        A = 32'h00000001;
        B = 32'h00000002;  // Shift left by 2
        alu_func = 4'b0011;  // SLL
        #10;

        // Test case 5: AND32
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        alu_func = 4'b0100;  // AND
        #10;

        // Test case 6: OR32
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        alu_func = 4'b0101;  // OR
        #10;

        // Test case 7: SRL32
        A = 32'h80000000;
        B = 32'h00000001;  // Shift right by 1
        alu_func = 4'b0110;  // SRL
        #10;

        // Test case 8: SRA32
        A = 32'h80000000;
        B = 32'h00000001;  // Arithmetic shift right by 1
        alu_func = 4'b0111;  // SRA
        #10;

        // Test case 9: XOR32
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        alu_func = 4'b1000;  // XOR
        #10;
        // Test case 10: NOR32
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        alu_func = 4'b1001;  // NOR
        #10;

        // Test case 11: INCA32
        A = 32'h00000010;
        alu_func = 4'b1010;  // INC (Increment A)
        #10;

        // Test case 12: DECA32
        A = 32'h00000010;
        alu_func = 4'b1011;  // DEC (Decrement A)
        #10;

        // Test case 13: SLT32
        A = 32'h00000005;
        B = 32'h00000010;
        alu_func = 4'b1100;  // Compare: SLT, SGT, SEQ
        #10;
        //Test case 14: SGT32
        A=32'h00000005;
        B=32'h00000010;
        alu_func=4'b1101;
        #10;

        // Test case 14: LUI32
        A = 32'h0000FFFF;
        B = 32'h00000000;  // B is not used here
        alu_func = 4'b1110;  // LUI
        #10;

        // Test case 15: Hamming Weight
        A = 32'hF0F0F0F0;
        alu_func = 4'b1111;  // HAM32
        #10;

        // End simulation
        $finish;
    end

endmodule

