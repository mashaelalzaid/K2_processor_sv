`timescale 1ns / 1ps


module register_behavioral_tb;
localparam n=8;
    logic clk;
    logic [n-1:0] D;
    logic reset_n;
    logic en;
    logic [n-1:0] Q;

    register #(

    .n(8)) uut(
        .clk(clk),
        .D(D),
        .reset_n(reset_n),
        .en(en),
        .Q(Q)
    );

initial begin 
clk=0;
forever #5 clk=~clk;

end 

    initial begin
        D = 4'b0000;
        en=1;
       // clk = 0;    
        reset_n = 1;  
        #3;        

        reset_n = 0;
        D= 4'b0001;  
        #3;
        
        reset_n=1;
        en =0;
        D =  4'b0001;
        //#5 clk = 1; 
       // #5 clk = 0;
        $display("D = %b, Q0 = %b", D, Q);
        #8
        D = 4'b0000;
        
        #3
        D= 4'b0001;
        en=1;
        #11
        D= 4'b0000;
        
       // #5 clk = 1; 
      //  #5 clk = 0; 
        $display("D = %b, Q0 = %b", D, Q);

        //RST_N = 0;
    //    #5 clk = 1; 
     //   #5 clk = 0; 
        $display("After reset, Q0 = %b", Q);

        
        $finish;
    end
endmodule