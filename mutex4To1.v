module mux4to1 #(
    parameter width = 8
)(
    input [3:0] in,  // 4-bit data input
    input [1:0] sel_in,  // 2-bit select input
    output reg out    // output
);

always @(*) begin
    case(sel_in)
        2'b00: out = in[0];
        2'b01: out = in[1];
        2'b10: out = in[2];
        2'b11: out = in[3];
        default: out = 0;
    endcase
end

endmodule