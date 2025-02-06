`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 16:37:23
// Design Name: 
// Module Name: Debounce
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


module Debounce (
    input clk,  //硬件时钟
    input Button,  //步进按钮
    output userCLK  //用户时钟
);

  //定义计数器上限
  integer _STABLE_TIME = 5000;

  //定义电平计数变量
  reg [31:0] countLow = 0;
  reg [31:0] countHigh = 0;
  reg CLK = 0;

  //消抖
  always @(posedge clk) begin
    countLow  <= !Button ? 0 : countLow + 1;
    countHigh <= Button ? 0 : countHigh + 1;
    if (countHigh == _STABLE_TIME) CLK <= 1;
    else if (countLow == _STABLE_TIME) CLK <= 0;
  end

  //输出
  assign userCLK = !CLK;

endmodule
