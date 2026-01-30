module alu (
    input [31:0] a,      // Input Number A
    input [31:0] b,      // Input Number B
    input [2:0] alu_ctrl,// Control Signal (Decides what math to do)
    output reg [31:0] result, // The Result
    output zero          // Flag: Is the result Zero? (1 if yes, 0 if no)
);

    // ALU Control Codes (We define these ourselves)
    // 000 = ADD
    // 001 = SUB
    // 010 = AND
    // 011 = OR
    // 100 = XOR
    // 101 = SLT (Set Less Than - checks if A < B)

    always @(*) begin
        case (alu_ctrl)
            3'b000: result = a + b;       // Add
            3'b001: result = a - b;       // Subtract
            3'b010: result = a & b;       // Bitwise AND
            3'b011: result = a | b;       // Bitwise OR
            3'b100: result = a ^ b;       // Bitwise XOR
            3'b101: result = (a < b) ? 32'd1 : 32'd0; // Set Less Than
            default: result = 32'd0;      // Default to 0
        endcase
    end

    // The Zero Flag is HIGH (1) only if the Result is exactly 0
    // This is useful for "Branch" instructions (like "if x = y")
    assign zero = (result == 32'd0) ? 1'b1 : 1'b0;

endmodule