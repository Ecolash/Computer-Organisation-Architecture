module CLA_4BIT_TB;

    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    CLA_4BIT uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin        
        a = 4'b0000; b = 4'b0000; cin = 1'b0;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);
        
        a = 4'b0011; b = 4'b0001; cin = 1'b0;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);
        
        a = 4'b1010; b = 4'b0101; cin = 1'b0;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);
        
        a = 4'b1111; b = 4'b1111; cin = 1'b1;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);
        
        a = 4'b1100; b = 4'b1010; cin = 1'b1;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);
        
        a = 4'b0001; b = 4'b1111; cin = 1'b0;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);
        
        a = 4'b0101; b = 4'b0101; cin = 1'b1;
        #10; $display("%0t\t %b + %b + %b = %b (%b)", $time, a, b, cin, sum, cout);

        $finish;
    end

endmodule
