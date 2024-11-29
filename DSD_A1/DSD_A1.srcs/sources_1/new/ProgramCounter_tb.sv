`timescale 1ns / 1ps

module ProgramCounter_tb;
    // Parameters
    parameter WIDTH = 4;  // 4-bit counter

    // Test signals
    logic clk;
    logic reset;
    logic load;
    logic [WIDTH-1:0] custom_input;
    logic [WIDTH-1:0] counter;

    // Instantiate the ProgramCounter
    ProgramCounter #(WIDTH) uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .custom_input(custom_input),
        .counter(counter)
    );

    // Clock generation (period = 10ns)
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        load = 0;
        custom_input = 4'b0000;  // Default custom input
        #10;

        // Test 1: Apply reset
        reset = 1;
        #10;  // Wait for one clock cycle
        reset = 0;
        #10;  // Wait for one clock cycle

        // Test 2: Test normal counter increment (without load)
        #10;
        load = 0;  // Ensure load is off
        custom_input = 4'b0011; // Set a random value for custom_input
        #10;
        custom_input = 4'b0100; // Change the value of custom_input during testing
        #10;
        custom_input = 4'b0101;

        // Test 3: Load a custom value into the counter
        #10;
        load = 1;  // Activate load
        custom_input = 4'b1010;  // Load custom value
        #10;
        load = 0;  // Deactivate load and let counter increment again

        // Test 4: Ensure counter increments normally after load
        #10;
        custom_input = 4'b1100;  // Change input again to check if it doesn't affect the counter
        #10;

        // Test 5: Test counter with incrementing logic
        #10;
        load = 0;  // Ensure load is off
        custom_input = 4'b1111;
        #10;  // Check that the counter increments automatically
        #10;
        #10;

        // End the simulation
        $finish;
    end
endmodule
