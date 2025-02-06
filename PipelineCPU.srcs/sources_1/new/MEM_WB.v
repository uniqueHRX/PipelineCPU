`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/18 22:53:33
// Design Name: 
// Module Name: MEM_WB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input [31:0] PC_in,  //从MEM段读入数据与控制信号
    input [31:0] Ins_in,
    input [15:0] Signals_in,
    input [31:0] MemData_in,
    input [31:0] Result_in,
    input [4:0] WriteReg_in,
    output reg [31:0] PC_out,  //向WB段输出数据与控制信号
    output reg [31:0] Ins_out,
    output reg [15:0] Signals_out,
    output reg [31:0] MemData_out,
    output reg [31:0] Result_out,
    output reg [4:0] WriteReg_out
);

  // reg [31:0] PC;
  // reg [31:0] Ins;
  // reg [15:0] Signals;
  // reg [31:0] MemData;
  // reg [31:0] Result;
  // reg [ 4:0] WriteReg;

  //初始化
  // initial begin
  //   PC = 0;
  //   Ins = 0;
  //   Signals = 0;
  //   MemData = 0;
  //   Result = 0;
  //   WriteReg = 0;
  //   PC_out = 0;
  //   Ins_out = 0;
  //   Signals_out = 0;
  //   MemData_out = 0;
  //   Result_out = 0;
  //   WriteReg_out = 0;
  // end

  //输入与重置
  // always @(negedge clk or negedge rstn) begin
  //   if (rstn) begin
  //     PC <= PC_in;
  //     Ins <= Ins_in;
  //     Signals <= Signals_in;
  //     MemData <= MemData_in;
  //     Result <= Result_in;
  //     WriteReg <= WriteReg_in;
  //   end else begin
  //     PC <= 0;
  //     Ins <= 0;
  //     Signals <= 0;
  //     MemData <= 0;
  //     Result <= 0;
  //     WriteReg <= 0;
  //   end
  // end


  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 1;

  //定义计数器
  reg [31:0] cnt;

  //延迟计数器，在计数时钟上升沿触发，若时钟信号为高电平，则计数器自增，反之则清零
  always @(posedge cntCLK or negedge rstn) begin
    if (!rstn) begin
      cnt <= 0;
    end else begin
      if (clk) cnt <= cnt + 1;
      else cnt <= 0;
    end
  end

  //输出与重置
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Q时触发
      PC_out <= PC_in;
      Ins_out <= Ins_in;
      Signals_out <= Signals_in;
      MemData_out <= MemData_in;
      Result_out <= Result_in;
      WriteReg_out <= WriteReg_in;
    end else if (!rstn) begin  //重置信号生效时触发
      PC_out <= 0;
      Ins_out <= 0;
      Signals_out <= 0;
      MemData_out <= 0;
      Result_out <= 0;
      WriteReg_out <= 0;
    end
  end

  //重置
  // always @(negedge rstn) begin
  //   PC <= 0;
  //   Ins <= 0;
  //   Signals <= 0;
  //   MemData <= 0;
  //   Result <= 0;
  //   WriteReg <= 0;
  //   PC_out <= 0;
  //   Ins_out <= 0;
  //   Signals_out <= 0;
  //   MemData_out <= 0;
  //   Result_out <= 0;
  //   WriteReg_out <= 0;
  // end

endmodule
