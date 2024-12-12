`timescale 1ns / 1ps

module tb_arbiter;

    // Inputs
    reg clock;
    reg reset;
    reg [3:0] request;

    // Outputs
    wire [3:0] grant;

    // Instantiate the Unit Under Test (UUT)
    arbiter uut (
        .clock(clock),
        .reset(reset),
        .request(request),
        .grant(grant)
    );

    // Clock generation
    always #5 clock = ~clock;  // 10ns clock period

    // Testbench logic
    initial begin
        // Initialize inputs
        clock = 0;
        reset = 0;
        request = 4'b0000;

        // Reset the system
        reset = 1;
        #10;
        reset = 0;

        // Cycle 1: Request = 0001
        request = 4'b0001;
        #10;

        // Cycle 2: Request = 0010
        request = 4'b0010;
        #10;

        // Cycle 3: Request = 0011
        request = 4'b0011;
        #10;

        // Cycle 4: Request = 0011
        request = 4'b0011;
        #10;

        // Cycle 5: Request = 0111
        request = 4'b0111;
        #10;

        // Cycle 6: Request = 0111
        request = 4'b0111;
        #10;

        // Cycle 7: Request = 0111
        request = 4'b0111;
        #10;

        // End simulation
        $stop;
    end

endmodule
