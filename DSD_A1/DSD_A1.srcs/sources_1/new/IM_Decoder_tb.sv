`timescale 1ns / 1ps

module IM_Decoder_tb;

    parameter WIDTH = 8;
    parameter DEPTH = 16;

    logic clk;
    logic [WIDTH-1:0] instruction;
    logic [WIDTH-4:0] address;
    logic J, C, D1, D0, Sreg, S, wen;

    // Instantiate Instruction Memory
    InstructionMemory #(WIDTH, DEPTH) IM (
        .address(address),
        .clk(clk),
        .instruction(instruction)
    );

    // Instantiate Decoder
    Decoder decoder_inst (
        .instruction(instruction),
        .J(J),
        .C(C),
        .D1(D1),
        .D0(D0),
        .Sreg(Sreg),
        .S(S),
        .wen(wen)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Test each address in instruction memory
        for (address = 0; address < DEPTH; address = address + 1) begin
            #10;
        end
        $stop;
    end

endmodule

