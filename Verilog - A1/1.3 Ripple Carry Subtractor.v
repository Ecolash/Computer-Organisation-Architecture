// D = 0 | S = B + A
// D = 1 | S = B - A = B + ~A + 1

module MUX2_1COMP(a, sel, y);
    input a, sel;
    output y;
    wire w1, w2, a_, sel_;

    not g1(a_, a);
    not g2(sel_, sel);
    and g3(w1, a_, sel_);
    and g4(w2, a, sel);
    or  g5(y, w1, w2);
endmodule

module RCA_4BIT(a, b, cin, y, carry);
    input [3:0] a, b;
    input cin;
    output [3:0] y;
    wire c1, c2, c3;

    FA_1BIT fa1(a[0], b[0], cin, y[0], c1);
    FA_1BIT fa2(a[1], b[1], c1, y[1], c2);
    FA_1BIT fa3(a[2], b[2], c2, y[2], c3);
    FA_1BIT fa4(a[3], b[3], c3, y[3], carry);
endmodule

module ADD_SUB_4BIT(a, b, sel, y, cout);
    input [3:0] a, b;
    input sel;
    output [3:0] y;
    wire [3:0] w;

    MUX2_1COMP m1(a[0], sel, w[0]);
    MUX2_1COMP m2(a[1], sel, w[1]);
    MUX2_1COMP m3(a[2], sel, w[2]);
    MUX2_1COMP m4(a[3], sel, w[3]);
    RCA_4BIT rca(w, a, sel, y, cout);
endmodule
