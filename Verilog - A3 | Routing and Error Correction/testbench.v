`timescale 1ns / 1ps

module tb_top_level_router;
    reg [5:0] d_in;
    wire [3:0] d_disp0, d_disp1, d_disp2, d_disp3;

    top_level_router uut (
        .d_in(d_in),
        .d_disp0(d_disp0),
        .d_disp1(d_disp1),
        .d_disp2(d_disp2),
        .d_disp3(d_disp3)
    );

    initial begin
        d_in = 6'b001111;
        #10 d_in = 6'b000100;
        #10 d_in = 6'b010010; 
        #10 d_in = 6'b101111; 
        #10 d_in = 6'b110011; 
        #10 d_in = 6'b101101;
        #10 d_in = 6'b010110; 
        #10 d_in = 6'b101111; 
        #10 d_in = 6'b001001; 
        #10 $finish; 
    end

    initial begin
        $monitor("At time %t, d_in = %b, d_disp0 = %b, d_disp1 = %b, d_disp2 = %b, d_disp3 = %b",
                 $time, d_in, d_disp0, d_disp1, d_disp2, d_disp3);
    end
endmodule

