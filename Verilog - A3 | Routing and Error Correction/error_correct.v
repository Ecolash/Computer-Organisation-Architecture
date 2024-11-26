module error_correct(d_hamm,d_disp);
    input [6:0]d_hamm;
    output [3:0]d_disp;
    reg [3:0]d_disp;
    reg [6:0]d_corrected;
    reg [2:0] error;
    always @(*)
        begin
            error[0]=d_hamm[0]^d_hamm[2]^d_hamm[4]^d_hamm[6];
            error[1]=d_hamm[1]^d_hamm[2]^d_hamm[5]^d_hamm[6];
            error[2]=d_hamm[3]^d_hamm[4]^d_hamm[5]^d_hamm[6];
            error=error[0] + (error[1]<<1)+ (error[2]<<2);
            d_corrected=d_hamm;
            if(error!=3'b000)
                begin
                    d_corrected[error-1]=~d_corrected[error-1];
                end
            d_disp[0]=d_corrected[2];
            d_disp[1]=d_corrected[4];
            d_disp[2]=d_corrected[5];
            d_disp[3]=d_corrected[6];
        end

endmodule