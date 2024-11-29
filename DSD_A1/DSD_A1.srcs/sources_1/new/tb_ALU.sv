`timescale 1ns / 1ps

module tb_ALU;

    // Parameters
    parameter WIDTH = 4;

    // Test signals
    logic clk;
    logic CLR_N;
    logic [WIDTH-1:0] A, B;
    logic S;
    logic [WIDTH-1:0] Result;
    logic stored_carry;

    // Instantiate the ALU
    ALU #(WIDTH) uut (
        .clk(clk),
        .CLR_N(CLR_N),
        .A(A),
        .B(B),
        .S(S),
        .Result(Result),
        .stored_carry(stored_carry)
    );

    // Clock generation (period = 10ns)
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        CLR_N = 0;        // Active low clear signal (clear the DFF at the start)
        A = 4'b0000;
        B = 4'b0000;
        S = 0;            // Start with addition

        // Display output for debugging
        $monitor("Time=%0t | A=%b | B=%b | S=%b | Result=%b | stored_carry=%b", 
                 $time, A, B, S, Result, stored_carry);

        // Test 1: Initialize and clear the DFF
        #10;              // Wait for initial reset
        CLR_N = 1;        // Deassert CLR_N to stop clearing the DFF
        
        // Test 2: Addition, A + B
        #10;
        A = 4'b0011;    // A = 3
        B = 4'b0101;    // B = 5
        S = 0;          // Addition
        #10;            // Wait for one clock cycle

        // Test 3: Subtraction, A - B
        #10;
        A = 4'b0101;    // A = 5
        B = 4'b0011;    // B = 3
        S = 1;          // Subtraction
        #10;            // Wait for one clock cycle

        // Test 4: Check carry behavior in subtraction (borrow)
        #10;
        A = 4'b0001;    // A = 1
        B = 4'b0010;    // B = 2
        S = 1;          // Subtraction (will generate borrow)
        #10;            // Wait for one clock cycle

        // Test 5: Another addition with carry
        #10;
        A = 4'b1111;    // A = 15
        B = 4'b0001;    // B = 1
        S = 0;          // Addition
        #10;            // Wait for one clock cycle
#10;
        // End the simulation
        $finish;
    end
endmodule

