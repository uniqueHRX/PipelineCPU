`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 16:37:23
// Design Name: 
// Module Name: ClockDiv
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


module ClockDiv (
    input clk,  //硬件时钟
    input rstn,  //重置信号
    output reg sysCLK,  //系统时钟
    output reg cntCLK  //计数时钟
);

  //定义系统时钟周期时间
  integer _sysCLK_TIME = 100000;
  integer _cntCLK_TIME = 1000;

  //定义计数器
  reg [31:0] count1 = 0;
  reg [31:0] count2 = 0;

  initial begin
    sysCLK = 0;
    cntCLK = 0;
  end

  //对硬件时钟进行分频
  always @(posedge clk) begin
    if (count1 >= _sysCLK_TIME) begin
      count1 <= 0;
      sysCLK <= !sysCLK;  //在计数到达目标时对系统时钟信号取反
    end else count1 <= count1 + 1;

    if (count2 >= _cntCLK_TIME) begin
      count2 <= 0;
      cntCLK <= !cntCLK;  //在计数到达目标时对计数时钟信号取反
    end else count2 <= count2 + 1;
  end

endmodule

