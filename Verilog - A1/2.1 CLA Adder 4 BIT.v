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

module CLA_UNIT4(a, b, cin, C);
    input [3:0] a, b;
    input cin;
    output [3:0] C;
	wire [3:0] G, P;
	 
    assign G[0]=(a[0] & b[0]);
    assign G[1]=(a[1] & b[1]);
    assign G[2]=(a[2] & b[2]);
    assign G[3]=(a[3] & b[3]);
    
    assign P[0]=(a[0] ^ b[0]);
    assign P[1]=(a[1] ^ b[1]);
    assign P[2]=(a[2] ^ b[2]);
    assign P[3]=(a[3] ^ b[3]);
    
    assign C[0]=(G[0] | (P[0] & cin));
    assign C[1]=((G[1]) | (G[0] & P[1]) | (cin & P[0] & P[1]));
    assign C[2]=((G[2]) | (G[1] & P[2]) | (G[0] & P[1] & P[2]) | (cin & P[0] & P[1] & P[2]));
    assign C[3]=((G[3]) | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (cin & P[0] & P[1] & P[2] & P[3]));
endmodule

module CLA_4BIT(a, b, cin, sum, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;
    wire [3:0] c, cx;
    
    CLA_UNIT4 clu1(a, b, cin, c);
    FA_1BIT fa1(a[0], b[0], cin, sum[0],  cx[0]);
    FA_1BIT fa2(a[1], b[1], c[0], sum[1], cx[1]);
    FA_1BIT fa3(a[2], b[2], c[1], sum[2], cx[2]);    
    FA_1BIT fa4(a[3], b[3], c[2], sum[3], cx[3]);
    assign cout = c[3];
endmodule


