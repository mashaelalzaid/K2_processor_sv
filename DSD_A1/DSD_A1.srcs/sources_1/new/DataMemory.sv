`timescale 1ns / 1ps

module DataMemory#(parameter width=8, parameter depth=8)(
input logic [2:0] imm,
input wen,
input reset,
input [width-1:0] Din,
//input wire wen, read_data,
input wire clk,
output logic [width-1:0] Dout
    );

//logic write_data = (en)? 1:0;

logic [width-1:0] DataMemory[0:depth-1];

always @(posedge clk, posedge reset) begin
    if(reset) begin 
        for(int i = 0; i< depth; i = i+1 ) begin 
            DataMemory[i] <= {width{1'b0}};
        end
        DataMemory[0] <= 0;
        DataMemory[1] <= 1; 
    end
  //writes to the memory if en is high and reads if en is low.
    if(wen) begin
        DataMemory[imm] <= Din;
    end 
    
    Dout <= DataMemory[imm];
    end
    
endmodule