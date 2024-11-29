module sev_seg(
  
    input wire CLK100MHZ,    // 100 MHz clock input
    input wire CPU_RESETN,   // Active-low reset input
    input wire [3:0] digits [0:7], // Array of 8 digits to display
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment outputs
    output wire [7:0] AN     // Digit enable outputs
);

    // Internal signals
    logic [6:0] Seg; // Segment data (a-g)
    logic [7:0] decoder_out; // Decoder output for active digit
    logic [19:0] count; // Counter for display speed
    logic [2:0] current_digit; // Current digit being displayed
    logic [3:0] current_value; // Current digit's value

    // Reset and clock logic
    wire resetn = CPU_RESETN;

    // Counter to generate display refresh rate
    always_ff @(posedge CLK100MHZ or negedge resetn) begin
        if (!resetn)
            count <= 20'b0;
        else
            count <= count + 1;
    end

    // Extract the current digit index from the counter
    assign current_digit = count[19:17];

    // Select the current digit value from the digits array
    assign current_value = digits[current_digit];

    // Seven-segment decoder logic
    always_comb begin
        case (current_value)
            4'd0: Seg = 7'b0000001;
            4'd1: Seg = 7'b1001111;
            4'd2: Seg = 7'b0010010;
            4'd3: Seg = 7'b0000110;
            4'd4: Seg = 7'b1001100;
            4'd5: Seg = 7'b0100100;
            4'd6: Seg = 7'b0100000;
            4'd7: Seg = 7'b0001111;
            4'd8: Seg = 7'b0000000;
            4'd9: Seg = 7'b0000100;
            4'd10: Seg = 7'b0001000;
            4'd11: Seg = 7'b1100000;
            4'd12: Seg = 7'b0110001;
            4'd13: Seg = 7'b1000010;
            4'd14: Seg = 7'b0110000;
            4'd15: Seg = 7'b0111000;
            default: Seg = 7'b1111111; // Blank
        endcase
    end

    // Decoder for active digit enable
    assign decoder_out = ~(8'b00000001 << current_digit);
    assign AN = decoder_out;

    // Assign segment outputs
    assign {CA, CB, CC, CD, CE, CF, CG} = Seg;
    assign DP = 1'b1; // Turn off the decimal point

endmodule