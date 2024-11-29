/*
module K2Processor #(parameter WIDTH = 8, parameter DEPTH = 16) (
    input logic clk,                    // Clock signal
    input logic reset_n,                // Reset signal (active low)
    input logic [WIDTH-1:0] custom_input, // Immediate data
    output logic [WIDTH-1:0] R_A_out,   // Output of R_A register
    output logic [WIDTH-1:0] R_B_out,   // Output of R_B register
    output logic [WIDTH-1:0] R_O_out,   // Output of R_O register
    output logic [WIDTH-1:0] pc         // Program Counter value
);

    // Internal signals
    logic [WIDTH-1:0] instruction;      // Instruction fetched from Instruction Memory
    logic [WIDTH-1:0] mux_out;          // MUX output
    logic [WIDTH-1:0] alu_result;       // ALU result
    logic carry_out;                    // Carry-out from ALU
    logic stored_carry;                 // Stored carry in DFF
    logic wen;                          // Write enable for Data Memory
    logic en_R_A, en_R_B, en_R_O;       // Register enable signals
    logic Sreg, S, J, C, D1, D0, imm0, imm1;        // Control signals decoded from instruction

    // 1. Program Counter

ProgramCounter #(WIDTH, DEPTH) PC (
    .clk(clk),
    .reset(~reset_n),
    .load(J | (C & stored_carry)),   // Jump or conditional jump
    .custom_input(custom_input),    // Jump target address from decoder
    .counter(pc)
);



    // 2. Instruction Memory
    InstructionMemory #(WIDTH, DEPTH) IM (
        .address(pc[WIDTH-4:0]),        // for 8 bits pc   .address(pc[WIDTH-4:0]),
        .clk(clk),
        .instruction(instruction)      // Output instruction
    );

    // 3. Decoder

    Decoder decoder_inst (
        .instruction(instruction),     // Input: Instruction from IM
        .J(J),                         // Jump control signal
        .C(C),                         // Conditional jump control
        .D1(D1),                       // Register selection bit 1
        .D0(D0),                       // Register selection bit 0
       .imm0(imm0),
       .imm1(imm1),
        .Sreg(Sreg),                   // Select signal for MUX
        .S(S)                          // ALU operation control
    );




    // 4. Demux for Register Enable Signals
    Demux demux_inst (
        .control({D1, D0}),            // Register selection control
        .en_R_A(en_R_A),               // Enable signal for R_A
        .en_R_B(en_R_B),               // Enable signal for R_B
        .en_R_O(en_R_O)                // Enable signal for R_O
    );

    // 5. MUX for Register Inputs
    mux #(WIDTH) MUX1 (
        .in0(alu_result),              // ALU output
        .in1(custom_input),            // Custom input
        .sel(Sreg),                    // Select signal
        .out(mux_out)                  // MUX output
    );

    // 6. Registers
   
    Register #(WIDTH) R_A (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_A),                   // Enable signal
        .D(mux_out),                   // Data input from MUX
        .Q(R_A_out)                    // Output
    );

    Register #(WIDTH) R_B (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_B),                   // Enable signal
        .D(mux_out),                   // Data input from MUX
        .Q(R_B_out)                    // Output
    );

    Register #(WIDTH) R_O (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_O),                   // Enable signal
        .D(R_A_out),                   // R_O stores R_A value
        .Q(R_O_out)                    // Output
    );

    // 7. ALU
     ALU #(WIDTH) ALU_inst (
        .clk(clk),
        .CLR_N(reset_n),               // Active low reset
        .A(R_A_out),                   // Input A from R_A
        .B(R_B_out),                   // Input B from R_B
        .S(S),                         // ALU operation select
        .Result(alu_result),           // ALU result
        .stored_carry(stored_carry)    // Stored carry for conditional jump
    );

    // 8. Data Memory
    
   
   // DataMemory #(WIDTH, DEPTH) DM (
     //   .imm(instruction[2:0]),        // Address from instruction
       // .wen(wen),                     // Write enable signal
     //   .reset_n(reset_n),             // Reset signal
      //  .Din(R_A_out),                 // Data input from R_A
        //.clk(clk),
       // .Dout()                        // Data output (unused for Fibonacci)
    );

endmodule 
*/
module K2Processor #(parameter WIDTH = 8, parameter DEPTH = 16) (
    input logic clk,                    // Clock signal
    input logic reset_n,                // Reset signal (active low)
    output logic [WIDTH-1:0] R_A_out,   // Output of R_A register
    output logic [WIDTH-1:0] R_B_out,   // Output of R_B register
    output logic [WIDTH-1:0] R_O_out,   // Output of R_O register
    output logic [WIDTH-1:0] pc         // Program Counter value
);

    // Internal signals
    logic [WIDTH-1:0] instruction;      // Instruction fetched from Instruction Memory
   // logic [WIDTH-1:0] mux_out;          // MUX output
    logic [WIDTH-1:0] alu_result;       // ALU result
    logic [2:0] imm_3bit;               // 3-bit immediate value from decoder
    logic [WIDTH-1:0] mux_out;              // Combined variable for imm and ALU/custom input
    logic [WIDTH-1:0] DM_IMM_mux_out;
    logic J, C, D1, D0, Sreg, S;        // Control signals from decoder
    logic en_R_A, en_R_B, en_R_O;       // Register enable signals
    logic stored_carry;                 // Stored carry in DFF

    // Program Counter
//    ProgramCounter #(WIDTH, DEPTH) PC (
//        .clk(clk),
//        .reset(~reset_n),                 // Active high reset
//        .load(J | (C & stored_carry)),    // Jump or conditional jump
//        .custom_input({5'b0, imm_3bit[2:0]}),          // Lower bits of imm for jumps/loads
//        .counter(pc)                      // Program Counter output
//    );
// Program Counter
    ProgramCounter #(WIDTH, DEPTH) PC (
        .clk(clk),
        .reset(~reset_n),                 // Active high reset
        .load(~Sreg &(J | (C & stored_carry))),    // Jump or conditional jump Nov 25
        .custom_input({5'b0, imm_3bit[2:0]}),          // Lower bits of imm for jumps/loads
        .counter(pc)                      // Program Counter output
    );
    // Instruction Memory
    InstructionMemory #(WIDTH, DEPTH) IM (
        .address(pc[WIDTH-4:0]),          // Address from Program Counter
        .clk(clk),
        .instruction(instruction)        // Fetched instruction
    );

    // Decoder
    Decoder decoder_inst (
        .instruction(instruction),       // Fetched instruction
        .J(J),                           // Jump control
        .C(C),                           // Conditional jump control
        .D1(D1),                         // Register selection bit 1
        .D0(D0),                         // Register selection bit 0
        .Sreg(Sreg),                     // Select for MUX
        .S(S),                           // ALU operation control
        .imm(imm_3bit)                   // 3-bit Immediate value
    );


    // Demux for Register Enable Signals
    Demux demux_inst (
        .control({D1, D0}),              // Register selection bits
        .en_R_A(en_R_A),                 // Enable signal for R_A
        .en_R_B(en_R_B),                 // Enable signal for R_B
        .en_R_O(en_R_O)                  // Enable signal for R_O
    );

    // Registers
    Register #(WIDTH) R_A (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_A),                     // Enable signal for R_A
        .D(DM_IMM_mux_out),                         // Data input from imm
        .Q(R_A_out)                      // Output of R_A
    );

    Register #(WIDTH) R_B (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_B),                     // Enable signal for R_B
        .D(DM_IMM_mux_out),                         // Data input from imm
        .Q(R_B_out)                      // Output of R_B
    );

    Register #(WIDTH) R_O (
        .clk(clk),
        .reset(reset_n),
        .en(en_R_O),                     // Enable signal for R_O
        .D(R_A_out),                     // R_O stores R_A value
        .Q(R_O_out)                      // Output of R_O
    );

    // ALU
    ALU #(WIDTH) ALU_inst (
        .clk(clk),
        .CLR_N(reset_n),                 // Active low reset
        .A(R_A_out),                     // Input A from R_A
        .B(R_B_out),                     // Input B from R_B
        .S(S),                           // ALU operation select
        .Result(alu_result),             // ALU result
        .stored_carry(stored_carry)      // Stored carry for conditional jump
    );
    // Nov 24 Generate wen signal for Data Memory
    assign wen = ((~J & ~C) & (D1 & D0)) ? 1: 0;
    assign load_en = (J & C)? 1:0; //nov 25;
    // Data Memory
    DataMemory #(
        .width(WIDTH),
        .depth(DEPTH)
    ) DM (
        .imm(imm_3bit),    // Use decoded immediate value
        .wen(wen),         // Write enable
        .reset(reset_n),
        .Din(instruction),     // Input from R_A
        .clk(clk),
        .Dout(dm_out)      // Memory output
    ); 
    
        // MUX for Immediate or first_mux_out Result Nov 24
    mux #(WIDTH) MUX1 (
        //.in0(first_mux_out),           // Output from first MUX change in Nov 24
        .in0(alu_result),                // ALU output
        .in1({5'b0, imm_3bit}),          // Extended 3-bit Immediate value
        .sel(Sreg),                      // Select signal
        .out(mux_out)                        // MUX output
    );

        // Nov 24 First MUX - selects between ALU result and Data Memory output
    mux #(WIDTH) MUX_DM_IMM (
        .in0(mux_out),      // ALU result when wen = 0
        .in1(dm_out),          // Memory output when wen = 1
        .sel(load_en),             // Select based on wen
        .out(DM_IMM_mux_out)    // Output to second MUX
    );
   
endmodule


 