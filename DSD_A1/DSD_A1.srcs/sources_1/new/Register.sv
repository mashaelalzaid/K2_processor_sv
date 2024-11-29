`timescale 1ns / 1ps

module Register#(parameter n=8)(

input logic clk,
input logic [n-1:0] D,
input logic reset,
input logic en,
output logic [n-1:0] Q
    );
    
 always @(posedge clk, negedge reset)
 begin 
 if(~reset) Q<= 0;
 else if (en) Q<= D;
 end
 
    
endmodule