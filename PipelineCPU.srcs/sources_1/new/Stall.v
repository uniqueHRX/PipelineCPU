`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 11:19:54
// Design Name: 
// Module Name: Stall
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


module Stall (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input Branch,  //分支信号
    input [31:0] BranchPC,  //分支目标PC
    input [31:0] curPC,  //当前PC+4
    input [31:0] Ins,  //当前指令码
    output reg PCSrc,  //PC选择信号, 0: PC+4, 1: 分支PC
    output reg [31:0] newPC  //新PC
);

  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 6;

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

  //判断是否需要阻塞，输出PCSrc与新PC
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Q时触发
      PCSrc <= Branch ? 1 : (Ins[31:26] == 6'b100011) ? 1 : 0;
      newPC <= Branch ? BranchPC : curPC;
    end else if (!rstn) begin  //重置信号生效时触发
      PCSrc <= 0;
      newPC <= 0;
    end
  end

endmodule
