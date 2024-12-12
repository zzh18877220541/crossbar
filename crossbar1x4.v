module crossbar1x4 #(
    parameter width = 320
)(
    input   wire [width - 1: 0] in,   // 1 input port
    output  reg  [width - 1: 0] out0, // Output port 0
    output  reg  [width - 1: 0] out1, // Output port 1
    output  reg  [width - 1: 0] out2, // Output port 2
    output  reg  [width - 1: 0] out3, // Output port 3
    input   wire [1:0]          sel_in, // 2-bit select signal
    input   wire                clk,
    input   wire                rst
);

always @(*) begin
    // Initialize all outputs to 0
    out0 = 0;
    out1 = 0;
    out2 = 0;
    out3 = 0;

    // Route input to the selected output
    case (sel_in)
        2'b00: out0 = in;
        2'b01: out1 = in;
        2'b10: out2 = in;
        2'b11: out3 = in;
        default: begin
            out0 = 0;
            out1 = 0;
            out2 = 0;
            out3 = 0;
        end
    endcase
end

endmodule
