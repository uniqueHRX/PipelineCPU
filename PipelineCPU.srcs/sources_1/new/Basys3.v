`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 17:17:36
// Design Name: 
// Module Name: Basys3
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


module Basys3 (
    input clk,  //开发板时钟
    input reset,  //重置开关
    input Button,  //步进按钮
    input [1:0] SW,  //显示切换
    output [3:0] AN,  //数码管选择信号
    output [7:0] DisplayCode  //显示信号
);

  //时钟信号
  wire userCLK;  //CPU时钟
  wire sysCLK;  //显示时钟
  wire cntCLK;  //计数时钟

  //显示数据
  wire [7:0] DP_curPC;
  wire [7:0] DP_nextPC;
  wire [7:0] DP_Reg;
  wire [7:0] DP_DB;
  wire [7:0] DP_EX_PC;
  wire [7:0] DP_EX_Result;
  wire [7:0] DP_MEM_PC;
  wire [7:0] DP_MEM_Read;

  //模块例化
  //CPU
  PipelineCPU PipelineCPU (
      .cntCLK      (cntCLK),
      .clk         (userCLK),
      .rstn        (reset),
      .DP_curPC    (DP_curPC),
      .DP_nextPC   (DP_nextPC),
      .DP_Reg      (DP_Reg),
      .DP_DB       (DP_DB),
      .DP_EX_PC    (DP_EX_PC),
      .DP_EX_Result(DP_EX_Result),
      .DP_MEM_PC   (DP_MEM_PC),
      .DP_MEM_Read (DP_MEM_Read)
  );

  //分频模块
  ClockDiv ClockDiv (
      .clk   (clk),
      .rstn  (reset),
      .sysCLK(sysCLK),
      .cntCLK(cntCLK)
  );

  //消抖模块
  Debounce Debounce (
      .clk    (clk),
      .Button (Button),
      .userCLK(userCLK)
  );

  //显示模块
  Display Display (
      .sysCLK      (sysCLK),
      .SW          (SW),
      .DP_curPC    (DP_curPC),
      .DP_nextPC   (DP_nextPC),
      .DP_Reg      (DP_Reg),
      .DP_DB       (DP_DB),
      .DP_EX_PC    (DP_EX_PC),
      .DP_EX_Result(DP_EX_Result),
      .DP_MEM_PC   (DP_MEM_PC),
      .DP_MEM_Read (DP_MEM_Read),
      .AN          (AN),
      .DisplayCode (DisplayCode)
  );

endmodule
