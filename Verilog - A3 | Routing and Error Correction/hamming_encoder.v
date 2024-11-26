module hamming_encoder(d,c);
    input[3:0] d;
    output reg[6:0] c;
    always @(*)
        begin
            c[6] = d[3];
            c[5] = d[2];
            c[4] = d[1];
            c[3] = d[1]^d[2]^d[3];
            c[2] = d[0];
            c[1] = d[0]^d[2]^d[3];
            c[0] = d[0]^d[1]^d[3];
        end
endmodule