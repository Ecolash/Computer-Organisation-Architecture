module error_inject(d_orig,d_error,pos);
    input [2:0] pos;
    input [6:0]d_orig;
    output [6:0]d_error;
    reg [6:0]d_error;
    reg [6:0] flip_number;

    always @(*)
        begin
            flip_number=7'b0000000;
            flip_number[pos]=1;
            d_error<=d_orig^flip_number;
        end
endmodule