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
        a = 16'h0000; b = 16'h0000; cin = 0; #10;
        a = 16'hFFFF; b = 16'h0001; cin = 0; #10;
        a = 16'h1234; b = 16'h5678; cin = 1; #10;
        a = 16'hAAAA; b = 16'h5555; cin = 0; #10;
        a = 16'h0F0F; b = 16'hF0F0; cin = 1; #10;
        a = 16'h8000; b = 16'h8000; cin = 0; #10;
        a = 16'h7FFF; b = 16'h0001; cin = 1; #10;
        a = 16'h0001; b = 16'h0001; cin = 1; #10;
        $stop;
    end

    initial begin
        $monitor("At time %t, %h + %h + %b = %h (%b), BP = %b, BG = %b",
                 $time, a, b, cin, sum, cout, BP, BG);
    end
endmodule
