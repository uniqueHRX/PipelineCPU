`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:56:48
// Design Name: 
// Module Name: Branch
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


module Branch (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input zero,  //0标志
    input sign,  //正负标志
    input Halt,  //停机信号, 0: 正常运行, 1: 停机
    input [31:0] PC,  //当前指令的PC+4
    input [31:0] BranchPC,  //分支目标PC
    input [31:0] HaltPC,  //停机目标PC
    input [31:0] Ins,  //当前指令码
    input [31:0] Result,  //ALU运算结果
    output reg Branch,  //分支信号, 0: 顺序执行, 1: 执行分支
    output reg [31:0] newPC  //新PC
);

  // assign Branch = Halt ? 1
  //                 : (Ins[31:26] == 6'b000010) ? 1
  //                 : (Ins[31:26] == 6'b000011) ? 1
  //                 : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? 1
  //                 : (Ins[31:26] == 6'b000100 && zero) ? 1
  //                 : (Ins[31:26] == 6'b000101 && !zero) ? 1
  //                 : (Ins[31:26] == 6'b000110 && (sign || zero)) ? 1
  //                 : (Ins[31:26] == 6'b000001 && sign) ? 1
  //                 : 0;

  // assign newPC = Halt ? HaltPC
  //               : (Ins[31:26] == 6'b000010) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
  //               : (Ins[31:26] == 6'b000011) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
  //               : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? Result
  //               : (Ins[31:26] == 6'b000100 && zero) ? BranchPC
  //               : (Ins[31:26] == 6'b000101 && !zero) ? BranchPC
  //               : (Ins[31:26] == 6'b000110 && (sign || zero)) ? BranchPC
  //               : (Ins[31:26] == 6'b000001 && sign) ? BranchPC
  //               : PC;

  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 4;

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

  //进行分支判断，输出分支信号与新PC
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Q时触发
      Branch <= Halt ? 1
                : (Ins[31:26] == 6'b000010) ? 1
                : (Ins[31:26] == 6'b000011) ? 1
                : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? 1
                : (Ins[31:26] == 6'b000100 && zero) ? 1
                : (Ins[31:26] == 6'b000101 && !zero) ? 1
                : (Ins[31:26] == 6'b000110 && (sign || zero)) ? 1
                : (Ins[31:26] == 6'b000001 && sign) ? 1
                : 0;
      newPC <= Halt ? HaltPC
                : (Ins[31:26] == 6'b000010) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
                : (Ins[31:26] == 6'b000011) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
                : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? Result
                : (Ins[31:26] == 6'b000100 && zero) ? BranchPC
                : (Ins[31:26] == 6'b000101 && !zero) ? BranchPC
                : (Ins[31:26] == 6'b000110 && (sign || zero)) ? BranchPC
                : (Ins[31:26] == 6'b000001 && sign) ? BranchPC
                : PC;
    end else if (!rstn) begin  //重置信号生效时触发
      Branch <= 0;
      newPC  <= 0;
    end
  end

endmodule
