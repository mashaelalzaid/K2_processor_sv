`timescale 1ns / 1ps

module DFF (input logic D, input logic clk, input logic CLR_N, output logic Q, output logic Qbar);
 
wire Qm;
DLatch D1(
.D(D),
.clk(~clk),
.reset_n(CLR_N),
 .Q(Qm),
.Qbar()
    );
   

DLatch D2(
.D(Qm),
.clk(clk),
.reset_n(CLR_N),
 .Q(Q),
.Qbar(Qbar)
    );
    endmodule
