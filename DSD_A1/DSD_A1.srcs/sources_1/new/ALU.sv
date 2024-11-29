
//this ALU doesn't consider carry so I will comment it for now 
/* 
module ALU #(parameter WIDTH = 4) (
    input logic clk,                     // Clock signal for DFF
    input logic [WIDTH-1:0] A, B,        // ALU inputs
    input logic S,                       // 0 for addition, 1 for subtraction
    output logic [WIDTH-1:0] Result,     // ALU output
    output logic stored_carry            // Stored carry-out from DFF
);
    logic [WIDTH-1:0] B_modified; // B after XOR
        logic carry_out;                     // Current carry-out from operation
    logic carry_dff;                     // Internal DFF to store carry-out

    // XOR gate to invert B when performing subtraction
    assign B_modified = B ^ {WIDTH{S}};

    always_comb begin
        // Perform addition with B_modified and carry_in
        {carry_out, Result} = A + B_modified + S;

    end
endmodule
*/
module ALU #(parameter WIDTH = 4) (
    input logic clk,                     // Clock signal for DFF
    input logic CLR_N,                   // Clear signal for DFF (active low)
    input logic [WIDTH-1:0] A, B,        // ALU inputs
    input logic S,                       // 0 for addition, 1 for subtraction
    output logic [WIDTH-1:0] Result,     // ALU output
    output logic stored_carry            // Stored carry-out from DFF
);
    logic [WIDTH-1:0] B_modified;        // Modified B after XOR
    logic carry_out;                     // Current carry-out from operation
    logic Qbar;                          // Unused output of the DFF

    // XOR to invert B for subtraction
    assign B_modified = B ^ {WIDTH{S}};

    always_comb begin
        // Perform addition/subtraction
        {carry_out, Result} = A + B_modified + S;
    end

    // Instantiate the DFF to store carry-out
    DFF carry_storage (
        .D(carry_out),       // Carry-out as input to DFF
        .clk(clk),           // Clock signal
        .CLR_N(CLR_N),       // Active low clear signal
        .Q(stored_carry),    // Stored carry as output
        .Qbar(Qbar)          // Complement of stored carry (unused)
    );

endmodule

