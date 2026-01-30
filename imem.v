module imem (
    input [31:0] a,      // The Address (PC) coming from the processor
    output [31:0] rd     // The Instruction (Read Data) coming out
);

    // Create a memory array of 64 words (enough for small programs)
    reg [31:0] RAM[63:0];

    // INITIAL BLOCK: This is where we load our "Fake Program"
    // We are manually putting Hex codes here because we don't have an Assembler yet.
    initial begin
        // --- FIBONACCI SEQUENCE DEMO ---
        // 1. ADDI x1, x0, 1   (x1 = 1)
        RAM[0] = 32'h00100093;
        
        // 2. ADDI x2, x0, 1   (x2 = 1)
        RAM[1] = 32'h00100113;
        
        // 3. ADD x3, x1, x2   (x3 = 1 + 1 = 2)
        RAM[2] = 32'h002081B3;
        
        // 4. ADD x4, x2, x3   (x4 = 1 + 2 = 3)
        RAM[3] = 32'h00310233;
        
        // 5. ADD x5, x3, x4   (x5 = 2 + 3 = 5)
        RAM[4] = 32'h004182B3;
        
        // 6. ADD x6, x4, x5   (x6 = 3 + 5 = 8)
        RAM[5] = 32'h00520333;
        
        // 7. ADD x7, x5, x6   (x7 = 5 + 8 = 13)
        RAM[6] = 32'h006283B3;
        
        // 8. Dummy instructions (Just to hold the value)
        RAM[7] = 32'h00000013; // NOP
        RAM[8] = 32'h00000013; // NOP
    end

    // READ LOGIC
    // Note: RISC-V addresses increase by 4 (0, 4, 8, 12...)
    // But our array index increases by 1 (0, 1, 2, 3...)
    // So we cut off the last 2 bits (divide by 4) to match them.
    assign rd = RAM[a[31:2]]; 

endmodule