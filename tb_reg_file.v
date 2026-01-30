module tb_reg_file;
    reg clk, we3;
    reg [4:0] a1, a2, a3;
    reg [31:0] wd3;
    wire [31:0] rd1, rd2;

    reg_file uut (
        .clk(clk), .we3(we3),
        .a1(a1), .a2(a2), .a3(a3),
        .wd3(wd3), .rd1(rd1), .rd2(rd2)
    );

    // Generate a Clock (Toggle every 5ns)
    always #5 clk = ~clk;

    initial begin
        $display("STARTING REGISTER FILE TEST...");
        clk = 0; we3 = 0;

        // Test 1: Write value '55' into Register x1
        $display("Writing 55 to Register x1...");
        we3 = 1; a3 = 5'd1; wd3 = 32'd55;
        #10; // Wait for clock edge

        // Test 2: Write value '99' into Register x2
        $display("Writing 99 to Register x2...");
        we3 = 1; a3 = 5'd2; wd3 = 32'd99;
        #10;

        // Test 3: Stop writing and READ both back
        we3 = 0;
        a1 = 5'd1; // Read x1
        a2 = 5'd2; // Read x2
        #10;
        
        $display("Read x1: %d (Expected 55)", rd1);
        $display("Read x2: %d (Expected 99)", rd2);

        // Test 4: Try to overwrite x0 (Should fail, x0 must stay 0)
        $display("Trying to write 777 to Register x0...");
        we3 = 1; a3 = 5'd0; wd3 = 32'd777;
        #10;
        
        we3 = 0; a1 = 5'd0; // Read x0
        #10;
        $display("Read x0: %d (Expected 0)", rd1);

        $display("TEST FINISHED.");
        $stop;
    end
endmodule