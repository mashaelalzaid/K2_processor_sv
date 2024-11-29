
//this decoder just puts every bit at their correct location
/*
module Decoder(
    input logic [7:0] instruction, // Full instruction from InstructionMemory
    output logic J,                // Jump control
    output logic C,                // Conditional jump control
    output logic D1,               // Register selection bit 1
    output logic D0,               // Register selection bit 0
    output logic Sreg,             // MUX select for ALU or custom input
    output logic S,                // ALU operation control
    output logic imm1 ,              // Data memory write enable
        output logic imm0               // Data memory write enable
);
    always_comb begin
        // Extract control signals from the instruction
        J = instruction[7];
        C = instruction[6];
        D1 = instruction[5];
        D0 = instruction[4];
        Sreg = instruction[3];
        S = instruction[2];
        imm1 = instruction[1];
            imm0  = instruction[0];
    end
endmodule
*/
module Decoder(
    input logic [7:0] instruction, // Full instruction from InstructionMemory
    output logic J,                // Jump control
    output logic C,                // Conditional jump control
    output logic D1,               // Register selection bit 1
    output logic D0,               // Register selection bit 0
    output logic Sreg,             // MUX select for ALU or custom input
    output logic S,                // ALU operation control
    output logic [2:0] imm         // Combined immediate value
);
    always_comb begin
       

        // Extract control signals from the instruction
        J = instruction[7];         // Jump control
        C = instruction[6];         // Conditional jump
        D1 = instruction[5];        // Register selection bit 1
        D0 = instruction[4];        // Register selection bit 0
        Sreg = instruction[3];      // Select ALU or custom input
        S = instruction[2];         // ALU operation control

        // Handle immediate value
        imm = instruction[2:0];     // Extract last 3 bits as immediate value
    end
endmodule

//this decoder don't define how the jump address (the target) is calculated. 
/*
module Decoder(
    input logic [7:0] instruction, // Full instruction from InstructionMemory
    output logic J,                // Jump control
    output logic C,                // Conditional jump control
    output logic D1,               // Register selection bit 1
    output logic D0,               // Register selection bit 0
    output logic Sreg,             // MUX select for ALU or custom input
    output logic S,                // ALU operation control
    output logic wen               // Data memory write enable
);
    always_comb begin
        // Default values
        J = 0;
        C = 0;
        D1 = 0;
        D0 = 0;
        Sreg = 0;
        S = 0;
        wen = 0;

        // Decode instruction
        case (instruction[7:6]) // Opcode
            2'b00: begin // Load Immediate
                D1 = instruction[5];
                D0 = instruction[4];
                Sreg = 0; // Use immediate input
                wen = 1;  // Enable write
            end
            2'b01: begin // ALU Operation
                D1 = instruction[5];
                D0 = instruction[4];
                Sreg = 0; // Use ALU result
                S = instruction[1]; // ALU operation (ADD/SUB)
                wen = 0;  // No memory write
            end
            2'b11: begin // Jump Instructions
                J = 1; // Jump
                C = instruction[6]; // Conditional jump
            end
            default: ; // No operation (NOP)
        endcase
    end
endmodule
*/

//this is the same as the one before with added jump location management 
// I don't think it is working correctly 
/*
module Decoder(
    input logic [7:0] instruction, // Full instruction from InstructionMemory
    output logic J,                // Jump control
    output logic C,                // Conditional jump control
    output logic D1,               // Register selection bit 1
    output logic D0,               // Register selection bit 0
    output logic Sreg,             // MUX select for ALU or custom input
    output logic S,                // ALU operation control
    output logic wen,              // Data memory write enable
    output logic [3:0] custom_input // Extracted jump address (4 bits for example)
);
    always_comb begin
        // Default values
        J = 0;
        C = 0;
        D1 = 0;
        D0 = 0;
        Sreg = 0;
        S = 0;
        wen = 0;
        custom_input = 4'b0000; // Default jump target

        // Decode instruction
        case (instruction[7:6]) // Opcode
            2'b00: begin // Load Immediate
                D1 = instruction[5];
                D0 = instruction[4];
                Sreg = 1; // Use immediate input
                wen = 1;  // Enable write
            end
            2'b01: begin // ALU Operation
                D1 = instruction[5];
                D0 = instruction[4];
                Sreg = 0; // Use ALU result
                S = instruction[1]; // ALU operation (ADD/SUB)
                wen = 0;  // No memory write
            end
            2'b11: begin // Jump Instructions
                J = 1; // Jump
                C = instruction[6]; // Conditional jump
                custom_input = instruction[3:0]; // Extract jump target address
            end
            default: ; // No operation (NOP)
        endcase
    end
endmodule



*/


