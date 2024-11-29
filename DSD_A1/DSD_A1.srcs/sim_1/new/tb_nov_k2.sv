`timescale 1ns/1ps

module tb_nov_k2;
    // Parameters
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    // Testbench signals
    logic clk;
    logic reset_n;
    logic [WIDTH-1:0] R_A_out, R_B_out, R_O_out, pc;

    // Instantiate the DUT
    K2Processor #(WIDTH, DEPTH) DUT (
        .clk(clk),
        .reset_n(reset_n),
        .R_A_out(R_A_out),
        .R_B_out(R_B_out),
        .R_O_out(R_O_out),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

//    // Monitor specific memory locations
//    task monitor_memory;
//        $display("Memory Contents at time %0t:", $time);
//        for(int i = 0; i < 8; i++) begin
//            $display("Mem[%0d] = %h", i, DUT.DM.DataMemory[i]);
//        end
//    endtask

//    // Initialize instruction memory with specific test instructions
//    task initialize_instruction_memory;
//        // Format: [7:6]=JC, [5:4]=D1D0, [3]=Sreg, [2]=S, [1:0]=imm[1:0]
//        // Write instructions (J=1, C=1, D1=0)
//        // Basic operations
//        // Memory operations
//        DUT.IM.memory[0]  = 8'b10001xxx;  // Memory write
//        DUT.IM.memory[1] = 8'b10011xxx;  // Memory write
//        DUT.IM.memory[2] = 8'b00110xxx;  // Memory write
        
//       // DUT.IM.memory[0]  = 8'b00000000;  // NOP
//       // DUT.IM.memory[1]  = 8'b00010000;  
//       // DUT.IM.memory[2]  = 8'b00000100;
//        DUT.IM.memory[3]  = 8'b00010100;
//        DUT.IM.memory[4]  = 8'b00100000;
//        DUT.IM.memory[5]  = 8'b00001111;
//        DUT.IM.memory[6]  = 8'b00111100;
//        DUT.IM.memory[7]  = 8'b01110000;
//        DUT.IM.memory[8]  = 8'b10110111;  // Jump
//        // Memory operations
//        DUT.IM.memory[9]  = 8'b11001010;  // Memory write
//        DUT.IM.memory[10] = 8'b11010010;  // Memory write
//        DUT.IM.memory[11] = 8'b11100110;  // Memory write
//        DUT.IM.memory[12] = 8'b10000000;  // Jump
//    endtask

    // Test stimulus
    initial begin
        // Initialize and reset
        reset_n = 0;
//        initialize_instruction_memory();
        #20 reset_n = 1;
        
        // Test Case 1: Reset verification
        $display("\nTest Case 1: Checking reset state at time %0t", $time);
//        monitor_memory();
        #10;

        // Test Case 2: Memory Write Operations
        $display("\nTest Case 2: Memory Write Operations");
        @(posedge clk);
        
        // Wait for writes to complete
        repeat(4) @(posedge clk);
        
        $display("After write operations at time %0t:", $time);
//        monitor_memory();
        
        // Display important control signals
        $display("\nControl Signals:");
        $display("wen=%b, J=%b, C=%b, D1=%b", 
                 DUT.wen, DUT.J, DUT.C, DUT.D1);
        
        // Display memory interface signals
        $display("\nMemory Interface:");
        $display("imm=%h, Din=%h, Dout=%h", 
                 DUT.DM.imm, DUT.DM.Din, DUT.DM.Dout);

        // Run for a few more cycles
        repeat(5) @(posedge clk);
        
        $display("\nFinal Memory State at time %0t:", $time);
        //monitor_memory();
        
        #100 $finish;
    end

    // Continuous monitoring
    initial begin
        $monitor("Time=%0t reset_n=%b pc=%h wen=%b imm=%h Din=%h Dout=%h",
                 $time, reset_n, pc, DUT.wen, DUT.DM.imm, 
                 DUT.DM.Din, DUT.DM.Dout);
    end

endmodule
//
//    // Parameters
//    parameter WIDTH = 8;
//    parameter DEPTH = 16;
//
//    // Testbench signals
//    logic clk;
//    logic reset_n;
//    logic [WIDTH-1:0] R_A_out, R_B_out, R_O_out, pc;
//
//    // Instantiate the DUT (Device Under Test)
//    K2Processor #(WIDTH, DEPTH) DUT (
//        .clk(clk),
//        .reset_n(reset_n),
//        .R_A_out(R_A_out),
//        .R_B_out(R_B_out),
//        .R_O_out(R_O_out),
//        .pc(pc)
//    );
//
//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk;  // 10 ns clock period
//    end
//    
//    
//    
//
//    // Reset generation
//    initial begin
//        reset_n = 0;            // Assert reset
//        #20 reset_n = 1;        // De-assert reset after 20 ns
//    end
//
//
//initial begin
//    // Wait for reset to complete
//    #25;
//
//    // Write data to DataMemory
//    $display("Test Case 1: Write to DataMemory");
//    #10;  // Delay to synchronize with the clock
//    send_instruction(8'b00010001);  // Example instruction for write (customize as per your instruction format)
//    #10;  // Wait for operation to complete
//
//    // Read data from DataMemory
//    $display("Test Case 2: Read from DataMemory");
//    #10;
//    send_instruction(8'b00011000);  // Example instruction for read (customize as per your instruction format)
//    #10;
//
//    // Observe the DataMemory and ALU outputs
//    #50;  // Wait for some operations
//    $stop;
//end
//
//initial begin
//    // Reset and initialize
//    #10;
//    DUT.IM.memory[0] = 8'b00010010;  // Instruction for write operation
//    DUT.IM.memory[1] = 8'b00100011;  // Instruction for read operation
//end
//
//
//task send_instruction(input logic [WIDTH-1:0] instruction);
//    // Simulate loading the instruction into the processor's instruction memory
//    DUT.IM.memory[0] = instruction;  // Write to Instruction Memory at address 0
//    $display("Instruction sent: %h", instruction);
//endtask
//
//
//    // Test stimulus
//    initial begin
//        // Monitor important signals
//        $monitor("Time=%0t | reset_n=%b | R_A_out=%h | R_B_out=%h | R_O_out=%h | pc=%h",
//                 $time, reset_n, R_A_out, R_B_out, R_O_out, pc);
//
//        // Add internal signal monitoring
//        $display("Monitoring DataMemory and ALU:");
//        forever begin
//            #10;
//            $display("Time=%0t | DataMemory Output=%h | ALU Result=%h | Carry Stored=%b",
//                     $time,
//                     DUT.DM.Dout,       // DataMemory output
//                     DUT.ALU_inst.Result, // ALU result
//                     DUT.ALU_inst.stored_carry // Carry stored in ALU
//            );
//        end
//    end
//initial begin
//    forever begin
//        #10;
//        $display("Time=%0t | DataMemory Out=%h | ALU Result=%h | wen=%b",
//                 $time,
//                 DUT.DM.Dout,        // DataMemory output
//                 DUT.ALU_inst.Result, // ALU result
//                 DUT.wen             // Write enable
//        );
//    end
//end
//
//    // Test scenarios
//    initial begin
//        // Wait for reset to complete
//        #25;
//        
//        // Test Case 1: Default behavior
//        $display("Test Case 1: Default behavior after reset");
//        #50;
//
//        // Test Case 2: Stimulate DataMemory and ALU
//        $display("Test Case 2: Stimulate DataMemory and ALU");
//        #50;
//
//        // Stop simulation
//        $stop;
//    end
//endmodule
