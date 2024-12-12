module arbiter(
  input             clock,        // 时钟信号
  input             reset,        // 复位信号
  
  input [3:0]       request,      // 2位请求信� 
  output reg [3:0]  grant         // 2位授予信�
);

reg [1:0]      R_rr;                  // 用于轮询机制的位标志
reg [3:0] R_grant_temp;               // 用于存储临时的授予结�
reg [3:0] R_shift_req, R_shift_grant; // 用于轮询处理的移位寄存器

// 通过换位确定优先的，优先的信号被换到0
always @(posedge clock)
begin
  if (reset) begin
    R_shift_req = 4'b0000;
  end
  else begin
    case(R_rr)
      2'b00: R_shift_req = request;                // 正常顺序
      2'b01: R_shift_req = {request[0], request[3:1]}; // 轮换顺序
      2'b10: R_shift_req = {request[1:0], request[3:2]}; // 轮换顺序
      2'b11: R_shift_req = {request[2:0], request[3]};  // 轮换顺序
    endcase
  end
end

// 通过优先的信号确定授予信�
always @(posedge clock)
begin
   R_shift_grant = 4'b0000;
  if (R_shift_req[0])
    R_shift_grant[0] = 1'b1;
  else if (R_shift_req[1])
    R_shift_grant[1] = 1'b1;
  else if (R_shift_req[2])
    R_shift_grant[2] = 1'b1;
  else if (R_shift_req[3])
    R_shift_grant[3] = 1'b1;
end

// 再通过“是否换位”，确定真实优先的信�
always @(posedge clock)
begin
  if (reset) begin
    R_grant_temp = 4'b0000;
  end
  else begin
    case(R_rr)
      2'b00: R_grant_temp = R_shift_grant;                  // 无轮换，保持顺序
      2'b01: R_grant_temp = {R_shift_grant[2:0], R_shift_grant[3]}; // 恢复轮换后的顺序
      2'b10: R_grant_temp = {R_shift_grant[1:0], R_shift_grant[3:2]}; // 恢复轮换后的顺序
      2'b11: R_grant_temp = {R_shift_grant[0], R_shift_grant[3:1]};   // 恢复轮换后的顺序
    endcase
  end
end

// 获得真实的授予信号并改变R_rr信号
always @(posedge clock)
begin
  if (reset)
    begin
      grant <=  4'b0000;
      R_rr  <=  2'b00;           // 重置轮询指针
    end
  else
    begin
        grant <=  R_grant_temp; // 授予新请求的同时清除旧请�
      
        case(1'b1)
            grant[0]: R_rr <=  2'b01;
            grant[1]: R_rr <=  2'b10;
            grant[2]: R_rr <=  2'b11;
            grant[3]: R_rr <=  2'b00;
        endcase
    end
end

endmodule
