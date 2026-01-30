module imm_gen (
    input [31:0] instr,  // The full instruction
    output reg [31:0] imm_out // The extracted number (e.g., 5, 10, -1)
);

    always @(*) begin
        // For I-Type instructions (like ADDI), the Immediate is in the top 12 bits
        // We "Sign Extend" it (copy the first bit) to make it 32 bits.
        imm_out = {{20{instr[31]}}, instr[31:20]};
    end
endmodule