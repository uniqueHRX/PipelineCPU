`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 14:56:53
// Design Name: 
// Module Name: RegFile
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


module RegFile (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input RegWre,  //寄存器写使能, 0: 不写寄存器, 1: 写寄存器
    input [4:0] rs,  //当前指令rs段
    input [4:0] rt,  //当前指令rt段
    input [4:0] WriteReg,  //写目标寄存器
    input [31:0] WriteData,  //写入数据
    output [31:0] ReadData1,  //寄存器输出数据1
    output [31:0] ReadData2  //寄存器输出数据2
);

  //定义寄存器堆
  reg [31:0] RegFile[0:31];

  integer i;

  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 2;

  //定义计数器
  reg [31:0] cnt;

  //延迟计数器，在计数时钟上升沿触发，若时钟信号为高电平，则计数器自增，反之则清零
  always @(posedge cntCLK) begin
    if (clk) cnt <= cnt + 1;
    else cnt <= 0;
  end

  //写寄存器
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q && RegWre) begin  //Clock-to-Q时触发
      RegFile[WriteReg] <= WriteData;
    end else if (!rstn) begin
      for (i = 0; i < 32; i = i + 1) begin  //重置信号生效时触发
        RegFile[i] <= 0;
      end
    end
  end

  //读寄存器
  assign ReadData1 = RegFile[rs];
  assign ReadData2 = RegFile[rt];

endmodule
