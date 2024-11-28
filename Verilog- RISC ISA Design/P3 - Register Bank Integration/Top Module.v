
module control_unit(read, write, clk, reset, out, in);
    output reg read, write;
    input clk, reset;
    output reg [15:0] out;
    input [31:0] in;

    reg [1:0] state;

    always @(negedge clk or posedge reset) begin
        if (reset) state <= 2'b00;
        else state <= (state == 2'b00) ? 2'b01 : (state == 2'b01) ? 2'b10 : (state == 2'b10) ? 2'b11 : 2'b10;
    end

    always @(state) begin
        if (state == 2'b00) begin
            read <= 1'b1;
            write <= 1'b0;
            out <= 16'b0;
        end else if (state == 2'b01) begin
            read <= 1'b0;
            write <= 1'b1;
            out <= 16'b0;
        end else if (state == 2'b10) begin
            read <= 1'b0;
            write <= 1'b0;
            out <= in[15:0];
        end else begin
            read <= 1'b0;
            write <= 1'b0;
            out <= in[31:16];
        end
    end
endmodule

module top_module(out, instruction, reset, clk);
    output [15:0] out;
    input [15:0] instruction;
    input reset, clk;

    wire [3:0] op;
    wire [3:0] rs, rt, rd;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] write_data;

    wire read;
    wire write;

    assign op = instruction[15:12];
    assign rs = instruction[11:8];
    assign rt = instruction[7:4];
    assign rd = instruction[3:0];

    control_unit c_inst(read, write, clk, reset, out, write_data);
    reg_bank reg_inst(read_data1, read_data2, rt, rd, write_data, rs, reset, clk, read, write);
    ALU32 alu_inst(op, read_data1, read_data2, write_data);
endmodule
