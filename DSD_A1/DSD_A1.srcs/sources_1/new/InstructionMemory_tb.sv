`timescale 1ns / 1ps

module InstructionMemory_tb;
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    logic [WIDTH-4:0] address;
    logic clk;
    wire [WIDTH-1:0] instruction;

    InstructionMemory #(WIDTH, DEPTH) IM (
        .address(address),
        .clk(clk),
        .instruction(instruction)
    );

    always #5 clk = ~clk; // Generate clock with 10ns period

    initial begin
        clk = 0;
        address = 0;

        $display("Time\tAddress\tInstruction");
        $monitor("%0t\t%b\t%b", $time, address, instruction);

        #10 address = 1; // Test instruction fetch at different addresses
        #10 address = 2;
        #10 address = 3;
        #10 address = 4;
        #10 address = 5;
        #10 address = 6;
        #10 $finish;
    end
endmodule
