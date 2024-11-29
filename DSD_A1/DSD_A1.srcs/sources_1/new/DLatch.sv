`timescale 1ns / 1ps


module DLatch(
input logic D,
input logic clk,
input reset_n,
output logic Q,
output logic Qbar
    );
    
   logic w1,w2, w3, Dbar;
    /*not(Dbar,D);
    nand (w1,clk,D);
    nand (w2,clk,Dbar);
    nand (w3,w1,Qbar);
    and(Q,w3,reset_n);
    nand(Qbar,w2,Q);
    */
    
    not(Dbar,D);
    nand(w1,D,reset_n,clk);
    nand(w2,Dbar,clk);
    nand(Q,w1,Qbar);
    nand(Qbar,w2,Q,reset_n);
    /*
    
    logic w1, w2, w3, w4;
    
    nand(w1, w4, reset_n, clk);
    nand(w2, w1,w3, clk);
    nand(w3, w2, D,reset_n);
    nand(w4, w3,w1);
    nand(Q,w1,Qbar);
    nand(Qbar, w2,Q, reset_n);
    
    */
    

endmodule
