/*module InstructionMemory #(parameter WIDTH = 8, parameter DEPTH = 16) (
    input logic [WIDTH-4:0] address, // Address from Program Counter (lower bits)
    input logic clk,                // Clock signal
    output logic [WIDTH-1:0] instruction // Output instruction
);

    // Memory to store instructions
    logic [WIDTH-1:0] memory [0:DEPTH-1];

    // Initialize memory with Fibonacci instructions
    initial begin
        memory[0] = 8'b00001000; // Load R_A with 0 (First Fibonacci number)
        memory[1] = 8'b00011001; // Load R_B with 1 (Second Fibonacci number)
        memory[2] = 8'b01010010; // Add R_A and R_B, store result in R_O
        memory[3] = 8'b01100100; // Move R_B to R_A
        memory[4] = 8'b01110101; // Move R_O to R_B
        memory[5] = 8'b11100000; // Jump to instruction 2 (loop back)
        memory[6] = 8'b00000000; // NOP (end, unused memory)
        // Fill unused memory with zeros
        for (int i = 7; i < DEPTH; i = i + 1) memory[i] = 8'b00000000;
    end

    // Output the instruction based on the address
    always_ff @(posedge clk) begin
        instruction <= memory[address];
    end

endmodule
*/
module InstructionMemory #(parameter WIDTH = 8, parameter DEPTH = 16) (
    input logic [WIDTH-4:0] address, // Address from Program Counter (lower bits)
    input logic clk,                // Clock signal
    output logic [WIDTH-1:0] instruction // Output instruction
);

    // Memory to store instructions
    logic [WIDTH-1:0] memory [0:DEPTH-1];

    // Initialize memory with Fibonacci instructions
initial begin

//     memory[0]  = 8'b10001xxx;  // Memory write
//     memory[1] = 8'b10011xxx;  // Memory write
//     memory[2] = 8'b00110xxx;  // Memory write
       
//    memory[0]  = 8'b00000000;  // NOP
//    memory[1]  = 8'b00010000;  
//    memory[2]  = 8'b00000100;
//     memory[3]  = 8'b00010100;
//     memory[4]  = 8'b00100000;
//     memory[5]  = 8'b00001111;
//     memory[6]  = 8'b00111100;
//     memory[7]  = 8'b01110000;
//     memory[8]  = 8'b10110111;  // Jump
//     //memory operations
//     memory[9]  = 8'b11001010;  // Memory write
//     memory[10] = 8'b11010010;  // Memory write
//     memory[11] = 8'b11100110;  // Memory write
//     memory[12] = 8'b10000000;  // Jump

        memory[0] = 8'b00001000;
        memory[1] = 8'b00011001;
        memory[2] = 8'b00100000;
    memory[3] = 8'b00010000;
      memory[4] = 8'b01110000;
       memory[5] = 8'b00000000;
      memory[6] = 8'b00010100;
     memory[7] = 8'b00000100;
       memory[8] = 8'b10110010;
            
        for (int i = 9; i < DEPTH; i++) memory[i] = 8'b00000000; // Fill unused memory
    end

    // Combinational read
    assign instruction = memory[address]; // Directly assign instruction based on address

endmodule
