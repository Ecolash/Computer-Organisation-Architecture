module datapath( func, opcode, regval, sign, LoadPC, PCSel, ReadIM, LoadNPC, LoadIR, ReadRP1, ReadRP2, WriteRP, LoadA, 
    LoadB, IMMsel, LoadIMM, MUXALU1, MUXALU2, ALUFunc, LoadALUOut, ReadDM, WriteDM, LoadLMD, MUXWB, MUXMOVE, clk, rst );

    output [3:0] func;
    output [5:0] opcode;
    output [31:0] regval;
    output sign;
    input LoadPC, PCSel, ReadIM, LoadNPC, LoadIR, ReadRP1, ReadRP2;
    input WriteRP, LoadA, LoadB, IMMsel, LoadIMM, MUXALU1, MUXALU2;
    input LoadALUOut, ReadDM, WriteDM, LoadLMD, MUXWB, clk, rst;
    input [3:0] ALUFunc;
    input [1:0] MUXMOVE;

    wire [31:0] PC_in, PC_out, NPC_in, NPC_out, IR_in, IR_out, A_in, B_in, A_out, B_out;
    wire [31:0] Imm_in, Imm_out, ALUin1, ALUin2, ALUout, DM_in, DM_out, LMD_out, write_back, move_in, regbank_write;
    wire [3:0] i9_6, i13_10, i17_14;
    wire [17:0] i17_0;
    wire [25:0] i25_0;
    wire [31:0] signextend18to32;
    wire [31:0] signextend26to32;

    PIPO PC(.d_out(PC_out), .d_in(PC_in), .ld(LoadPC), .clk(clk));
    PC_adder addpc(.d_in(PC_out), .d_out(NPC_in));
    PIPO NPC(.d_out(NPC_out), .d_in(NPC_in), .ld(LoadNPC), .clk(clk));
    inst_mem INSTRMEM(.clk(clk), .addr(PC_out), .data(IR_in), .read(ReadIM));
    PIPO IR(.d_out(IR_out), .d_in(IR_in), .ld(LoadIR), .clk(clk));

    assign i9_6 = IR_out[9:6];
    assign i13_10 = IR_out[13:10];
    assign i17_14 = IR_out[17:14];
    assign i17_0 = IR_out[17:0];
    assign i25_0 = IR_out[25:0];

    reg_bank RB(
        .read_data1(A_in),
        .read_data2(B_in),
        .write_data(regbank_write),
        .read_port1(i13_10),
        .read_port2(i17_14),
        .write_port(i9_6),
        .clk(clk),
        .read(ReadRP1),
        .write(WriteRP),
        .reset(rst)
    );

    sign_extend_18 SIGNEX18TO32(.d_in(i17_0), .d_out(signextend18to32));
    sign_extend_26 SIGNEX26TO32(.d_in(i25_0), .d_out(signextend26to32));

    PIPO IMM(.d_out(Imm_out), .d_in(Imm_in), .ld(LoadIMM), .clk(clk));
    PIPO A(.d_out(A_out), .d_in(A_in), .ld(LoadA), .clk(clk));
    PIPO B(.d_out(B_out), .d_in(B_in), .ld(LoadB), .clk(clk));
    ALU32 ALU(.alu_func(ALUFunc), .A(ALUin1), .B(ALUin2), .Y(ALUout));

    PIPO ALUOUT(.d_out(DM_in), .d_in(ALUout), .ld(LoadALUOut), .clk(clk));
    data_mem DATAMEM(.clk(clk), .addr(DM_in), .write_data(B_out), .read_data(DM_out), .we(WriteDM));

    mux_32b_2to1 MUXPC(.out(PC_in), .in0(NPC_out), .in1(DM_in), .sel(PCSel));
    PIPO LMD(.d_out(LMD_out), .d_in(DM_out), .ld(LoadLMD), .clk(clk));

    mux_32b_2to1 MuxALU1(.out(ALUin1), .in1(NPC_out), .in0(A_out), .sel(MUXALU1));
    mux_32b_2to1 MuxALU2(.out(ALUin2), .in1(Imm_out), .in0(B_out), .sel(MUXALU2));
    mux_32b_2to1 MuxWB(.out(write_back), .in1(DM_in), .in0(LMD_out), .sel(MUXWB));
    mux_32b_2to1 MuxAB(.out(move_in), .in1(A_out), .in0(B_out), .sel(sign));
    mux_32b_2to1 MUXIMM(.out(Imm_in), .in1(signextend18to32), .in0(signextend26to32), .sel(IMMsel));
    mux_32b_4to1 MuxMOVE(.out(regbank_write), .in0(write_back), .in1(move_in), .in2(A_out), .in3(Imm_out), .sel(MUXMOVE));

endmodule
