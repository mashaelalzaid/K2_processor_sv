module Demux(
    input logic [1:0] control, // D1, D0 from instruction
    output logic en_R_A,       // Enable for R_A
    output logic en_R_B,       // Enable for R_B
    output logic en_R_O        // Enable for R_O
);
    always_comb begin
        // Default values (no register is enabled)
        en_R_A = 0;
        en_R_B = 0;
        en_R_O = 0;

        // Enable based on control inputs
        case (control)
            2'b00: en_R_A = 1; // Enable R_A
            2'b01: en_R_B = 1; // Enable R_B
            2'b10: en_R_O = 1; // Enable R_O
            default: ;         // No enable for other cases
        endcase
    end
endmodule
