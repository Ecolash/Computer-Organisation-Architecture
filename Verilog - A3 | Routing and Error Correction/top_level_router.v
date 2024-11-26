module top_level_router(input [5:0] d_in,output [3:0] d_disp0, d_disp1, d_disp2, d_disp3);

    wire [6:0] d_out0, d_out1, d_out2, d_out3;
    wire [6:0] d_error0, d_error1, d_error2, d_error3;
    secure_router R0(.d_in(d_in), .d_out0(d_out0), .d_out1(d_out1), .d_out2(d_out2),.d_out3(d_out3));

    error_inject EI0(.d_orig(d_out0),.d_error(d_error0),.pos(3'b010));
    error_inject EI1(.d_orig(d_out1),.d_error(d_error1),.pos(3'b010));
    error_inject EI2(.d_orig(d_out2),.d_error(d_error2),.pos(3'b010));
    error_inject EI3(.d_orig(d_out3),.d_error(d_error3),.pos(3'b010));

    error_correct EC0(.d_hamm(d_error0),.d_disp(d_disp0));
    error_correct EC1(.d_hamm(d_error1),.d_disp(d_disp1));
    error_correct EC2(.d_hamm(d_error2),.d_disp(d_disp2));
    error_correct EC3(.d_hamm(d_error3),.d_disp(d_disp3));
endmodule
