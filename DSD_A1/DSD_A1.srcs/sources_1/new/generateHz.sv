module generateHz(
    input logic clk_in,         
    input logic rst,            
    output logic clk_out       
);
    parameter constantNumber = 50_000_000; 
    logic [$clog2(constantNumber)-1:0] count;

    always_ff @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count <= 0;
            clk_out <= 0;
        end else if (count == constantNumber - 1) begin
            count <= 0;
            clk_out <= ~clk_out; 
        end else begin
            count <= count + 1;
        end
    end
endmodule