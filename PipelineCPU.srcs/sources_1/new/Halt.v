`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 22:54:48
// Design Name: 
// Module Name: Halt
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


module Halt (
    input rstn,  //重置信号
    input [31:0] WB_Ins,  //WB段指令
    input [31:0] WB_PC,  //WB段PC
    output reg Halt,  //停机信号, 0: 正常运行, 1: 停机
    output reg [31:0] PC  //停机目标PC
);

  //初始化
  initial begin
    Halt = 0;
    PC   = 0;
  end

  //判断停机指令
  always @(*) begin
    if (!Halt && WB_Ins[31:26] == 6'b111111 && rstn) begin
      Halt = 1;
      PC   = WB_PC;
    end else if (!rstn) begin
      Halt = 0;
      PC   = 0;
    end
  end

endmodule
