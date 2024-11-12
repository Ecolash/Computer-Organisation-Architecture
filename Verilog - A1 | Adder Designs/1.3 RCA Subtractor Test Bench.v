
module testbench;
    reg [3:0] a, b;
    reg sel;
    wire [3:0] y;
    ADD_SUB_4BIT add_sub_4bit(a, b, sel, y);

    initial begin
        a = 4'b0000; b = 4'b0000; sel = 1; 
        #10; $display("Test case 1: %b + %b = %b", b, a, y);

        a = 4'd10; b = 4'd5; sel = 0;
        #10; $display("Test case 2: %b + %b = %b", b, a, y);

        a = 4'd10; b = 4'd5; sel = 1;
        #10; $display("Test case 3: %b - %b = %b", b, a, y);

        a = 4'd5; b = 4'd10; sel = 1;
        #10; $display("Test case 4: %b - %b = %b", b, a, y);

        a = 4'd10; b = 4'd10; sel = 0;
        #10; $display("Test case 5: %b + %b = %b", b, a, y);

        a = 4'd12; b = 4'd0; sel = 1;
        #10; $display("Test case 6: %b - %b = %b", b, a, y);
    end
endmodule
        