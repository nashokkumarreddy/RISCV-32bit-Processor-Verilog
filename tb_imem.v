module tb_imem;
    reg [31:0] a;
    wire [31:0] rd;

    imem uut (.a(a), .rd(rd));

    initial begin
        $display("STARTING INSTRUCTION MEMORY TEST...");

        // Fetch Instruction at Address 0 (Should be ADDI x1, x0, 10)
        a = 32'd0; #10;
        $display("Addr 0: %h (Expected 00a00093)", rd);

        // Fetch Instruction at Address 4 (Should be ADDI x2, x0, 20)
        a = 32'd4; #10;
        $display("Addr 4: %h (Expected 01400113)", rd);

        // Fetch Instruction at Address 8 (Should be ADD x3, x1, x2)
        a = 32'd8; #10;
        $display("Addr 8: %h (Expected 002081b3)", rd);

        $display("TEST FINISHED.");
    end
endmodule