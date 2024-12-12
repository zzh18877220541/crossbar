module top_crossbar_network #(
    parameter width = 320  // Data width (320 bits)
)(
    input  wire [width-1:0] sm_input[63:0],    // 64 SM inputs (L1 Cache)
    output wire [width-1:0] sm_output[63:0],   // 64 SM outputs (L1 Cache)
    input  wire [3:0]       sel_sm_to_group[15:0],  // Select signals for crossbar16x16
    input  wire [1:0]       sel_group_to_sm[15:0],  // Select signals for each crossbar1x4
    input  wire [1:0]       sel_sm_within_group[15:0][3:0], // Select signals for each crossbar4x4
    input  wire             clk,
    input  wire             rst
);

    // Intermediate signals for the crossbars
    wire [width-1:0] group_output[15:0];  // Outputs from crossbar16x16 to each group (16x16)
    wire [width-1:0] group_to_sm[15:0][3:0];    // Outputs from each crossbar1x4
    wire [width-1:0] sm_within_group[15:0][3:0]; // Outputs from each crossbar4x4

    // Instantiate the 16x16 crossbar
    genvar i, j;
    generate
        for (i = 0; i < 16; i = i + 1) begin: crossbar16x16_gen
            crossbar16x16 #(
                .width(width)
            ) crossbar_16x16_inst (
                .in(sm_input[48+i]),  // Special L1 cache inputs (assuming they are from 48 to 63)
                .out(group_output[i]),  // Outputs to 16 SM groups
                .sel_in(sel_sm_to_group[i]),  // 4-bit select signal
                .clk(clk),
                .rst(rst)
            );
        end
    endgenerate

    // Instantiate the 16 crossbar1x4 modules (one per group)
    generate
        for (i = 0; i < 16; i = i + 1) begin: crossbar1x4_gen
            crossbar1x4 #(
                .width(width)
            ) crossbar_1x4_inst (
                .in(group_output[i]),  // Output from the crossbar16x16
                .out0(group_to_sm[i][0]),
                .out1(group_to_sm[i][1]),
                .out2(group_to_sm[i][2]),
                .out3(group_to_sm[i][3]),
                .sel_in(sel_group_to_sm[i]),  // 2-bit select signal for group
                .clk(clk),
                .rst(rst)
            );
        end
    endgenerate

    // Instantiate the 16 crossbar4x4 modules for group internal communication
    generate
        for (i = 0; i < 16; i = i + 1) begin: crossbar4x4_gen
            crossbar4x4 #(
                .width(width)
            ) crossbar_4x4_inst (
                .in0(sm_input[i*4 + 0]),
                .in1(sm_input[i*4 + 1]),
                .in2(sm_input[i*4 + 2]),
                .in3(sm_input[i*4 + 3]),
                .out0(sm_within_group[i][0]),
                .out1(sm_within_group[i][1]),
                .out2(sm_within_group[i][2]),
                .out3(sm_within_group[i][3]),
                .sel_in0(sel_sm_within_group[i][0]),
                .sel_in1(sel_sm_within_group[i][1]),
                .sel_in2(sel_sm_within_group[i][2]),
                .sel_in3(sel_sm_within_group[i][3]),
                .clk(clk),
                .rst(rst)
            );
        end
    endgenerate

    // Final assignment: Group outputs to SM outputs
    generate
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                assign sm_output[i*4 + j] = sm_within_group[i][j];
            end
        end
    endgenerate

endmodule
