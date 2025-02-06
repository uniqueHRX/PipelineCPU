`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:33:32
// Design Name: 
// Module Name: RegSel
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


module RegSel (
    input [1:0] RegDst,  //目标写入寄存器, 00: 写入rt, 01: 写入rd, 10:写入$31
    input [4:0] rt,  //当前指令rt段
    input [4:0] rd,  //当前指令rd段
    output [4:0] WriteReg  //写目标寄存器输出
);

  //选择目标寄存器
  assign WriteReg = (RegDst == 2'b00) ? rt : (RegDst == 2'b01) ? rd : 5'b11111;

endmodule
