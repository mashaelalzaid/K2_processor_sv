module tb_zerotrack;
    logic alu_result; 
    logic clk;
    logic CLR_N;
    logic DFF_zero;
   // Instantiate the zerotrack module
    zerotrack dut (
        .alu_result(alu_result),
        .clk(clk),
        .CLR_N(CLR_N),
        .DFF_zero(DFF_zero)
);
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end 
    initial begin
        // inputs
        alu_result = 4'b0000;
        CLR_N = 1;
      
        // Test case 1: Reset the system
        #2 CLR_N = 0; // Apply reset
        #10 CLR_N = 1; // Release reset
        $display("Test case 1: Reset applied -> DFF_zero = %b", DFF_zero);
        // Test case 2: ALU result is zero
        #10 alu_result = 4'b0000;
        #10 $display("Test case 2: ALU result = %b -> DFF_zero = %b", alu_result, DFF_zero);

        // Test case 3: ALU result is non-zero
        #10 alu_result = 4'b1010;
        #10 $display("Test case 3: ALU result = %b -> DFF_zero = %b", alu_result, DFF_zero);

        // Test case 4: ALU result goes back to zero
        #10 alu_result = 4'b0000;
        #10 $display("Test case 4: ALU result = %b -> DFF_zero = %b", alu_result, DFF_zero);

        // Test case 5: Reset during non-zero result
        #10 alu_result = 4'b1111;
        CLR_N = 0; // Apply reset
        #10 $display("Test case 5: Reset applied during non-zero ALU result -> DFF_zero = %b", DFF_zero);
        CLR_N = 1; // Release reset

      
        #20 $finish;
    end

endmodule