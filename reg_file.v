module reg_file (
    input clk,               // Clock signal (we write on the "edge" of the clock)
    input we3,               // Write Enable: "1" means save data, "0" means don't save
    input [4:0] a1, a2, a3,  // Addresses: a1/a2 are for reading, a3 is for writing
    input [31:0] wd3,        // Write Data: The number we want to save
    output [31:0] rd1, rd2   // Read Data: The numbers coming out
);

    // Create the memory: 32 registers, each 32 bits wide
    reg [31:0] rf[31:0];

    // READ LOGIC (Combinational)
    // If address is 0, output 0 (Hardwired Zero). Otherwise, read from array.
    assign rd1 = (a1 == 5'b0) ? 32'b0 : rf[a1];
    assign rd2 = (a2 == 5'b0) ? 32'b0 : rf[a2];

    // WRITE LOGIC (Sequential)
    // Only write on the positive edge of the clock
    always @(posedge clk) begin
        if (we3) begin
            rf[a3] <= wd3;
        end
    end

endmodule