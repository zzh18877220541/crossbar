module crossbar4x4 #(
    parameter width = 320,
    parameter depth = 64
)(
    input   wire [width - 1: 0]  in0,  // input port 0
    input   wire [width - 1: 0]  in1,  // input port 1
    input   wire [width - 1: 0]  in2,  // input port 2
    input   wire [width - 1: 0]  in3,  // input port 3
    output  reg  [width - 1: 0]  out0, // output port 0
    output  reg  [width - 1: 0]  out1, // output port 1
    output  reg  [width - 1: 0]  out2, // output port 2
    output  reg  [width - 1: 0]  out3, // output port 3
    input   wire [1:0]           sel_in0, // select signal 0
    input   wire [1:0]           sel_in1, // select signal 1
    input   wire [1:0]           sel_in2, // select signal 2
    input   wire [1:0]           sel_in3, // select signal 3
    input   wire                 clk,
    input   wire                 rst,
    // //debug
    // output wire [3:0] request0,
    // output wire [3:0] request1,
    // output wire [3:0] request2,
    // output wire [3:0] request3,
    // output wire [3:0] grant0,
    // output wire [3:0] grant1,
    // output wire [3:0] grant2,
    // output wire [3:0] grant3,
    // output wire [1:0] sel0,
    // output wire [1:0] sel1,
    // output wire [1:0] sel2,
    // output wire [1:0] sel3,
    // output wire [width: 0] out0_0,
    // output wire [width: 0] out0_1,
    // output wire [width: 0] out0_2,
    // output wire [width: 0] out0_3,
    // output wire [width: 0] out1_0,
    // output wire [width: 0] out1_1,
    // output wire [width: 0] out1_2,
    // output wire [width: 0] out1_3,
    // output wire [width: 0] out2_0,
    // output wire [width: 0] out2_1,
    // output wire [width: 0] out2_2,
    // output wire [width: 0] out2_3,
    // output wire [width: 0] out3_0,
    // output wire [width: 0] out3_1,
    // output wire [width: 0] out3_2,
    // output wire [width: 0] out3_3,
	// output wire [width + 1: 0] buffer_debug0,
    // output wire [width + 1: 0] buffer_debug1,
    // output wire [width + 1: 0] buffer_debug2,
    // output wire [width + 1: 0] buffer_debug3,
    // output wire [5:0] ptr0
);

reg [1:0] id0;
reg [1:0] id1;
reg [1:0] id2;
reg [1:0] id3;

//wire [1:0] sel0;
//wire [1:0] sel1;
//wire [1:0] sel2;
//wire [1:0] sel3;

// wire [3:0] request0;
// wire [3:0] request1;
// wire [3:0] request2;
// wire [3:0] request3;

// wire [3:0] grant0;
// wire [3:0] grant1;
// wire [3:0] grant2;
// wire [3:0] grant3;

/////////////  iq0  ///////////////

// wire [width: 0] out0_0;
// wire [width: 0] out0_1;
// wire [width: 0] out0_2;
// wire [width: 0] out0_3;

inputQueue #(
    .width(width),
    .depth(depth)
) iq0 (
    .in(in0),
    .sel(sel_in0),
    .clk(clk),
    .rst(rst),
    .grant0(grant0),
    .grant1(grant1),
    .grant2(grant2),
    .grant3(grant3),
    .id(id0),
    .sel_out(sel0),
    .output0(out0_0),
    .output1(out0_1),
    .output2(out0_2),
    .output3(out0_3),
    // .buffer_debug0(buffer_debug0),
    // .buffer_debug1(buffer_debug1),
    // .buffer_debug2(buffer_debug2),
    // .buffer_debug3(buffer_debug3),
    // .ptr(ptr0)
);

/////////////  iq1  ///////////////

// wire [width: 0] out1_0;
// wire [width: 0] out1_1;
// wire [width: 0] out1_2;
// wire [width: 0] out1_3;

inputQueue #(
    .width(width),
    .depth(depth)
) iq1 (
    .in(in1),
    .sel(sel_in1),
    .clk(clk),
    .rst(rst),
    .grant0(grant0),
    .grant1(grant1),
    .grant2(grant2),
    .grant3(grant3),
    .id(id1),
    .sel_out(sel1),
    // .output0(out1_0),
    // .output1(out1_1),
    // .output2(out1_2),
    // .output3(out1_3)
);

/////////////  iq2  ///////////////

// wire [width: 0] out2_0;
// wire [width: 0] out2_1;
// wire [width: 0] out2_2;
// wire [width: 0] out2_3;

inputQueue #(
    .width(width),
    .depth(depth)
) iq2 (
    .in(in2),
    .sel(sel_in2),
    .clk(clk),
    .rst(rst),
    .grant0(grant0),
    .grant1(grant1),
    .grant2(grant2),
    .grant3(grant3),
    .id(id2),
    .sel_out(sel2),
    .output0(out2_0),
    .output1(out2_1),
    .output2(out2_2),
    .output3(out2_3)
);

/////////////  iq3  ///////////////

// wire [width: 0] out3_0;
// wire [width: 0] out3_1;
// wire [width: 0] out3_2;
// wire [width: 0] out3_3;


inputQueue #(
    .width(width),
    .depth(depth)
) iq3 (
    .in(in3),
    .sel(sel_in3),
    .clk(clk),
    .rst(rst),
    .grant0(grant0),
    .grant1(grant1),
    .grant2(grant2),
    .grant3(grant3),
    .id(id3),
    .sel_out(sel3),
    .output0(out3_0),
    .output1(out3_1),
    .output2(out3_2),
    .output3(out3_3)
);

assign request0 = {sel3 == 2'b00, sel2 == 2'b00, sel1 == 2'b00, sel0 == 2'b00};
assign request1 = {sel3 == 2'b01, sel2 == 2'b01, sel1 == 2'b01, sel0 == 2'b01};
assign request2 = {sel3 == 2'b10, sel2 == 2'b10, sel1 == 2'b10, sel0 == 2'b10};
assign request3 = {sel3 == 2'b11, sel2 == 2'b11, sel1 == 2'b11, sel0 == 2'b11};

arbiter arbiter_0(
    .clock(clk),
    .reset(rst),
    .request(request0),
    .grant(grant0)
);

arbiter arbiter_1(
    .clock(clk),
    .reset(rst),
    .request(request1),
    .grant(grant1)
);

arbiter arbiter_2(
    .clock(clk),
    .reset(rst),
    .request(request2),
    .grant(grant2)
);

arbiter arbiter_3(
    .clock(clk),
    .reset(rst),
    .request(request3),
    .grant(grant3)
);

always @(posedge clk) begin
    if (rst) begin
        out0 <= 0;
        out1 <= 0;
        out2 <= 0;
        out3 <= 0;
        id0 <= 2'b00;
        id1 <= 2'b01;
        id2 <= 2'b10;
        id3 <= 2'b11;
    end
    else begin
        if (out0_0[width] == 1) begin
            out0 <= out0_0[width - 1: 0];
        end
        else if (out1_0[width] == 1) begin
            out0 <= out1_0[width - 1: 0];
        end
        else if (out2_0[width] == 1) begin
            out0 <= out2_0[width - 1: 0];
        end
        else if (out3_0[width] == 1) begin
            out0 <= out3_0[width - 1: 0];
        end
        else begin
            out0 <= 0;
        end

        if (out0_1[width] == 1) begin
            out1 <= out0_1[width - 1: 0];
        end
        else if (out1_1[width] == 1) begin
            out1 <= out1_1[width - 1: 0];
        end
        else if (out2_1[width] == 1) begin
            out1 <= out2_1[width - 1: 0];
        end
        else if (out3_1[width] == 1) begin
            out1 <= out3_1[width - 1: 0];
        end
        else begin
            out1 <= 0;
        end

        if (out0_2[width] == 1) begin
            out2 <= out0_2[width - 1: 0];
        end
        else if (out1_2[width] == 1) begin
            out2 <= out1_2[width - 1: 0];
        end
        else if (out2_2[width] == 1) begin
            out2 <= out2_2[width - 1: 0];
        end
        else if (out3_2[width] == 1) begin
            out2 <= out3_2[width - 1: 0];
        end
        else begin
            out2 <= 0;
        end

        if (out0_3[width] == 1) begin
            out3 <= out0_3[width - 1: 0];
        end
        else if (out1_3[width] == 1) begin
            out3 <= out1_3[width - 1: 0];
        end
        else if (out2_3[width] == 1) begin
            out3 <= out2_3[width - 1: 0];
        end
        else if (out3_3[width] == 1) begin
            out3 <= out3_3[width - 1: 0];
        end
        else begin
            out3 <= 0;
        end
    end
end

endmodule
