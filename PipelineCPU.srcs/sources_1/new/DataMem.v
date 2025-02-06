`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 16:31:44
// Design Name: 
// Module Name: DataMem
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


module DataMem (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input [31:0] Result,  //ALU运算结果
    input [31:0] ReadData2,  //寄存器输出数据2
    input mRD,  //读数据存储器控制, 0: 输出高阻态, 1: 读数据存储器
    input mWR,  //写数据存储器控制, 0: 无操作, 1: 写数据存储器
    output reg [31:0] MemData  //读出数据
);

  //定义写入数据
  wire [31:0] DataAddr = Result;
  wire [31:0] DataIn = ReadData2;

  //定义数据存储器
  reg [7:0] DataMem[0:255];

  //初始化数据存储器
  integer i;
  initial begin
    for (i = 0; i < 256; i = i + 1) begin
      DataMem[i] <= 0;
    end
  end

  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 1;

  //定义计数器
  reg [31:0] cnt;

  //延迟计数器，在计数时钟上升沿触发，若时钟信号为高电平，则计数器自增，反之则清零
  always @(posedge cntCLK) begin
    if (clk) cnt <= cnt + 1;
    else cnt <= 0;
  end

  //写入数据存储器
  always @(posedge cntCLK) begin
    if (cnt == _CLOCK_TO_Q && mWR) begin  //Clock-to-Q时触发
      DataMem[DataAddr]   <= DataIn[31:24];
      DataMem[DataAddr+1] <= DataIn[23:16];
      DataMem[DataAddr+2] <= DataIn[15:8];
      DataMem[DataAddr+3] <= DataIn[7:0];
    end
  end

  //从数据存储器读出
  always @(mRD or Result) begin
    if (mRD) begin
      MemData[31:24] <= DataMem[DataAddr];
      MemData[23:16] <= DataMem[DataAddr+1];
      MemData[15:8]  <= DataMem[DataAddr+2];
      MemData[7:0]   <= DataMem[DataAddr+3];
    end else begin
      MemData[31:24] <= 0;
      MemData[23:16] <= 0;
      MemData[15:8]  <= 0;
      MemData[7:0]   <= 0;
    end
  end

endmodule
