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
    input sysCLK,
    input clk,
    input [31:0] Result,
    input [31:0] ReadData2,
    input mRD,
    input mWR,
    output reg [31:0] MemData
);

  //定义输入数据
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

  reg [31:0] cnt;

  always @(posedge sysCLK) begin
    if (clk) cnt <= cnt + 1;
    else cnt <= 0;
  end

  //写入数据存储器
  always @(posedge sysCLK) begin
    if (cnt == 1 && mWR) begin
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
