`timescale 1ns / 1ps

module PC_IM_tb;

    parameter WIDTH = 8;
    parameter DEPTH = 16;

    logic clk, reset, load;
    logic [WIDTH-1:0] custom_input;
    logic [WIDTH-1:0] instruction;
    logic [WIDTH-1:0] counter;

    // Instantiate Program Counter
    ProgramCounter #(WIDTH, DEPTH) PC (
        .clk(clk),
        .reset(reset),
        .load(load),
        .custom_input(custom_input),
        .counter(counter)
    );

    // Instantiate Instruction Memory
    InstructionMemory #(WIDTH, DEPTH) IM (
        .address(counter[WIDTH-4:0]), // Lower bits of Program Counter drive address
        .clk(clk),
        .instruction(instruction)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        reset = 1; load = 0; custom_input = 0;

        // Test reset
        #10 reset = 0;

        // Let counter run
        #50;

        // Test load functionality
        custom_input = 8'h05; load = 1;
        #10 load = 0;

        // Let counter run again
        #50;

        $stop;
    end

endmodule
