`timescale 1ns / 1ps

module ALU_Registers_tb;

    // Parameters
    parameter WIDTH = 8;

    // Test signals
    logic clk, reset_n, en_R_A, en_R_B, en_R_O, S;
    logic [WIDTH-1:0] mux_out, R_A_out, R_B_out, R_O_out, alu_result;
    logic stored_carry;

    // Instantiate Registers
    Register #(WIDTH) R_A (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_A),
        .D(mux_out),
        .Q(R_A_out)
    );

    Register #(WIDTH) R_B (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_B),
        .D(mux_out),
        .Q(R_B_out)
    );

    Register #(WIDTH) R_O (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_O),
        .D(R_A_out),
        .Q(R_O_out)
    );

    // Instantiate ALU
    ALU #(WIDTH) ALU_inst (
        .clk(clk),
        .CLR_N(reset_n),
        .A(R_A_out),
        .B(R_B_out),
        .S(S),
        .Result(alu_result),
        .stored_carry(stored_carry)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        reset_n = 0; en_R_A = 0; en_R_B = 0; en_R_O = 0; mux_out = 0; S = 0;

        // Reset registers
        #10 reset_n = 1;

        // Load data into R_A and R_B
        mux_out = 8'h05; en_R_A = 1; #10; en_R_A = 0;
        mux_out = 8'h03; en_R_B = 1; #10; en_R_B = 0;

        // Perform addition
        S = 0; en_R_O = 1; #10; en_R_O = 0;

        // Perform subtraction
        S = 1; en_R_O = 1; #10; en_R_O = 0;

        $stop;
    end

endmodule
