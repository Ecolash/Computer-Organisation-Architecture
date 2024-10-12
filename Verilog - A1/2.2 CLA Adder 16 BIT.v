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

module CLA_UNIT4_v2(a, b, cin, C, G, P);
    input [3:0] a, b;
    input cin;
    output [4:0] C, G, P;
     
    assign G[0] = (a[0] & b[0]);
    assign G[1] = (a[1] & b[1]);
    assign G[2] = (a[2] & b[2]);
    assign G[3] = (a[3] & b[3]);
    
    assign P[0] = (a[0] ^ b[0]);
    assign P[1] = (a[1] ^ b[1]);
    assign P[2] = (a[2] ^ b[2]);
    assign P[3] = (a[3] ^ b[3]);
    
    assign C[0] = cin;
    assign C[1] = G[0] | (P[0] & cin);
    assign C[2] = G[1] | (P[1] & (G[0] | (P[0] & cin)));
    assign C[3] = G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & cin)))));
    assign C[4] = G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & cin)))))));
endmodule

module CLA_4BIT_v2(a, b, cin, sum, cout, pout, gout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout, pout, gout;
    wire [4:0] c, g, p;

    CLA_UNIT4_v2 clu1(a, b, cin, c, g, p);
    FA_1BIT fa1(a[0], b[0], c[0], sum[0], );
    FA_1BIT fa2(a[1], b[1], c[1], sum[1], );
    FA_1BIT fa3(a[2], b[2], c[2], sum[2], );    
    FA_1BIT fa4(a[3], b[3], c[3], sum[3], );
    
    assign cout = c[4];
    assign pout = (p[3] & p[2] & p[1] & p[0]);
    assign gout = (g[3] | (g[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[0] & p[1] & p[2] & p[3]));
endmodule

module CLA_UNIT16BIT(P, G, cin, C, BP, BG);
    input[3:0] P, G;
    input cin;	
    output[3:0] C;
    output BP, BG;
	assign C[0] = G[0] | (P[0] & cin) ;	
	assign C[1] = G[1] | (P[1] & (G[0] | (P[0] & cin))) ;	
	assign C[2] = G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & cin))))) ;	
	assign C[3] = G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & cin))))))) ;	

	assign BP = P[0] & P[1] & P[2] & P[3] ;
	assign BG = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) ;
endmodule

module CLA_16BIT(a, b, cin, sum, cout, BP, BG);
    input [15:0] a, b;
    input cin;
    output [15:0] sum;
    output cout, BP, BG;
    wire [3:0] P, G, C;

    CLA_4BIT_v2 cla0(a[3:0], b[3:0], cin, sum[3:0], C[0], P[0], G[0]);
    CLA_4BIT_v2 cla1(a[7:4], b[7:4], C[0], sum[7:4], C[1], P[1], G[1]);
    CLA_4BIT_v2 cla2(a[11:8], b[11:8], C[1], sum[11:8], C[2], P[2], G[2]);
    CLA_4BIT_v2 cla3(a[15:12], b[15:12], C[2], sum[15:12], C[3], P[3], G[3]);

    assign cout = C[3];
    CLA_UNIT16BIT clu16(P, G, cin, C, BP, BG);
endmodule
module CLA_16BIT_tb;
    reg [15:0] a, b;
    reg cin;
    wire [15:0] sum;
    wire cout, BP, BG;

    CLA_16BIT uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout),
        .BP(BP),
        .BG(BG)
    );

    initial begin
        // Initialize inputs
        a = 16'h0000; b = 16'h0000; cin = 0;
        #10;
        a = 16'hFFFF; b = 16'h0001; cin = 0;
        #10;
        a = 16'h1234; b = 16'h5678; cin = 1;
        #10;
        a = 16'hAAAA; b = 16'h5555; cin = 0;
        #10;
        a = 16'h0F0F; b = 16'hF0F0; cin = 1;
        #10;
        $stop;
    end

    initial begin
        $monitor("At time %t, a = %h, b = %h, cin = %b, sum = %h, cout = %b, BP = %b, BG = %b",
                 $time, a, b, cin, sum, cout, BP, BG);
    end
endmodule