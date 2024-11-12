module PIPO #(parameter WIDTH = 32)(d_out,d_in,ld,clk,rst);
    input [WIDTH-1:0] d_in;
    input ld,clk,rst;
    output reg [WIDTH-1:0] d_out;
    always @(posedge clk) begin
        if(rst) d_out<=32'd0;
        if(ld) d_out<=d_in;
    end
endmodule

module PC_adder(d_in,d_out);
   input[31:0] d_in;
   output reg[31:0] d_out;
   always @(*) begin
        d_out=d_in+32'd1;
   end
endmodule

module sign_extend_18(d_in,d_out);
    input [17:0] d_in;
    output [31:0] d_out;
    assign d_out={{14{d_in[17]}},d_in};
endmodule

module sign_extend_26(d_in,d_out);
    input [25:0] d_in;
    output [31:0] d_out;
    assign d_out={{6{d_in[25]}},d_in};
endmodule

module mux_32b_2to1 #(parameter WIDTH=32)(out,in1,in0,sel);
    input [WIDTH-1:0]in1,in0;
    input sel;
    output[WIDTH-1:0]out;
    
    assign out=sel?in1:in0;
endmodule

module mux_32b_4to1 #(parameter WIDTH=32)(out,in0,in1,in2,in3,sel);
    input[WIDTH-1:0]in0,in1,in2,in3;
    input[1:0] sel;
    output reg [WIDTH-1:0]out;
    parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;
    always @(*)begin
        case(sel)
            S0: out<=in0;
            S1: out<=in1;
            S2: out<=in2;
            S3: out<=in3;
        endcase
    end
            
endmodule

//module MUX #(parameter M = 8, WIDTH = 3)(
//    input [(1 << WIDTH) * M - 1 : 0] data_in,
//    input [WIDTH-1:0] select,
//    output reg [M-1:0] data_out
//);
//    always @(*) data_out = data_in[select * M +: M];
//endmodule

//module PIPO #(parameter WIDTH = 32) (
//    input wire [WIDTH-1:0] data_in,
//    input wire clk,
//    input wire rst,
//    input wire load,
//    output reg [WIDTH-1:0] data_out
//);
//    always @(posedge clk or posedge rst) begin
//        if (rst) data_out <= {WIDTH{1'b0}};  
//        else if (load) data_out <= data_in;      
//    end
//endmodule