module inputQueue_16x16 #(
    parameter width = 8,
    parameter depth = 8
)(
    input wire [width - 1: 0] in,
    input wire [3:0] sel,  // 选择4位，用于选择16个输出端口
    input wire [15:0] grant0, grant1, grant2, grant3, grant4, grant5, grant6, grant7, grant8, grant9, grant10, grant11, grant12, grant13, grant14, grant15,
    input wire [3:0] id,  // 用于标识输入队列
    input rst,
    input clk,
    output wire [3:0] sel_out,
    output reg [width : 0] output0, output1, output2, output3,
    output reg [width : 0] output4, output5, output6, output7,
    output reg [width : 0] output8, output9, output10, output11,
    output reg [width : 0] output12, output13, output14, output15,
    output reg [5:0] ptr,
    output reg flag
);

reg [width-1 + 4: 0] buffer[depth :0];  // 增加了存储4位的选择信号
reg [15: 0] grant;  // 支持16个输出
integer i;

assign sel_out = buffer[0][width + 3: width];  // 取buffer中存储的选择信号

always @(posedge clk) begin
    if (rst) begin
        ptr = 6'b000000;
        output0 = 0;
        output1 = 0;
        output2 = 0;
        output3 = 0;
        output4 = 0;
        output5 = 0;
        output6 = 0;
        output7 = 0;
        output8 = 0;
        output9 = 0;
        output10 = 0;
        output11 = 0;
        output12 = 0;
        output13 = 0;
        output14 = 0;
        output15 = 0;
        flag = 0;
    end
    else begin
        // input logic
        if (ptr < depth - 1) begin
            buffer[ptr] = {sel, in};  // 保存sel和输入数据到buffer中
            ptr = ptr + 1;
        end
        else begin
            // 溢出处理
        end

        // Output logic: 根据grant信号输出数据
        if (flag == 0) begin
            flag = 1;
            output0 = {grant0[id], buffer[0][width - 1: 0]};
            output1 = {grant1[id], buffer[0][width - 1: 0]};
            output2 = {grant2[id], buffer[0][width - 1: 0]};
            output3 = {grant3[id], buffer[0][width - 1: 0]};
            output4 = {grant4[id], buffer[0][width - 1: 0]};
            output5 = {grant5[id], buffer[0][width - 1: 0]};
            output6 = {grant6[id], buffer[0][width - 1: 0]};
            output7 = {grant7[id], buffer[0][width - 1: 0]};
            output8 = {grant8[id], buffer[0][width - 1: 0]};
            output9 = {grant9[id], buffer[0][width - 1: 0]};
            output10 = {grant10[id], buffer[0][width - 1: 0]};
            output11 = {grant11[id], buffer[0][width - 1: 0]};
            output12 = {grant12[id], buffer[0][width - 1: 0]};
            output13 = {grant13[id], buffer[0][width - 1: 0]};
            output14 = {grant14[id], buffer[0][width - 1: 0]};
            output15 = {grant15[id], buffer[0][width - 1: 0]};

            // grant控制逻辑
            grant = {grant15[id], grant14[id], grant13[id], grant12[id], grant11[id], grant10[id], grant9[id], grant8[id], grant7[id], grant6[id], grant5[id], grant4[id], grant3[id], grant2[id], grant1[id], grant0[id]};
            
            if (grant != 0) begin
                if (ptr > 0) begin
                    for (i = 0; i <= ptr; i = i + 1) begin
                        buffer[i] = buffer[i + 1];  // 移位buffer
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
            output4 = {1'b0, buffer[0][width - 1: 0]};
            output5 = {1'b0, buffer[0][width - 1: 0]};
            output6 = {1'b0, buffer[0][width - 1: 0]};
            output7 = {1'b0, buffer[0][width - 1: 0]};
            output8 = {1'b0, buffer[0][width - 1: 0]};
            output9 = {1'b0, buffer[0][width - 1: 0]};
            output10 = {1'b0, buffer[0][width - 1: 0]};
            output11 = {1'b0, buffer[0][width - 1: 0]};
            output12 = {1'b0, buffer[0][width - 1: 0]};
            output13 = {1'b0, buffer[0][width - 1: 0]};
            output14 = {1'b0, buffer[0][width - 1: 0]};
            output15 = {1'b0, buffer[0][width - 1: 0]};
        end

    end
end

endmodule
