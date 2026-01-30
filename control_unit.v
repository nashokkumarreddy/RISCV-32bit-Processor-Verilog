module control_unit (
    input [6:0] opcode,    // The main ID of the instruction
    input [2:0] funct3,    // Extra ID (e.g., distinguishing ADD vs OR)
    input [6:0] funct7,    // Extra ID (e.g., distinguishing ADD vs SUB)
    output reg reg_write,  // 1 = Write to Register
    output reg alu_src,    // 0 = Read Register, 1 = Read Immediate
    output reg [2:0] alu_ctrl // The command for the ALU
);

    always @(*) begin
        // DEFAULT VALUES (To prevent "latches")
        reg_write = 0;
        alu_src = 0;
        alu_ctrl = 3'b000;

        case(opcode)
            // 1. R-TYPE Instructions (ADD, SUB, AND, OR, etc.)
            // Opcode: 0110011
            7'b0110011: begin
                reg_write = 1; // We want to save the result
                alu_src = 0;   // Use Register B, not Immediate
                
                // Check Funct3 and Funct7 to pick the specific math
                case({funct7, funct3}) 
                    10'b0000000_000: alu_ctrl = 3'b000; // ADD
                    10'b0100000_000: alu_ctrl = 3'b001; // SUB
                    10'b0000000_111: alu_ctrl = 3'b010; // AND
                    10'b0000000_110: alu_ctrl = 3'b011; // OR
                    default: alu_ctrl = 3'b000;
                endcase
            end

            // 2. I-TYPE Instructions (ADDI - Add Immediate)
            // Opcode: 0010011
            7'b0010011: begin
                reg_write = 1; // Save the result
                alu_src = 1;   // Use the "Immediate" number (e.g., the "5" in ADDI x1, x0, 5)
                
                // For ADDI, Funct3 is 000
                if (funct3 == 3'b000) 
                    alu_ctrl = 3'b000; // Perform ADD
            end

            // (You will add LW and SW here later)
            default: begin
                reg_write = 0;
                alu_src = 0;
                alu_ctrl = 3'b000;
            end
        endcase
    end
endmodule