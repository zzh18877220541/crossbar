module inputQueue #(
    parameter width = 320,
    parameter depth = 64
)(
    input wire [width - 1: 0] in,
    input wire [1:0] sel,
    input wire [3:0] grant0,
    input wire [3:0] grant1,
    input wire [3:0] grant2,
    input wire [3:0] grant3,
    input wire [1:0] id,
    input rst,
    input clk,
    output wire [1:0] sel_out,
    output reg [width : 0] output0,
    output reg [width : 0] output1,
    output reg [width : 0] output2,
    output reg [width : 0] output3,
	output reg [width + 1: 0] buffer_debug0,
    output reg [width + 1: 0] buffer_debug1,
    output reg [width + 1: 0] buffer_debug2,
    output reg [width + 1: 0] buffer_debug3,
    output reg [5:0] ptr,
    output reg flag
);

reg [width-1 + 2: 0] buffer[depth :0];
//reg [5:0] ptr;
reg [3: 0] grant;
integer i;

assign sel_out = buffer[0][width + 1: width];


always @(posedge clk) begin
    if (rst) begin
        ptr = 6'b000000;
        output0 = 0;
        output1 = 0;
        output2 = 0;
        output3 = 0;
        flag = 0;
    end
    else begin
        // input logic
        if (ptr < depth - 1) begin
            buffer[ptr] = {sel, in};
            ptr = ptr + 1;
        end
        else begin
            // 溢出处理
        end
        buffer_debug0 = buffer[0];
        buffer_debug1 = buffer[1];
        buffer_debug2 = buffer[2];
		buffer_debug3 = buffer[3];

        //output logic
        if (flag == 0) begin
            flag = 1;
            output0 = {grant0[id], buffer[0][width - 1: 0]};
            output1 = {grant1[id], buffer[0][width - 1: 0]};
            output2 = {grant2[id], buffer[0][width - 1: 0]};
            output3 = {grant3[id], buffer[0][width - 1: 0]};

            grant = {grant3[id], grant2[id], grant1[id], grant0[id]};
            if (grant != 0) begin
                if (ptr > 0) begin
                    for (i = 0; i <= ptr; i = i + 1) begin
                        buffer[i] = buffer[i + 1];
                    end
                    ptr = ptr - 1;
                end
            end
        end
        else begin
            flag = 0;
            output0 = {1'b0, buffer[0][width - 1: 0]};
            output1 = {1'b0, buffer[0][width - 1: 0]};
            output2 = {1'b0, buffer[0][width - 1: 0]};
            output3 = {1'b0, buffer[0][width - 1: 0]};
        end
    end
end

endmodule