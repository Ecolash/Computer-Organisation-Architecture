`timescale 1ns / 1ps

module test_USR_4BIT;
    reg clk;
    reg clear;
    reg [2:0] select;
    reg [3:0] parallel_in;
    wire [3:0] data;

    USR_4BIT uut (
        .data(data),
        .clk(clk),
        .clear(clear),
        .select(select),
        .parallel_in(parallel_in)
    );

    initial begin
        clk = 0; 
        clear = 1; 
        parallel_in = 4'b1111;
        #5 clear = 0; #5 clear = 1; #5;

        select = 3'b000; #10;
        select = 3'b111; parallel_in = 4'b1011;  #10;
        select = 3'b000; #10;
        $display("Holding state: %b", data);
        //------------------------------------------
        select = 3'b111; parallel_in = 4'b1111;  #10;
        select = 3'b001; #10;
        select = 3'b001; #10;
        select = 3'b001; #10;
        select = 3'b001; #10;
        $display("Right shift with 0: %b", data);
        //-------------------------------------------
        select = 3'b111; parallel_in = 4'b1111;  #10;
        select = 3'b010; #10;
        select = 3'b010; #10;
        select = 3'b010; #10;
        select = 3'b010; #10;
        $display("Left shift with 0: %b", data);
        //-------------------------------------------
        select = 3'b111; parallel_in = 4'b1000;  #10;
        select = 3'b011; #10;
        $display("Right rotate: %b", data);
        //-------------------------------------------
        select = 3'b111; parallel_in = 4'b1000;  #10;
        select = 3'b100; #10;
        $display("Left rotate: %b", data);
        //-------------------------------------------
        select = 3'b111; parallel_in = 4'b1000;  #10;
        select = 3'b101; #10;
        select = 3'b101; #10;
        $display("Right shift with load X: %b", data);
        //-------------------------------------------
        select = 3'b111; parallel_in = 4'b1000;  #10;
        select = 3'b110; #10;
        select = 3'b110; #10;
        $display("Left shift with load X: %b", data);
        //-------------------------------------------
        select = 3'b111; parallel_in = 4'b1000;  #10;
        select = 3'b111; parallel_in = 4'b0000;  #15;
        $display("Load data from parallel input: %b", data);
        $finish;
    end

    initial $monitor("Time: %3dns | Clear: %b | S: %b | Parallel In: %b | Data: %b", $time, clear, select, parallel_in, data);
    always #5 clk = ~clk;
endmodule
