`timescale 1ns / 1ps

module Demux_tb;
    logic [1:0] control;
    wire en_R_A, en_R_B, en_R_O;

    Demux demux_inst (
        .control(control),
        .en_R_A(en_R_A),
        .en_R_B(en_R_B),
        .en_R_O(en_R_O)
    );

    initial begin
        $display("Control\ten_R_A\ten_R_B\ten_R_O");
        $monitor("%b\t%b\t%b\t%b", control, en_R_A, en_R_B, en_R_O);

        control = 2'b00; #10; // Enable R_A
        control = 2'b01; #10; // Enable R_B
        control = 2'b10; #10; // Enable R_O
        control = 2'b11; #10; // Invalid (no enable)
        $finish;
    end
endmodule
