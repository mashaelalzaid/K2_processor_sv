`timescale 1ns / 1ps
module RealTimeMod(
    input logic clk,         // 100MHz clock
    input logic rst,         // Reset
    output logic [6:0] segments // Seven segment display
);
    // Parameters
    parameter constantNumber = 50_000_000; // Divider for 1Hz
    parameter N = 10; // Mod-N Counter limit

    // Internal signals
    logic clk_1Hz;  // 1Hz clock
    logic [3:0] count; // Counter value

    // Clock Divider Instance
    generateHz clock_divider (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_1Hz)
    );

    // Mod-N Counter Instance
    Mod_N_Counter #(16) mod_n_counter (
        .clk(clk_1Hz),
        .rst(rst),
        .count(count)
    );

    // Seven Segment Decoder Instance
    SevenSegmentDecoder seg_decoder (
        .value(count),
        .segments(segments)
    );
endmodule

module SevenSegmentDecoder(
    input logic [3:0] value,        // Input value from counter
    output logic [6:0] segments    // Seven segment output
);
    always_comb begin
        case (value)
            4'd0: segments = 7'b1000000; // Display 0
            4'd1: segments = 7'b1111001; // Display 1
            4'd2: segments = 7'b0100100; // Display 2
            4'd3: segments = 7'b0110000; // Display 3
            4'd4: segments = 7'b0011001; // Display 4
            4'd5: segments = 7'b0010010; // Display 5
            4'd6: segments = 7'b0000010; // Display 6
            4'd7: segments = 7'b1111000; // Display 7
            4'd8: segments = 7'b0000000; // Display 8
            4'd9: segments = 7'b0010000; // Display 9
            default: segments = 7'b1111111; // Blank display
        endcase
    end
endmodule