`timescale 1ns / 1ps
/*
module K2Processor_tb();

    parameter WIDTH = 8;     // 8-bit processor
    parameter DEPTH = 16;    // Depth of instruction memory

    // Test Bench Signals
    logic clk;
    logic reset_n;
    logic [WIDTH-1:0] custom_input;
    logic [WIDTH-1:0] R_A_out;
    logic [WIDTH-1:0] R_B_out;
    logic [WIDTH-1:0] R_O_out;
    logic [WIDTH-1:0] pc;

    // Instantiate the K2Processor
    K2Processor #(WIDTH, DEPTH) DUT (
        .clk(clk),
        .reset_n(reset_n),
        .custom_input(custom_input),
        .R_A_out(R_A_out),
        .R_B_out(R_B_out),
        .R_O_out(R_O_out),
        .pc(pc)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Stimulus
    initial begin
        // Initialize inputs
        reset_n = 0;
        custom_input = 8'b00000000; // Not used for Fibonacci

        // Apply Reset
        #10 reset_n = 1;

        // Wait for Fibonacci execution
        #500;

        // End simulation
        $stop;
    end

    // Monitor Outputs
    initial begin
        $monitor("Time: %0t | PC: %b | R_A: %d | R_B: %d | R_O (Result): %d", 
                 $time, pc, R_A_out, R_B_out, R_O_out);
 
    end

endmodule


*//*
`timescale 1ns / 1ps

module tb_K2Processor;

    parameter WIDTH = 8;
    parameter DEPTH = 16;

    logic clk;
    logic reset_n;
    logic [WIDTH-1:0] custom_input;
    wire [WIDTH-1:0] R_A_out, R_B_out, R_O_out, pc;

    // Instantiate the processor
    K2Processor #(WIDTH, DEPTH) uut (
        .clk(clk),
        .reset_n(reset_n),
        .custom_input(custom_input),
        .R_A_out(R_A_out),
        .R_B_out(R_B_out),
        .R_O_out(R_O_out),
        .pc(pc)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test sequence
    initial begin
        // Initialize inputs
        reset_n = 0;
        custom_input = 0;

        // Reset the processor
        #10 reset_n = 0;

        // Run simulation for 2000ns
        #2000 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t | PC: %0h | R_A: %0d | R_B: %0d | R_O (Result): %0d",
                 $time, pc, R_A_out, R_B_out, R_O_out);
    end

endmodule

*//*
`timescale 1ns/1ps

module tb_K2Processor;
    // Parameters
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    // Testbench signals
    logic clk;
    logic reset_n;
    logic [WIDTH-1:0] custom_input;
    logic [WIDTH-1:0] R_A_out, R_B_out, R_O_out, pc;

    // Instantiate the K2Processor
    K2Processor #(WIDTH, DEPTH) uut (
        .clk(clk),
        .reset_n(reset_n),
        .custom_input(custom_input),
        .R_A_out(R_A_out),
        .R_B_out(R_B_out),
        .R_O_out(R_O_out),
        .pc(pc)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period

    // Testbench procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        custom_input = 8'b00000000;

        // Apply reset
        #10 reset_n = 1;

        // Wait for processor to execute Fibonacci
        #2000;

        // End simulation
        $stop;
    end

    // Monitor key outputs
    initial begin
        $display("Time\tPC\tR_A\tR_B\tR_O");
        $monitor("%0t\t%0h\t%0d\t%0d\t%0d", $time, pc, R_A_out, R_B_out, R_O_out);
    end
endmodule


*/
`timescale 1ns / 1ps

module tb_K2Processor;
    // Parameters
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    // Testbench signals
    reg clk;
    reg reset_n;
    reg [WIDTH-1:0] custom_input;
    wire [WIDTH-1:0] R_A_out;
    wire [WIDTH-1:0] R_B_out;
    wire [WIDTH-1:0] R_O_out;
    wire [WIDTH-1:0] pc;

    // Instantiate the K2Processor module
    K2Processor #(WIDTH, DEPTH) uut (
        .clk(clk),
        .reset_n(reset_n),
        
        .R_A_out(R_A_out),
        .R_B_out(R_B_out),
        .R_O_out(R_O_out),
        .pc(pc)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        custom_input = 8'b00000000; // Initialize custom input to 0
        #10;

        // Release reset
        reset_n = 1;

        // Monitor signals
        $monitor("Time: %0t | PC: %b | Instruction: %b | en_R_A: %b | en_R_B: %b | en_R_O: %b | Sreg: %b | R_A: %b | R_B: %b | R_O: %b",
                 $time, pc, uut.instruction, uut.en_R_A, uut.en_R_B, uut.en_R_O, uut.Sreg, R_A_out, R_B_out, R_O_out);

        // Run simulation for 1000ns
        #1000 $finish;
    end
endmodule

