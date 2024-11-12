`timescale 1ns / 1ps
module testbench;

    reg a, b, cin;
    wire sum_ha_beh, carry_ha_beh;
    wire sum_fa_beh, cout_fa_beh;
    wire sum_ha_str, carry_ha_str;
    wire sum_fa_str, cout_fa_str;
    wire sum_fa_ha, cout_fa_ha;

    half_adder_beh ha_beh (.a(a), .b(b), .sum(sum_ha_beh), .carry(carry_ha_beh));
    full_adder_beh fa_beh (.a(a), .b(b), .cin(cin), .sum(sum_fa_beh), .cout(cout_fa_beh));
    half_adder_str ha_str (.a(a), .b(b), .sum(sum_ha_str), .carry(carry_ha_str));
    full_adder_str fa_str (.a(a), .b(b), .cin(cin), .sum(sum_fa_str), .cout(cout_fa_str));
    full_adder_using_half_adder fa_ha (.a(a), .b(b), .cin(cin), .sum(sum_fa_ha), .cout(cout_fa_ha));

    initial begin
        a = 1'b0; b = 1'b0; cin = 1'b0;

        // Testing Half Adder Behavioral
        $display("Testing Half Adder Behavioral");
        $display("| a | b | sum | carry |");
        $display("-----------------------");
        #10 a = 1'b0; b = 1'b1; #1 $display("| %b | %b |  %b  |  %b   |", a, b, sum_ha_beh, carry_ha_beh);
        #10 a = 1'b1; b = 1'b0; #1 $display("| %b | %b |  %b  |  %b   |", a, b, sum_ha_beh, carry_ha_beh);
        #10 a = 1'b1; b = 1'b1; #1 $display("| %b | %b |  %b  |  %b   |", a, b, sum_ha_beh, carry_ha_beh);
        #10;

        // Testing Full Adder Behavioral
        $display("Testing Full Adder Behavioral");
        $display("| a | b | cin | sum | cout |");
        $display("----------------------------");
        #10 a = 1'b0; b = 1'b0; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b0; b = 1'b1; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b1; b = 1'b0; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b1; b = 1'b1; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b0; b = 1'b0; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b0; b = 1'b1; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b1; b = 1'b0; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10 a = 1'b1; b = 1'b1; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_beh, cout_fa_beh);
        #10;

        // Testing Half Adder Structural
        $display("Testing Half Adder Structural");
        $display("| a | b | sum | carry |");
        $display("-----------------------");
        #10 a = 1'b0; b = 1'b1; #1 $display("| %b | %b |  %b  |  %b   |", a, b, sum_ha_str, carry_ha_str);
        #10 a = 1'b1; b = 1'b0; #1 $display("| %b | %b |  %b  |  %b   |", a, b, sum_ha_str, carry_ha_str);
        #10 a = 1'b1; b = 1'b1; #1 $display("| %b | %b |  %b  |  %b   |", a, b, sum_ha_str, carry_ha_str);
        #10;

        // Testing Full Adder Structural
        $display("Testing Full Adder Structural");
        $display("| a | b | cin | sum | cout |");
        $display("----------------------------");
        #10 a = 1'b0; b = 1'b0; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b0; b = 1'b1; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b1; b = 1'b0; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b1; b = 1'b1; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b0; b = 1'b0; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b0; b = 1'b1; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b1; b = 1'b0; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10 a = 1'b1; b = 1'b1; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_str, cout_fa_str);
        #10;

        // Testing Full Adder using Half Adder
        $display("Testing Full Adder using Half Adder");
        $display("| a | b | cin | sum | cout |");
        $display("----------------------------");
        #10 a = 1'b0; b = 1'b0; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b0; b = 1'b1; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b1; b = 1'b0; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b1; b = 1'b1; cin = 1'b0; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b0; b = 1'b0; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b0; b = 1'b1; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b1; b = 1'b0; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10 a = 1'b1; b = 1'b1; cin = 1'b1; #1 $display("| %b | %b |  %b  |  %b  |  %b   |", a, b, cin, sum_fa_ha, cout_fa_ha);
        #10;
    end

endmodule
