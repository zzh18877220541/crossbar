module arbiter_16x16 (
  input             clock,       // 时钟信号
  input             reset,       // 复位信号
  
  input  [15:0]     request,     // 16位请求信号
  output reg [15:0] grant        // 16位授予信号
);

reg [3:0]      R_rr;             // 用于轮询机制的位标志（4位支持16个请求）
reg [15:0]     R_grant_temp;     // 用于存储临时的授予结果
reg [15:0]     R_shift_req;      // 用于轮询处理的移位寄存器
reg [15:0]     R_shift_grant;    // 临时存储轮询后的授予信号

// 通过轮询机制确定优先的信号，并轮换优先顺序
always @(posedge clock) begin
  if (reset) begin
    R_shift_req = 4'b0000;
  end
  case(R_rr)
    4'b0000: R_shift_req = request;                             // 正常顺序
    4'b0001: R_shift_req = {request[0], request[15:1]};         // 轮换顺序
    4'b0010: R_shift_req = {request[1:0], request[15:2]};       // 轮换顺序
    4'b0011: R_shift_req = {request[2:0], request[15:3]};       // 轮换顺序
    4'b0100: R_shift_req = {request[3:0], request[15:4]};       // 轮换顺序
    4'b0101: R_shift_req = {request[4:0], request[15:5]};       // 轮换顺序
    4'b0110: R_shift_req = {request[5:0], request[15:6]};       // 轮换顺序
    4'b0111: R_shift_req = {request[6:0], request[15:7]};       // 轮换顺序
    4'b1000: R_shift_req = {request[7:0], request[15:8]};       // 轮换顺序
    4'b1001: R_shift_req = {request[8:0], request[15:9]};       // 轮换顺序
    4'b1010: R_shift_req = {request[9:0], request[15:10]};      // 轮换顺序
    4'b1011: R_shift_req = {request[10:0], request[15:11]};     // 轮换顺序
    4'b1100: R_shift_req = {request[11:0], request[15:12]};     // 轮换顺序
    4'b1101: R_shift_req = {request[12:0], request[15:13]};     // 轮换顺序
    4'b1110: R_shift_req = {request[13:0], request[15:14]};     // 轮换顺序
    4'b1111: R_shift_req = {request[14:0], request[15]};        // 轮换顺序
  endcase
end

// 通过优先的信号确定授予信号
always @(posedge clock) begin
   R_shift_grant = 16'b0000_0000_0000_0000;  // 初始时清空授予信号
   if (R_shift_req[0])
     R_shift_grant[0] = 1'b1;
   else if (R_shift_req[1])
     R_shift_grant[1] = 1'b1;
   else if (R_shift_req[2])
     R_shift_grant[2] = 1'b1;
   else if (R_shift_req[3])
     R_shift_grant[3] = 1'b1;
   else if (R_shift_req[4])
     R_shift_grant[4] = 1'b1;
   else if (R_shift_req[5])
     R_shift_grant[5] = 1'b1;
   else if (R_shift_req[6])
     R_shift_grant[6] = 1'b1;
   else if (R_shift_req[7])
     R_shift_grant[7] = 1'b1;
   else if (R_shift_req[8])
     R_shift_grant[8] = 1'b1;
   else if (R_shift_req[9])
     R_shift_grant[9] = 1'b1;
   else if (R_shift_req[10])
     R_shift_grant[10] = 1'b1;
   else if (R_shift_req[11])
     R_shift_grant[11] = 1'b1;
   else if (R_shift_req[12])
     R_shift_grant[12] = 1'b1;
   else if (R_shift_req[13])
     R_shift_grant[13] = 1'b1;
   else if (R_shift_req[14])
     R_shift_grant[14] = 1'b1;
   else if (R_shift_req[15])
     R_shift_grant[15] = 1'b1;
end

// 再通过“是否换位”，确定真实优先的信号
always @(posedge clock) begin
  if (reset) begin
    R_grant_temp = 4'b0000;
  end
  case(R_rr)
    4'b0000: R_grant_temp = R_shift_grant;                              // 无轮换，保持顺序
    4'b0001: R_grant_temp = {R_shift_grant[14:0], R_shift_grant[15]};   // 恢复轮换后的顺序
    4'b0010: R_grant_temp = {R_shift_grant[13:0], R_shift_grant[15:14]}; // 恢复轮换后的顺序
    4'b0011: R_grant_temp = {R_shift_grant[12:0], R_shift_grant[15:13]}; // 恢复轮换后的顺序
    4'b0100: R_grant_temp = {R_shift_grant[11:0], R_shift_grant[15:12]}; // 恢复轮换后的顺序
    4'b0101: R_grant_temp = {R_shift_grant[10:0], R_shift_grant[15:11]}; // 恢复轮换后的顺序
    4'b0110: R_grant_temp = {R_shift_grant[9:0], R_shift_grant[15:10]};  // 恢复轮换后的顺序
    4'b0111: R_grant_temp = {R_shift_grant[8:0], R_shift_grant[15:9]};   // 恢复轮换后的顺序
    4'b1000: R_grant_temp = {R_shift_grant[7:0], R_shift_grant[15:8]};   // 恢复轮换后的顺序
    4'b1001: R_grant_temp = {R_shift_grant[6:0], R_shift_grant[15:7]};   // 恢复轮换后的顺序
    4'b1010: R_grant_temp = {R_shift_grant[5:0], R_shift_grant[15:6]};   // 恢复轮换后的顺序
    4'b1011: R_grant_temp = {R_shift_grant[4:0], R_shift_grant[15:5]};   // 恢复轮换后的顺序
    4'b1100: R_grant_temp = {R_shift_grant[3:0], R_shift_grant[15:4]};   // 恢复轮换后的顺序
    4'b1101: R_grant_temp = {R_shift_grant[2:0], R_shift_grant[15:3]};   // 恢复轮换后的顺序
    4'b1110: R_grant_temp = {R_shift_grant[1:0], R_shift_grant[15:2]};   //
    4'b1110: R_grant_temp = {R_shift_grant[1:0], R_shift_grant[15:2]};   // 恢复轮换后的顺序
    4'b1111: R_grant_temp = {R_shift_grant[0], R_shift_grant[15:1]};     // 恢复轮换后的顺序
  endcase
end

// 获得真实的授予信号并改变R_rr信号
always @(posedge clock or posedge reset) begin
  if (reset) begin
    grant <= 16'b0000_0000_0000_0000;   // 重置授予信号
    R_rr  <= 4'b0000;                   // 重置轮询指针
  end
  else begin
    grant <= R_grant_temp;  // 更新最终授予的 `grant` 信号

    // 根据授予的信号调整轮询指针
    case (1'b1)
      grant[0]: R_rr <= 4'b0001;
      grant[1]: R_rr <= 4'b0010;
      grant[2]: R_rr <= 4'b0011;
      grant[3]: R_rr <= 4'b0100;
      grant[4]: R_rr <= 4'b0101;
      grant[5]: R_rr <= 4'b0110;
      grant[6]: R_rr <= 4'b0111;
      grant[7]: R_rr <= 4'b1000;
      grant[8]: R_rr <= 4'b1001;
      grant[9]: R_rr <= 4'b1010;
      grant[10]: R_rr <= 4'b1011;
      grant[11]: R_rr <= 4'b1100;
      grant[12]: R_rr <= 4'b1101;
      grant[13]: R_rr <= 4'b1110;
      grant[14]: R_rr <= 4'b1111;
      grant[15]: R_rr <= 4'b0000;
    endcase
  end
end

endmodule
