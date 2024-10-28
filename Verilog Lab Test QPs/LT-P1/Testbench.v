`timescale 1ns / 1ps

module test_rotator;
    reg [7:0] x, y, theta;
    wire [7:0] x1, y1;

    rotator UUT (.x(x), .y(y), .theta(theta), .x1(x1), .y1(y1));
    initial begin
        x = 0; y = 0; theta = 0;
        #10 x = -20; y = 20; 
        #10 theta = 10;
        #10 theta = 20;
        #10 theta = 30;
        #10 theta = 40;
        #10 theta = 60;
        #10 theta = 70;
        #10 theta = 80;        
        #10 $finish;
        
        #10 x = 30; y = 40; theta = 0; 
        #10 theta = 10;
        #10 theta = 20;
        #10 theta = 30;
        #10 theta = 40;
        #10 theta = 60;
        #10 theta = 70;
        #10 theta = 80;        
        #10 $finish;
    end
    
    initial begin
    $monitor($time, " ns| x = %d, y = %d, theta = %2d, | x1 = %d, y1 = %d", 
             $signed(x), $signed(y), theta, $signed(x1), $signed(y1));
    end
    
endmodule