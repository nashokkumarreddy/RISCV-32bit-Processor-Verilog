module tb_alu;
    // 1. Declare inputs as "reg" and outputs as "wire"
    reg [31:0] a, b;
    reg [2:0] alu_ctrl;
    wire [31:0] result;
    wire zero;

    // 2. Connect this Testbench to your ALU Design
    alu uut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    // 3. The Testing Logic
    initial begin
        $display("STARTING ALU SIMULATION...");
        
        // Test 1: ADDITION (10 + 20)
        a = 32'd10; b = 32'd20; alu_ctrl = 3'b000; 
        #10; // Wait 10 nanoseconds
        $display("ADD: %d + %d = %d (Expected 30)", a, b, result);

        // Test 2: SUBTRACTION (50 - 20)
        a = 32'd50; b = 32'd20; alu_ctrl = 3'b001; 
        #10;
        $display("SUB: %d - %d = %d (Expected 30)", a, b, result);

        // Test 3: AND (Binary Logic)
        a = 32'hFF; b = 32'h0F; alu_ctrl = 3'b010; 
        #10;
        $display("AND: %h & %h = %h (Expected 0000000f)", a, b, result);

        // Test 4: ZERO FLAG CHECK (20 - 20)
        a = 32'd20; b = 32'd20; alu_ctrl = 3'b001; // Subtract
        #10;
        $display("ZERO CHECK: %d - %d = %d | Zero Flag = %b (Expected 1)", a, b, result, zero);

        $display("SIMULATION FINISHED.");
    end
endmodule