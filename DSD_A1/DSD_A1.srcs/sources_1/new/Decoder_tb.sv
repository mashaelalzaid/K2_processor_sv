`timescale 1ns / 1ps

module Decoder_tb;
    logic [7:0] instruction;
    wire J, C, D1, D0, Sreg, S, wen;

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

    initial begin
        $display("Instruction\tJ\tC\tD1\tD0\tSreg\tS\twen");
        $monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", instruction, J, C, D1, D0, Sreg, S, wen);

        instruction = 8'b00001000; #10; // Load R_A with 0
        instruction = 8'b00011001; #10; // Load R_B with 1
        instruction = 8'b01010010; #10; // ADD R_A, R_B -> R_O
        instruction = 8'b01100100; #10; // Move R_B -> R_A
        instruction = 8'b01110101; #10; // Move R_O -> R_B
        instruction = 8'b11100000; #10; // Jump to instruction 2
        $finish;
    end
endmodule
