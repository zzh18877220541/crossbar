`timescale 1ns / 1ps

module tb_inputQueue;

    // Parameters
    parameter width = 8;
    parameter depth = 4;

    // Inputs
    reg clk;
    reg rst;
    reg [width-1:0] in;
    reg [1:0] sel;
    reg [3:0] grant0, grant1, grant2, grant3;
    reg [1:0] id;

    // Outputs
    wire [1:0] sel_out;
    wire [width:0] output0, output1, output2, output3;

    // Instantiate the Unit Under Test (UUT)
    inputQueue #(
        .width(width),
        .depth(depth)
    ) uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .sel(sel),
        .grant0(grant0),
        .grant1(grant1),
        .grant2(grant2),
        .grant3(grant3),
        .id(id),
        .sel_out(sel_out),
        .output0(output0),
        .output1(output1),
        .output2(output2),
        .output3(output3)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    // Testbench logic
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        in = 0;
        sel = 0;
        grant0 = 0;
        grant1 = 0;
        grant2 = 0;
        grant3 = 0;
        id = 0;

        // Reset the system
        #10;
        rst = 0;

        // Set id to 0
        id = 2'b00;

        // Cycle 1: Input in = AA, sel = 0, all grant = 0
        in = 8'hAA;
        sel = 2'b00;
        #10;  // Wait for one clock cycle

        // Cycle 2: Input in = BB, sel = 1, all grant = 0
        in = 8'hBB;
        sel = 2'b01;
        #10;  // Wait for one clock cycle

        // Cycle 3: Input in = CC, sel = 2, all grant = 0
        in = 8'hCC;
        sel = 2'b10;
        #10;  // Wait for one clock cycle

        // Cycle 4: Input in = DD, sel = 3, all grant = 0
        in = 8'hDD;
        sel = 2'b11;
        #10;  // Wait for one clock cycle

        // Cycle 5: grant0 = 0001, others = 0
        grant0 = 4'b0001;
        grant1 = 4'b0000;
        grant2 = 4'b0000;
        grant3 = 4'b0000;
        #10;  // Wait for one clock cycle

        // Cycle 6: grant1 = 1101, others = 0
        grant0 = 4'b0000;
        grant1 = 4'b1101;
        grant2 = 4'b0000;
        grant3 = 4'b0000;
        #10;  // Wait for one clock cycle

        // Cycle 7: All grants set to 0
        grant0 = 4'b0000;
        grant1 = 4'b0000;
        grant2 = 4'b0000;
        grant3 = 4'b0000;
        #10;  // Wait for one clock cycle

        // Cycle 8: grant2, grant3 lowest bit = 1, others = 0
        grant0 = 4'b0000;
        grant1 = 4'b0000;
        grant2 = 4'b0001;
        grant3 = 4'b0001;
        #10;  // Wait for one clock cycle

        // Cycle 9: All grants lowest bit = 1
        grant0 = 4'b0001;
        grant1 = 4'b0001;
        grant2 = 4'b0001;
        grant3 = 4'b0001;
        #10;  // Wait for one clock cycle

        $stop;  // End the simulation
    end

endmodule
