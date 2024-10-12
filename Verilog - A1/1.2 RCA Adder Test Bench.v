module test_RCA;

    reg [63:0] a, b;
    reg cin;
    wire [63:0] sum;
    wire carry;
    integer passed_tests = 0;
    RCA_64BIT rca64(a, b, cin, sum, carry);
    
    initial begin
        // Test case 1
        a = 64'h0000000000000000; 
        b = 64'h0000000000000000; 
        cin = 0; 
        #10;
        $display("Test case 1: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h0000000000000000 && carry == 0) passed_tests = passed_tests + 1;
        else $display("Test case 1 failed");

        // Test case 2
        a = 64'hFFFFFFFFFFFFFFFF; 
        b = 64'h0000000000000001; 
        cin = 0; 
        #10;
        $display("Test case 2: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h0000000000000000 && carry == 1) passed_tests = passed_tests + 1;
        else $display("Test case 2 failed");

        // Test case 3
        a = 64'h123456789ABCDEF0; 
        b = 64'h0FEDCBA987654321; 
        cin = 1; 
        #10;
        $display("Test case 3: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h2222222222222212 && carry == 0) passed_tests = passed_tests + 1;
        else $display("Test case 3 failed");

        // Test case 4
        a = 64'hAAAAAAAAAAAAAAAA; 
        b = 64'h5555555555555555; 
        cin = 0; 
        #10;
        $display("Test case 4: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'hFFFFFFFFFFFFFFFF && carry == 0) passed_tests = passed_tests + 1;
        else $display("Test case 4 failed");

        // Test case 5
        a = 64'h8000000000000000; 
        b = 64'h8000000000000000; 
        cin = 1; 
        #10;
        $display("Test case 5: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h0000000000000001 && carry == 1) passed_tests = passed_tests + 1;
        else $display("Test case 5 failed");

        // Test case 6
        a = 64'hFFFFFFFFFFFFFFFF; 
        b = 64'hFFFFFFFFFFFFFFFF; 
        cin = 1; 
        #10;
        $display("Test case 6: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'hFFFFFFFFFFFFFFFF && carry == 1) passed_tests = passed_tests + 1;
        else $display("Test case 6 failed");

        // Test case 7
        a = 64'h0000000000000001; 
        b = 64'h0000000000000001; 
        cin = 0; 
        #10;
        $display("Test case 7: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h0000000000000002 && carry == 0) passed_tests = passed_tests + 1;
        else $display("Test case 7 failed");

        // Test case 8
        a = 64'h7FFFFFFFFFFFFFFF; 
        b = 64'h0000000000000001; 
        cin = 0; 
        #10;
        $display("Test case 8: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h8000000000000000 && carry == 0) passed_tests = passed_tests + 1;
        else $display("Test case 8 failed");

        // Test case 9
        a = 64'h0000000000000000; 
        b = 64'hFFFFFFFFFFFFFFFF; 
        cin = 1; 
        #10;
        $display("Test case 9: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h0000000000000000 && carry == 1) passed_tests = passed_tests + 1;
        else $display("Test case 9 failed");

        // Test case 10
        a = 64'h123456789ABCDEF0; 
        b = 64'h876543210FEDCBA9; 
        cin = 0; 
        #10;
        $display("Test case 10: %h + %h + %b = %h, carry=%b", a, b, cin, sum, carry);
        if (sum == 64'h99999999AAAAAA99 && carry == 0) passed_tests = passed_tests + 1;
        else $display("Test case 10 failed");

        $display("%d / 10 tests passed successfully", passed_tests);
        $stop;
    end
endmodule
