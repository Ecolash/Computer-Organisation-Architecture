`timescale 1ns / 1ps

module half_adder_beh(a, b, sum, carry);
    input a, b;
    output sum, carry;
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module full_adder_beh(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module half_adder_str(a, b, sum, carry);
    input a, b;
    output sum, carry;
    xor(sum, a, b);
    and(carry, a, b);
endmodule

module full_adder_str(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    wire w1, w2;
    xor(w1, a, b);
    xor(sum, w1, cin);
    and(w2, a, b);
    or(cout, w2, cin);
endmodule

module full_adder_using_half_adder(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    wire w1, w2;
    half_adder_str ha1(a, b, w1, w2);
    half_adder_str ha2(w1, cin, sum, w2);
    or(cout, w1, w2);
endmodule