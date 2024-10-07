module HA_1BIT(a, b, sum, carry);
    input a, b;
    output sum, carry;
    xor(sum, a, b);
    and(carry, a, b);
endmodule

module FA_1BIT(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    wire w1, w2, w3;
    HA_1BIT ha1(a, b, w1, w2);
    HA_1BIT ha2(w1, cin, sum, w3);
    or(cout, w2, w3);
endmodule

module RCA_8BIT(a, b, cin, sum, carry);
    input [7:0] a, b;
    input cin;
    output [7:0] sum;
    output carry;
    wire [7:0] c;
    FA_1BIT fa1(a[0], b[0], cin, sum[0], c[0]);
    FA_1BIT fa2(a[1], b[1], c[0], sum[1], c[1]);
    FA_1BIT fa3(a[2], b[2], c[1], sum[2], c[2]);
    FA_1BIT fa4(a[3], b[3], c[2], sum[3], c[3]);    
    FA_1BIT fa5(a[4], b[4], c[3], sum[4], c[4]);
    FA_1BIT fa6(a[5], b[5], c[4], sum[5], c[5]);
    FA_1BIT fa7(a[6], b[6], c[5], sum[6], c[6]);
    FA_1BIT fa8(a[7], b[7], c[6], sum[7], carry);
endmodule

module RCA_16BIT(a, b, cin, sum, carry);
    input [15:0] a, b;
    input cin;
    output [15:0] sum;
    output carry;
    wire c;
    RCA_8BIT rca1(a[7:0], b[7:0], cin, sum[7:0], c);
    RCA_8BIT rca2(a[15:8], b[15:8], c, sum[15:8], carry);
endmodule

module RCA_32BIT(a, b, cin, sum, carry);
    input [31:0] a, b;
    input cin;
    output [31:0] sum;
    output carry;
    wire c1, c2, c3;
    RCA_8BIT rca1(a[7:0], b[7:0], cin, sum[7:0], c1);
    RCA_8BIT rca2(a[15:8], b[15:8], c1, sum[15:8], c2);
    RCA_8BIT rca3(a[23:16], b[23:16], c2, sum[23:16], c3);
    RCA_8BIT rca4(a[31:24], b[31:24], c3, sum[31:24], carry);
endmodule

module RCA_64BIT(a, b, cin, sum, carry);
    input [63:0] a, b;
    input cin;
    output [63:0] sum;
    output carry;
    wire c;
    RCA_32BIT rca1(a[31:0], b[31:0], cin, sum[31:0], c);
    RCA_32BIT rca2(a[63:32], b[63:32], c, sum[63:32], carry);
endmodule
