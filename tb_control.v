module tb_control;
    reg [6:0] opcode, funct7;
    reg [2:0] funct3;
    wire reg_write, alu_src;
    wire [2:0] alu_ctrl;

    control_unit uut (
        .opcode(opcode), .funct3(funct3), .funct7(funct7),
        .reg_write(reg_write), .alu_src(alu_src), .alu_ctrl(alu_ctrl)
    );

    initial begin
        $display("STARTING CONTROL UNIT TEST...");

        // Test 1: R-Type ADD (Opcode 0110011, Funct3 000, Funct7 0000000)
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000;
        #10;
        $display("ADD Instruction -> RegWrite: %b, ALUSrc: %b, ALUCtrl: %b (Exp: 1, 0, 000)", reg_write, alu_src, alu_ctrl);

        // Test 2: R-Type SUB (Opcode 0110011, Funct3 000, Funct7 0100000)
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000;
        #10;
        $display("SUB Instruction -> RegWrite: %b, ALUSrc: %b, ALUCtrl: %b (Exp: 1, 0, 001)", reg_write, alu_src, alu_ctrl);

        // Test 3: I-Type ADDI (Opcode 0010011, Funct3 000)
        opcode = 7'b0010011; funct3 = 3'b000; funct7 = 7'b0000000; // Funct7 ignored for ADDI
        #10;
        $display("ADDI Instruction -> RegWrite: %b, ALUSrc: %b (Exp: 1, 1)", reg_write, alu_src);

        $display("TEST FINISHED.");
    end
endmodule