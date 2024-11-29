`timescale 1ns / 1ps

module Decoder_Demux_tb;

    // Parameters
    parameter WIDTH = 8;

    // Test signals
    logic [WIDTH-1:0] instruction;
    logic J, C, D1, D0, Sreg, S, wen;
    logic en_R_A, en_R_B, en_R_O;

    // Instantiate the Decoder
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

    // Instantiate the Demux
    Demux demux_inst (
        .control({D1, D0}),
        .en_R_A(en_R_A),
        .en_R_B(en_R_B),
        .en_R_O(en_R_O)
    );

    // Test procedure
    initial begin
        // Test all instructions from Instruction Memory
        instruction = 8'b00001000; #10; // Instruction 0
        instruction = 8'b00011001; #10; // Instruction 1
        instruction = 8'b01010010; #10; // Instruction 2
        instruction = 8'b01100100; #10; // Instruction 3
        instruction = 8'b01110101; #10; // Instruction 4
        instruction = 8'b11100000; #10; // Instruction 5
        $stop;
    end

endmodule
