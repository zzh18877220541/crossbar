`timescale 1ns / 1ps

module tb_crossbar16x16;

    // Parameters
    parameter width = 8;
    parameter depth = 8;
    
    // Inputs
    reg clk;
    reg rst;
    reg [width-1:0] in[15:0];    // 16 input ports
    reg [3:0] sel_in[15:0];      // 16 select signals
    
    // Outputs
    wire [width-1:0] out[15:0];  // 16 output ports
    
    // Debugging outputs
    wire [15:0] request[15:0];
    wire [15:0] grant[15:0];
    wire [3:0] sel[15:0];
    wire [width:0] out_data[15:0][15:0];
    
    // Instantiate the crossbar16x16 module
    crossbar16x16 #(
        .width(width),
        .depth(depth)
    ) uut (
        .in(in),
        .sel_in(sel_in),
        .clk(clk),
        .rst(rst),
        .out(out),
        .request(request),
        .grant(grant),
        .sel(sel),
        .out_data(out_data)
    );
    
    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    // Testbench logic
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        #10;   // Hold reset for 10ns
        rst = 0;
        
        // Case 1: Multiple inputs correspond to one output
        // Inputs 0, 1, and 2 send data to output 0
        in[0] = 8'h00; sel_in[0] = 4'b0000;  // input 0 -> output 0
        in[1] = 8'h01; sel_in[1] = 4'b0001;  // input 1 -> output 1
        in[2] = 8'h02; sel_in[2] = 4'b0010;  // input 2 -> output 2
        in[3] = 8'h03; sel_in[3] = 4'b0011;  // input 3 -> output 3
        in[4] = 8'h04; sel_in[4] = 4'b0100;  // input 4 -> output 4
        in[5] = 8'h05; sel_in[5] = 4'b0101;  // input 5 -> output 5
        in[6] = 8'h06; sel_in[6] = 4'b0110;  // input 6 -> output 6
        in[7] = 8'h07; sel_in[7] = 4'b0111;  // input 7 -> output 7
        in[8] = 8'h08; sel_in[8] = 4'b1000;  // input 8 -> output 8
        in[9] = 8'h09; sel_in[9] = 4'b1001;  // input 9 -> output 9
        in[10] = 8'h0A; sel_in[10] = 4'b1010;  // input 10 -> output 10
        in[11] = 8'h0B; sel_in[11] = 4'b1011;  // input 11 -> output 11
        in[12] = 8'h0C; sel_in[12] = 4'b1100;  // input 12 -> output 12
        in[13] = 8'h0D; sel_in[13] = 4'b1101;  // input 13 -> output 13
        in[14] = 8'h0E; sel_in[14] = 4'b1110;  // input 14 -> output 14
        in[15] = 8'h0F; sel_in[15] = 4'b1111;  // input 15 -> output 15
        
        
        // Wait for one clock cycle to process
        #10;
        
        // Case 2: Each input corresponds to one output
        // Set up unique mappings from each input to corresponding output
        in[0] = 8'hAA; sel_in[0] = 4'b0000;  // input 0 -> output 0
        in[1] = 8'hBB; sel_in[1] = 4'b0000;  // input 1 -> output 0
        in[2] = 8'hCC; sel_in[2] = 4'b0000;  // input 2 -> output 0
        in[3] = 8'hDD; sel_in[3] = 4'b0011;  // input 3 -> output 3
        in[4] = 8'hEE; sel_in[4] = 4'b0100;  // input 4 -> output 4
        in[5] = 8'hFF; sel_in[5] = 4'b0101;  // input 5 -> output 5
        in[6] = 8'h11; sel_in[6] = 4'b0110;  // input 6 -> output 6
        in[7] = 8'h22; sel_in[7] = 4'b0111;  // input 7 -> output 7
        // Wait for one clock cycle to process
        #10;
        
        $stop;  // End simulation
    end
endmodule
