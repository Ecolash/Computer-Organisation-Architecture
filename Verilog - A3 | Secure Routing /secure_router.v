
module secure_router(d_in,d_out0,d_out1,d_out2,d_out3);
    input [5:0] d_in;
    output reg [6:0] d_out0,d_out1,d_out2,d_out3;
    wire [6:0] decoded;
    hamming_encoder H ( .d(d_in[3:0]), .c(decoded));
    always @(*) begin
        case (d_in[5:4])
  
            2'b00: begin
                d_out0 = decoded;
                d_out1 = 7'b0000000;
                d_out2 = 7'b0000000;
                d_out3 = 7'b0000000;
            end
            2'b01: begin
                d_out0 = 7'b0000000;
                d_out1 = decoded;
                d_out2 = 7'b0000000;
                d_out3 = 7'b0000000;
            end
            2'b10:  begin
                d_out0 = 7'b0000000;
                d_out1 = 7'b0000000;
                d_out2 = decoded;
                d_out3 = 7'b0000000;
            end
            2'b11: begin
                d_out0 = 7'b0000000;
                d_out1 = 7'b0000000;
                d_out2 = 7'b0000000;
                d_out3 = decoded;
            end
        endcase
    end
endmodule