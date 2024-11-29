/*
//This is a regular counter MOD-N Counter is better but they both work
module ProgramCounter #(parameter WIDTH = 4) (
    input logic clk, reset, load,
    input logic [WIDTH-1:0] custom_input,
    output logic [WIDTH-1:0] counter
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 0;
        else if (load)
            counter <= custom_input;
        else
            counter <= counter + 1;
    end
endmodule
*/

/*
//Mod-N Counter
module ProgramCounter #(parameter WIDTH = 8, parameter N = 256) (
    input logic clk, reset, load,
    input logic [WIDTH-1:0] custom_input,
    output logic [WIDTH-1:0] counter
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 0; // Reset counter to 0
        else if (load)
            counter <= custom_input; // Load custom input into the counter
        else if (counter == N-1)
            counter <= 0; // Wrap around when reaching N-1
        else
            counter <= counter + 1; // Increment counter
    end
endmodule
*/

module ProgramCounter #(parameter WIDTH = 4, parameter N = 16) (
    input logic clk, 
    input logic reset, 
    input logic load,
    input logic [WIDTH-1:0] custom_input,
    output logic [WIDTH-1:0] counter
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 0; // Reset counter to 0
        else if (load)
            counter <= custom_input; // Load custom input into the counter
        else if (counter == N-1)
            counter <= 0; // Wrap around when reaching N-1
        else
            counter <= counter + 1; // Increment counter
    end
endmodule
