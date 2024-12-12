module crossbar16x16 #(
    parameter width = 320,
    parameter depth = 128
)(
    input   wire [width - 1: 0]  in0,  // input port 0
    input   wire [width - 1: 0]  in1,  // input port 1
    input   wire [width - 1: 0]  in2,  // input port 2
    input   wire [width - 1: 0]  in3,  // input port 3
    input   wire [width - 1: 0]  in4,  // input port 4
    input   wire [width - 1: 0]  in5,  // input port 5
    input   wire [width - 1: 0]  in6,  // input port 6
    input   wire [width - 1: 0]  in7,  // input port 7
    input   wire [width - 1: 0]  in8,  // input port 8
    input   wire [width - 1: 0]  in9,  // input port 9
    input   wire [width - 1: 0]  in10, // input port 10
    input   wire [width - 1: 0]  in11, // input port 11
    input   wire [width - 1: 0]  in12, // input port 12
    input   wire [width - 1: 0]  in13, // input port 13
    input   wire [width - 1: 0]  in14, // input port 14
    input   wire [width - 1: 0]  in15, // input port 15

    output  reg  [width: 0]  out0,  // output port 0
    output  reg  [width: 0]  out1,  // output port 1
    output  reg  [width: 0]  out2,  // output port 2
    output  reg  [width: 0]  out3,  // output port 3
    output  reg  [width: 0]  out4,  // output port 4
    output  reg  [width: 0]  out5,  // output port 5
    output  reg  [width: 0]  out6,  // output port 6
    output  reg  [width: 0]  out7,  // output port 7
    output  reg  [width: 0]  out8,  // output port 8
    output  reg  [width: 0]  out9,  // output port 9
    output  reg  [width: 0]  out10, // output port 10
    output  reg  [width: 0]  out11, // output port 11
    output  reg  [width: 0]  out12, // output port 12
    output  reg  [width: 0]  out13, // output port 13
    output  reg  [width: 0]  out14, // output port 14
    output  reg  [width: 0]  out15, // output port 15

    input   wire [3:0]           sel_in0,  // select signal 0
    input   wire [3:0]           sel_in1,  // select signal 1
    input   wire [3:0]           sel_in2,  // select signal 2
    input   wire [3:0]           sel_in3,  // select signal 3
    input   wire [3:0]           sel_in4,  // select signal 4
    input   wire [3:0]           sel_in5,  // select signal 5
    input   wire [3:0]           sel_in6,  // select signal 6
    input   wire [3:0]           sel_in7,  // select signal 7
    input   wire [3:0]           sel_in8,  // select signal 8
    input   wire [3:0]           sel_in9,  // select signal 9
    input   wire [3:0]           sel_in10, // select signal 10
    input   wire [3:0]           sel_in11, // select signal 11
    input   wire [3:0]           sel_in12, // select signal 12
    input   wire [3:0]           sel_in13, // select signal 13
    input   wire [3:0]           sel_in14, // select signal 14
    input   wire [3:0]           sel_in15, // select signal 15

    input   wire                 clk,
    input   wire                 rst

    // Debug signals
    // output wire [15:0] request0,
    // output wire [15:0] request1,
    // output wire [15:0] request2,
    // output wire [15:0] request3,
    // output wire [15:0] request4,
    // output wire [15:0] request5,
    // output wire [15:0] request6,
    // output wire [15:0] request7,
    // output wire [15:0] request8,
    // output wire [15:0] request9,
    // output wire [15:0] request10,
    // output wire [15:0] request11,
    // output wire [15:0] request12,
    // output wire [15:0] request13,
    // output wire [15:0] request14,
    // output wire [15:0] request15,

    // output wire [15:0] grant0,
    // output wire [15:0] grant1,
    // output wire [15:0] grant2,
    // output wire [15:0] grant3,
    // output wire [15:0] grant4,
    // output wire [15:0] grant5,
    // output wire [15:0] grant6,
    // output wire [15:0] grant7,
    // output wire [15:0] grant8,
    // output wire [15:0] grant9,
    // output wire [15:0] grant10,
    // output wire [15:0] grant11,
    // output wire [15:0] grant12,
    // output wire [15:0] grant13,
    // output wire [15:0] grant14,
    // output wire [15:0] grant15,

    // output wire [3:0] sel0,
    // output wire [3:0] sel1,
    // output wire [3:0] sel2,
    // output wire [3:0] sel3,
    // output wire [3:0] sel4,
    // output wire [3:0] sel5,
    // output wire [3:0] sel6,
    // output wire [3:0] sel7,
    // output wire [3:0] sel8,
    // output wire [3:0] sel9,
    // output wire [3:0] sel10,
    // output wire [3:0] sel11,
    // output wire [3:0] sel12,
    // output wire [3:0] sel13,
    // output wire [3:0] sel14,
    // output wire [3:0] sel15,
);

// Inputs
wire [width-1:0] in[15:0]; // 16 input ports
wire [3:0] sel_in[15:0];    // 16 select signals

assign in[0] = in0, in[1] = in1, in[2] = in2, in[3] = in3, in[4] = in4, in[5] = in5, in[6] = in6, in[7] = in7, in[8] = in8, in[9] = in9, in[10] = in10, in[11] = in11, in[12] = in12, in[13] = in13, in[14] = in14, in[15] = in15;
assign sel_in[0] = sel_in0, sel_in[1] = sel_in1, sel_in[2] = sel_in2, sel_in[3] = sel_in3, sel_in[4] = sel_in4, sel_in[5] = sel_in5, sel_in[6] = sel_in6, sel_in[7] = sel_in7, sel_in[8] = sel_in8, sel_in[9] = sel_in9, sel_in[10] = sel_in10, sel_in[11] = sel_in11, sel_in[12] = sel_in12, sel_in[13] = sel_in13, sel_in[14] = sel_in14, sel_in[15] = sel_in15;

// Outputs
reg  [width-1:0] out[15:0]; // 16 output ports

// Debugging signals
wire [15:0] request[15:0];
wire [15:0] grant[15:0];
wire [3:0] sel[15:0];
wire [width:0] out_data[15:0][15:0];  // output data for each input-output pair

reg [3:0] id[15:0];  // 16 unique id


// Instantiate 16 inputQueue instances
genvar i, j;
generate
    for (j = 0; j < 16; j = j + 1) begin : input_queues
        inputQueue_16x16 #(
            .width(width),
            .depth(depth)
        ) iq (
            .in(in[j]),
            .sel(sel_in[j]),
            .clk(clk),
            .rst(rst),
            .grant0(grant[0]),
            .grant1(grant[1]),
            .grant2(grant[2]),
            .grant3(grant[3]),
            .grant4(grant[4]),
            .grant5(grant[5]),
            .grant6(grant[6]),
            .grant7(grant[7]),
            .grant8(grant[8]),
            .grant9(grant[9]),
            .grant10(grant[10]),
            .grant11(grant[11]),
            .grant12(grant[12]),
            .grant13(grant[13]),
            .grant14(grant[14]),
            .grant15(grant[15]),
            .id(id[j]),
            .sel_out(sel[j]),
            .output0(out_data[j][0]),
            .output1(out_data[j][1]),
            .output2(out_data[j][2]),
            .output3(out_data[j][3]),
            .output4(out_data[j][4]),
            .output5(out_data[j][5]),
            .output6(out_data[j][6]),
            .output7(out_data[j][7]),
            .output8(out_data[j][8]),
            .output9(out_data[j][9]),
            .output10(out_data[j][10]),
            .output11(out_data[j][11]),
            .output12(out_data[j][12]),
            .output13(out_data[j][13]),
            .output14(out_data[j][14]),
            .output15(out_data[j][15])
        );
    end
endgenerate

// Instantiate 16 arbiter instances
generate
    for (j = 0; j < 16; j = j + 1) begin : arbiters
        arbiter_16x16 arbiter (
            .clock(clk),
            .reset(rst),
            .request(request[j]),
            .grant(grant[j])
        );
    end
endgenerate

// 16x16 crossbar output logic
integer k;
generate
    for (i = 0; i < 16; i = i + 1) begin : output_logic
        always @(posedge clk) begin
            if (rst) begin
                out[i] <= 0;
                id[i] <= i;
            end else begin
                // Check for valid data from any input queue
            for (k = 0; k < 16; k = k + 1) begin
                if (out_data[k][i][width]) begin
                    out[i] <= out_data[k][i][width:0];
                end
            end
            end
        end
    end
endgenerate

always @(posedge clk) begin
    out0 <= out[0];
    out1 <= out[1];
    out2 <= out[2];
    out3 <= out[3];
    out4 <= out[4];
    out5 <= out[5];
    out6 <= out[6];
    out7 <= out[7];
    out8 <= out[8];
    out9 <= out[9];
    out10 <= out[10];
    out11 <= out[11];
    out12 <= out[12];
    out13 <= out[13];
    out14 <= out[14];
    out15 <= out[15];
end

endmodule
