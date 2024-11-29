`timescale 1ns / 1ps
module zerotrack #(parameter width = 4) ( 
    input [width-1:0] alu_result, 
    input clk, 
    input CLR_N, 
    output logic DFF_zero,
    output logic jump,
    output logic jump_carry 
);
    logic zero_detect; // NOR gate output to detect if ALU result is zero
    assign zero_detect = ~|alu_result; // NOR gate to check if all bits of alu_result are zero
    
    always @(posedge clk or negedge CLR_N) begin
        if (~CLR_N)
            DFF_zero <= 0; // Reset DFF to 0
        else if (zero_detect)
            DFF_zero <= 1; // Set DFF when ALU result is zero
    end
assign jump = DFF_zero & ~alu_result[width-1]; // jump
    assign jump_carry = DFF_zero & alu_result[width-1]; // jump carry

    endmodule