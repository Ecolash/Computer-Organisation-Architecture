`timescale 1ns/1ps
module reg_bank_tb;
    // Testbench signals
    reg [3:0] READPORT1, READPORT2, WRITEPORT;
    reg [31:0] C;
    reg READ_EN, WRITE_EN, clk, rst;
    wire [31:0] A, B;

    // Instantiate the REG_BANK16 module
    REG_BANK16 uut (
        .A(A),
        .B(B),
        .READPORT1(READPORT1),
        .READPORT2(READPORT2),
        .WRITEPORT(WRITEPORT),
        .C(C),
        .READ_EN(READ_EN),
        .WRITE_EN(WRITE_EN),
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 time units clock period
    end

    // Task for resetting the register bank
    task reset_register_bank;
    begin
        rst = 1;
        @(posedge clk); // Wait for a clock edge
        rst = 0;
    end
    endtask

    // Task for writing to the register bank
    task write_to_register(input [3:0] port, input [31:0] data);
    begin
        WRITEPORT = port;
        C = data;
        WRITE_EN = 1;
        @(posedge clk); // Wait for a clock edge
        WRITE_EN = 0;
    end
    endtask

    // Task for reading from the register bank
    task read_from_register(input [3:0] read_port1, input [3:0] read_port2);
    begin
        READPORT1 = read_port1;
        READPORT2 = read_port2;
        READ_EN = 1;
        @(posedge clk); // Wait for a clock edge
        $display("Read RB[%0d]: %h, RB[%0d]: %h", read_port1, A, read_port2, B);
        READ_EN = 0;
    end
    endtask

    // Main testbench process
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        READ_EN = 0;
        WRITE_EN = 0;
        READPORT1 = 4'b0000;
        READPORT2 = 4'b0000;
        WRITEPORT = 4'b0000;
        C = 32'b0;

        // 1. Reset the register bank
        reset_register_bank();

        // 2. Write to register RB[1]
        write_to_register(4'b0001, 32'hDEADBEEF);

        // 3. Read from registers RB[1] and RB[2] (RB[2] should still be the initial value)
        read_from_register(4'b0001, 4'b0010);

        // 4. Write to register RB[3]
        write_to_register(4'b0011, 32'hCAFEBABE);

        // 5. Read from registers RB[1] and RB[3]
        read_from_register(4'b0001, 4'b0011);

        // Finish simulation
        $stop;
    end
endmodule


