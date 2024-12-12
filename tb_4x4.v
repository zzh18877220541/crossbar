`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:09:22 09/11/2024
// Design Name:   crossbar4x4
// Module Name:   D:/ISE14.7_win/ise_pro/myCrossbar/tb_4x4.v
// Project Name:  myCrossbar
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: crossbar4x4
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_crossbar4x4;

    // Parameters
    parameter width = 8;   // Change the width to 8 bits
    parameter depth = 64;

    // Inputs
    reg clk;
    reg rst;
    reg [width-1:0] in0, in1, in2, in3;
    reg [1:0] sel_in0, sel_in1, sel_in2, sel_in3;

    // Outputs
    wire [width-1:0] out0, out1, out2, out3;
    wire [3:0] request0, request1, request2, request3, grant0, grant1, grant2, grant3;
    wire [1:0] sel0, sel1, sel2, sel3;
	wire [width+1: 0] buffer_debug0, buffer_debug1, buffer_debug2, buffer_debug3;
    wire [5:0] ptr0;
    wire [width: 0] out0_0, out0_1, out0_2, out0_3, out1_0, out1_1, out1_2, out1_3, out2_0, out2_1, out2_2, out2_3, out3_0, out3_1, out3_2, out3_3;

    // Instantiate the Unit Under Test (UUT)
    crossbar4x4 #(
        .width(width),
        .depth(depth)
    ) uut (
        .clk(clk),
        .rst(rst),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel_in0(sel_in0),
        .sel_in1(sel_in1),
        .sel_in2(sel_in2),
        .sel_in3(sel_in3),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .request0(request0),
        .request1(request1),
        .request2(request2),
        .request3(request3),
        .grant0(grant0),
        .grant1(grant1),
        .grant2(grant2),
        .grant3(grant3),
        .sel0(sel0),
        .sel1(sel1),
        .sel2(sel2),
        .sel3(sel3),
        .out0_0(out0_0),
        .out0_1(out0_1),
        .out0_2(out0_2),
        .out0_3(out0_3),
        .out1_0(out1_0),
        .out1_1(out1_1),
        .out1_2(out1_2),
        .out1_3(out1_3),
        .out2_0(out2_0),
        .out2_1(out2_1),
        .out2_2(out2_2),
        .out2_3(out2_3),
        .out3_0(out3_0),
        .out3_1(out3_1),
        .out3_2(out3_2),
        .out3_3(out3_3),
		.buffer_debug0(buffer_debug0),
        .buffer_debug1(buffer_debug1),
        .buffer_debug2(buffer_debug2),
        .buffer_debug3(buffer_debug3),
        .ptr0(ptr0)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    // Testbench logic
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        in0 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 0;
        sel_in0 = 0;
        sel_in1 = 0;
        sel_in2 = 0;
        sel_in3 = 0;
        

        // Reset the system
        rst = 1;
        #10;
        rst = 0;

        
        // --- Scenario 1: i0-o0; i1-o1; i2-o2; i3-o3 ---
        $display("Scenario 1");
        send_input(8'hAA, 8'hBB, 8'hCC, 8'hDD, 2'b00, 2'b01, 2'b10, 2'b11);
        //#50;
        //aa bb cc dd
        //--- Scenario 2: i0-o1; i1-o2; i2-o3; i3-o0 ---
        $display("Scenario 2");
        send_input(8'hEE, 8'hFF, 8'h11, 8'h22, 2'b01, 2'b10, 2'b11, 2'b00);
        //#50;
        //22 ee ff 11
        // --- Scenario 3: i0-o0; i1-o0; i2-o2; i3-o3 ---
        $display("Scenario 3");
        send_input(8'h33, 8'h44, 8'h55, 8'h66, 2'b00, 2'b00, 2'b10, 2'b11);
        //#50;
        //33 00 55 66
        // --- Scenario 4: i0-o0; i1-o0; i2-o0; i3-o3 ---
        $display("Scenario 4");
        send_input(8'h77, 8'h88, 8'h99, 8'hAA, 2'b00, 2'b00, 2'b00, 2'b11);
        //#50;
        //44 00 00 aa
        // --- Scenario 5: i0-o3; i1-o3; i2-o3; i3-o3 ---
        $display("Scenario 5");
        send_input(8'hBB, 8'hCC, 8'hDD, 8'hEE, 2'b11, 2'b11, 2'b11, 2'b11);
        send_input(0, 0, 0, 0, 0, 0, 0, 0);
        #500;
        //99 00 00 bb
        //77 00 00 cc
        //88 00 00 ee
        //00 00 00 dd
        $stop;
    end

    // Task to send inputs to the crossbar4x4
    task send_input;
        input [width-1:0] i0, i1, i2, i3;
        input [1:0] s0, s1, s2, s3;
        begin
            in0 = i0;
            in1 = i1;
            in2 = i2;
            in3 = i3;
            sel_in0 = s0;
            sel_in1 = s1;
            sel_in2 = s2;
            sel_in3 = s3;

            #10;  // Wait for 10 time units (1 clock cycle)
        end
    endtask

endmodule
