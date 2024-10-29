`timescale 1ns / 1ps

module test_ALU32_Testbench;
    reg [3:0] alu_func;
    reg [31:0] A, B;
    wire [31:0] Y;

    ALU32 uut (
        .alu_func(alu_func),
        .A(A),
        .B(B),
        .Y(Y)
    );
    initial begin
        $monitor("Time: %0t | A: %h | B: %h | alu_func: %b | Y: %h", $time, A, B, alu_func, Y);
    end

    initial begin
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0000; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0001; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0010; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0011; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0100; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0101; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0110; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b0111; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1000; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1001; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1010; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1011; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1100; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1101; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1110; #10;
        A = 32'h0000000F; B = 32'h00000001; alu_func = 4'b1111; #10;
        
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0000; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0001; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0010; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0011; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0100; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0101; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0110; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b0111; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1000; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1001; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1010; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1011; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1100; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1101; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1110; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; alu_func = 4'b1111; #10;

        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0000; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0001; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0010; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0011; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0100; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0101; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0110; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b0111; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1000; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1001; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1010; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1011; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1100; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1101; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1110; #10;
        A = 32'h12345678; B = 32'h87654321; alu_func = 4'b1111; #10;
        
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0000; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0001; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0010; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0011; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0100; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0101; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0110; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b0111; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1000; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1001; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1010; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1011; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1100; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1101; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1110; #10;
        A = 32'hA5A5A5A5; B = 32'h5A5A5A5A; alu_func = 4'b1111; #10;
        $finish;
    end
endmodule