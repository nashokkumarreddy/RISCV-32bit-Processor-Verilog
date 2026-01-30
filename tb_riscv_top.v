module tb_riscv_top;
    reg clk;
    reg reset;

    // Connect to the processor
    riscv_top uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock Generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        $display("STARTING RISC-V PROCESSOR SIMULATION...");
        
        // Initialize
        clk = 0;
        reset = 1;
        #10;
        
        // Release Reset (Let the processor start!)
        reset = 0;
        
        // Run for enough time to finish our 3 instructions
        #200;
        
        $display("SIMULATION FINISHED.");
        $stop;
    end
endmodule