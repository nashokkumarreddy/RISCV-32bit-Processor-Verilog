module riscv_top (
    input clk,
    input reset
);
    // Wires to connect modules
    reg [31:0] PC;          // Program Counter
    wire [31:0] PC_Next;    // Next value of PC
    wire [31:0] Instr;      // The Instruction from Memory
    wire [31:0] ALUResult;  // Result from math
    wire [31:0] RD1, RD2;   // Values read from Registers
    wire [31:0] ImmExt;     // Extended Immediate value
    wire [31:0] SrcB;       // The second input to the ALU (Multiplexer)
    
    // Control Signals
    wire RegWrite, ALUSrc, Zero;
    wire [2:0] ALUControl;

    // ----------------------------------------------------------------
    // 1. PROGRAM COUNTER LOGIC
    // ----------------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'b0;      // Reset to 0
        else
            PC <= PC + 4;     // Move to next instruction (Address + 4)
    end

    // ----------------------------------------------------------------
    // 2. INSTRUCTION MEMORY (The Map)
    // ----------------------------------------------------------------
    imem instr_mem (
        .a(PC),
        .rd(Instr)
    );

    // ----------------------------------------------------------------
    // 3. CONTROL UNIT (The Brain)
    // ----------------------------------------------------------------
    control_unit ctrl (
        .opcode(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7(Instr[31:25]),
        .reg_write(RegWrite),
        .alu_src(ALUSrc),
        .alu_ctrl(ALUControl)
    );

    // ----------------------------------------------------------------
    // 4. REGISTER FILE (The Storage)
    // ----------------------------------------------------------------
    reg_file rf (
        .clk(clk),
        .we3(RegWrite),
        .a1(Instr[19:15]),  // Source Register 1 (rs1)
        .a2(Instr[24:20]),  // Source Register 2 (rs2)
        .a3(Instr[11:7]),   // Destination Register (rd)
        .wd3(ALUResult),    // Data to write (Result from ALU)
        .rd1(RD1),
        .rd2(RD2)
    );

    // ----------------------------------------------------------------
    // 5. IMMEDIATE GENERATOR (The Extractor)
    // ----------------------------------------------------------------
    imm_gen ig (
        .instr(Instr),
        .imm_out(ImmExt)
    );

    // ----------------------------------------------------------------
    // 6. ALU MULTIPLEXER (The Switch)
    // ----------------------------------------------------------------
    // If ALUSrc is 0, use Register 2. If 1, use Immediate.
    assign SrcB = (ALUSrc) ? ImmExt : RD2;

    // ----------------------------------------------------------------
    // 7. ALU (The Calculator)
    // ----------------------------------------------------------------
    alu my_alu (
        .a(RD1),
        .b(SrcB),
        .alu_ctrl(ALUControl),
        .result(ALUResult),
        .zero(Zero)
    );

endmodule