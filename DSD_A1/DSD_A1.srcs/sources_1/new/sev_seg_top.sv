`timescale 1ns / 1ps

module sev_seg_top(
    input wire CLK100MHZ,       // Clock input (100 MHz)
    input wire CPU_RESETN,      // Active-low reset input
    input wire BTNC,
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment outputs
    output wire [7:0] AN,        // Digit enable outputs
    output wire [3:0] LED
    
);

    // Clock and reset signals
    wire resetn = CPU_RESETN; ///=====================================
          wire clk_1Hz;         // 1Hz clock signal for the K2Processor

    // Signals for the K2Processor
    wire [7:0] R_A_out, R_B_out, R_O_out; // Outputs for RA, RB, and RO registers
    wire [7:0] pc;                         // Program Counter (optional for debugging)

    // Instantiate the K2Processor
    K2Processor #(8, 16) processor_inst (
        .clk(BTNC),           // 1 Hz clock input          .clk(clk_1Hz),  
        .reset_n(resetn),        // Active-low reset input===========================================i switched this 
        .R_A_out(R_A_out),       // Register RA output
        .R_B_out(R_B_out),       // Register RB output
        .R_O_out(R_O_out),       // Register RO output
        .pc(pc)                  // Program Counter output (optional)
    );

    // Digits for seven-segment display
    wire [3:0] digits [0:7];
    assign digits[0] = R_A_out[3:0];    // Lower nibble of RA
    assign digits[1] = R_A_out[7:4];    // Upper nibble of RA
    assign digits[2] = R_B_out[3:0];    // Lower nibble of RB
    assign digits[3] = R_B_out[7:4];    // Upper nibble of RB
    assign digits[4] = R_O_out[3:0];    // Lower nibble of RO
    assign digits[5] = R_O_out[7:4];    // Upper nibble of RO
    assign digits[6] = pc[3:0];         // Blank
    assign digits[7] = pc[7:4];         // Blank

    // Instantiate the seven-segment display module
    sev_seg sev_seg_inst (
        .CLK100MHZ(CLK100MHZ),   // 100 MHz clock for display refresh
        .CPU_RESETN(resetn),     // Active-low reset =================
        .digits(digits),         // Input digits for display
        .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG), .DP(DP),
        .AN(AN)                  // Digit enable outputs
    );


   // assign LED[3:0] = {3'b000, clk_1Hz};
    
endmodule