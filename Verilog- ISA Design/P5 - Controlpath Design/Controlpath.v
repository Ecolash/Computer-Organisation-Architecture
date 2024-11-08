module Control_Unit( opcode, func, LoadPC, ReadIM, LoadNPC, LoadIR, ReadRP, WriteRP, LoadA, LoadB, ALUFunc,
    IMMsel, WMFC, LoadIMM, MUXALU1, MUXALU2, LoadALUOut, ReadDM, WriteDM, LoadLMD, MUXWB, MUXMOVE, HALT, clk, rst
);
    input [5:0] opcode;
    input [3:0] func;
    input clk, rst;

    output reg LoadPC, ReadIM, LoadNPC, LoadIR, ReadRP;
    output reg WriteRP, LoadA, LoadB, IMMsel, WMFC, LoadIMM, MUXALU1, MUXALU2;
    output reg LoadALUOut, ReadDM, WriteDM, LoadLMD, MUXWB, HALT;
    output reg [3:0] ALUFunc;
    output reg [1:0] MUXMOVE;

    parameter 
        ALU   = 6'b000000,
        LUI   = 6'b111111,
        ADDI  = 6'b110000,
        SUBI  = 6'b110001,
        NOTI  = 6'b110010,
        SLLI  = 6'b110011,
        ANDI  = 6'b110100,
        ORI   = 6'b110101,
        SRLI  = 6'b110110,
        SRAI  = 6'b110111,
        XORI  = 6'b111000,
        NORI  = 6'b111001,
        LD    = 6'b000001,
        ST    = 6'b000010,
        MOVE  = 6'b000111,
        CMOV  = 6'b101010,
        BR    = 6'b000011,
        BMI   = 6'b000100,
        BPL   = 6'b000101,
        BZ    = 6'b000110,
        HALT_ = 6'b001000,
        NOP   = 6'b001001;

    reg [2:0] state, next;

    parameter 
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100;

    always @(posedge clk or posedge rst) begin
        if (rst) state <= S0;
        else state <= next;
    end

    always @(*) begin
        case (state)
            S0: next = S1;
            S1: next = S2;
            S2: next = S3;
            S3: next = S4;
            S4: next = S0;
            default: next = S0;
        endcase
    end

    always @(*) begin
        LoadPC = 0; ReadIM = 0; LoadNPC = 0; LoadIR = 0; ReadRP = 0;
        WriteRP = 0; LoadA = 0; LoadB = 0; IMMsel = 0; LoadIMM = 0; MUXALU1 = 0; MUXALU2 = 0;
        LoadALUOut = 0; ReadDM = 0; WriteDM = 0; LoadLMD = 0; MUXWB = 0; MUXMOVE = 0; HALT = 0;
        ALUFunc = 0;

        case(state) 
            S0: begin
                if (opcode == HALT_) HALT <= 1;
                else begin LoadNPC <= 1; ReadIM <= 1; WMFC <= 1; end
                end

            S1: begin
                if (opcode == HALT_) HALT <= 1;
                else begin LoadIR <= 1; end
                end

            S2: begin
                case(opcode)
                    ALU:    begin LoadA <= 1; LoadB <= 1; ReadRP <= 1; ALUFunc <= func; LoadALUOut <= 1; end
                    ADDI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    SUBI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    NOTI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    SLLI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    ANDI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    ORI:    begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    SRLI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    SRAI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    XORI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    NORI:   begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    LUI:    begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; ALUFunc <= opcode[3:0]; MUXALU2 <= 1; LoadALUOut <= 1; end
                    LD:     begin LoadA <= 1; ReadRP <= 1; LoadB <= 1; LoadIMM <= 1; MUXALU2 <= 1; LoadALUOut <= 1; end
                    ST:     begin LoadA <= 1; ReadRP <= 1; LoadB <= 1; LoadIMM <= 1; MUXALU2 <= 1; LoadALUOut <= 1; end
                    BR:     begin LoadIMM <= 1; IMMsel <= 1; MUXALU2 <= 1; LoadALUOut <= 1; end
                    BPL:    begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; MUXALU1 <= 1; MUXALU2 <= 1; LoadALUOut <= 1; end
                    BMI:    begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; MUXALU1 <= 1; MUXALU2 <= 1; LoadALUOut <= 1; end
                    BZ:     begin LoadA <= 1; ReadRP <= 1; LoadIMM <= 1; MUXALU1 <= 1; MUXALU2 <= 1; LoadALUOut <= 1; end                    
                    MOVE:   begin LoadA <= 1; end
                    CMOV:   begin LoadA <= 1; LoadB <= 1; end
                    HALT_:  begin HALT <= 1; end
                endcase
                end

            S3: begin
                case(opcode)
                   LD:      begin ReadDM <= 1; WMFC <= 1; LoadPC <= 1; end
                   ST:      begin WriteDM <= 1; WMFC <= 1; LoadPC <= 1; end
                   HALT:    begin HALT <= 1; end
                   default: begin LoadPC <= 1; end
                endcase
                end

            S4: begin
                case(opcode)
                    ALU:    begin MUXWB <= 1; WriteRP <= 1; end
                    ADDI:   begin MUXWB <= 1; WriteRP <= 1; end
                    SUBI:   begin MUXWB <= 1; WriteRP <= 1; end
                    NOTI:   begin MUXWB <= 1; WriteRP <= 1; end
                    SLLI:   begin MUXWB <= 1; WriteRP <= 1; end
                    ANDI:   begin MUXWB <= 1; WriteRP <= 1; end
                    ORI:    begin MUXWB <= 1; WriteRP <= 1; end
                    SRLI:   begin MUXWB <= 1; WriteRP <= 1; end
                    SRAI:   begin MUXWB <= 1; WriteRP <= 1; end
                    XORI:   begin MUXWB <= 1; WriteRP <= 1; end
                    NORI:   begin MUXWB <= 1; WriteRP <= 1; end
                    LUI:    begin MUXWB <= 1; WriteRP <= 1; end
                    LD:     begin LoadLMD <= 1; WriteRP <= 1;  end
                    MOVE:   begin MUXMOVE <= 2'b10; WriteRP <= 1;  end
                    CMOV:   begin MUXMOVE <= 2'b01; WriteRP <= 1;  end
                    HALT:   begin HALT <= 1; end
                endcase
                end

        endcase
    end
endmodule
    

module branch_control(opcode,PCSel,in);
    input[31:0] in;
    input[5:0] opcode;
    output reg PCSel;
    
    always @(*) begin
        case(opcode) 
            6'b000011: PCSel<=1'b1;
            6'b000100: begin if(in[31]==1'b1)begin    
                            PCSel<=1'b1;
                       end else begin
                            PCSel<=1'b0;
                       end
                      end
            6'b000101: begin if(in[31]==1'b0)begin    
                            PCSel<=1'b1;
                       end else begin
                            PCSel<=1'b0;
                       end
                      end
            6'b000110: begin if(in==32'd0)begin    
                            PCSel<=1'b1;
                       end else begin
                            PCSel<=1'b0;
                       end
                      end
            default: PCSel<=1'b0;
       endcase 
    end
endmodule

module datapath(
    output[3:0] func,
    output[5:0] opcode,
    output [31:0] regval,
    output [31:0] A_out,
    output sign,
    input LoadPC,
    input PCSel,
    input ReadIM,
    input LoadNPC,
    input LoadIR,
    input ReadRP1,
    input ReadRP2,
    input WriteRP,
    input LoadA,
    input LoadB,
    input IMMsel,
    input LoadIMM,
    input MUXALU1,
    input MUXALU2,
    input [3:0] ALUFunc,
    input LoadALUOut,
    input ReadDM,
    input WriteDM,
    input LoadLMD,
    input MUXWB,
    input[1:0] MUXMOVE,
    input clk,
    input rst
    );
    wire [31:0] PC_in,PC_out,NPC_in,NPC_out,IR_in,IR_out,A_in,B_in,B_out,Imm_in,Imm_out,ALUin1,ALUin2,ALUout,DM_in,DM_out,LMD_out,write_back,move_in,regbank_write;
    wire[3:0] i9_6,i13_10,i17_14;
    wire[17:0] i17_0;
    wire[25:0] i25_0;
    wire[31:0] signextend18to32;
    wire[31:0] signextend26to32;
    
    PIPO PC(.d_out(PC_out),.d_in(PC_in),.ld(LoadPC),.clk(clk));
    
    PC_adder addpc(.d_in(PC_out),.d_out(NPC_in));
    
    PIPO NPC(.d_out(NPC_out),.d_in(NPC_in),.ld(LoadNPC),.clk(clk));
    
    inst_mem INSTRMEM(.clk(clk),.addr(PC_out),.data(IR_in),.read(ReadIM));
    
    PIPO IR(.d_out(IR_out),.d_in(IR_in),.ld(LoadIR),.clk(clk));
    
    assign i9_6=IR_out[9:6];
    assign i13_10=IR_out[13:10];
    assign i17_14=IR_out[17:14];
    assign i17_0=IR_out[17:0];
    assign i25_0=IR_out[25:0];
    
    
    reg_bank RB(.read_data1(A_in),.read_data2(B_in),.write_data(regbank_write),.read_port1(i13_10),
                    .read_port2(i17_14),.write_port(i9_6),.clk(clk),.read(ReadRP1),.write(WriteRP),.reset(rst));
                    
    sign_extend_18 SIGNEX18TO32(.d_in(i17_0),.d_out(signextend18to32));
    sign_extend_26 SIGNEX26TO32(.d_in(i25_0),.d_out(signextend26to32));
    mux_32b_2to1 MUXIMM(.out(Imm_in),.in0(signextend18to32),.in1(signextend26to32),.sel(IMMsel));
    
    PIPO IMM(.d_out(Imm_out),.d_in(Imm_in),.ld(LoadIMM),.clk(clk));
    PIPO A(.d_out(A_out),.d_in(A_in),.ld(LoadA),.clk(clk));
    PIPO B(.d_out(B_out),.d_in(B_in),.ld(LoadB),.clk(clk));
    
    mux_32b_2to1 MuxALU1(.out(ALUin1),.in1(NPC_out),.in0(A_out),.sel(MUXALU1));   
    mux_32b_2to1 MuxALU2(.out(ALUin2),.in1(Imm_out),.in0(B_out),.sel(MUXALU2));    
    
    ALU32 ALU(.alu_func(ALUFunc),.A(ALUin1),.B(ALUin2),.Y(ALUout));
    
    PIPO ALUOUT(.d_out(DM_in),.d_in(ALUout),.ld(LoadALUOut),.clk(clk));
    
    data_mem DATAMEM(.clk(clk),.addr(DM_in),.write_data(B_out),.read_data(DM_out),.we(WriteDM));
    
    mux_32b_2to1 MUXPC(.out(PC_in),.in0(NPC_out),.in1(DM_in),.sel(PCSel));
    
    PIPO LMD(.d_out(LMD_out),.d_in(DM_out),.ld(LoadLMD),.clk(clk));
    
    mux_32b_2to1 MuxWB(.out(write_back),.in1(DM_in),.in0(LMD_out),.sel(MUXWB));
    
    mux_32b_2to1 MuxAB(.out(move_in),.in1(A_out),.in0(B_out),.sel(sign));
    
    mux_32b_4to1 MuxMOVE(.out(regbank_write),.in0(write_back),.in1(move_in),.in2(A_out),.in3(Imm_out),.sel(MUXMOVE));
               
endmodule
 