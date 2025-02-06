`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 17:15:10
// Design Name: 
// Module Name: DBSel
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


module DBSel (
    input DBDataSrc,  //寄存器数据源, 0: 来自ALU, 1: 来自数据存储器
    input [4:0] WriteReg,  //目标寄存器
    input [31:0] MemData,  //DataMem读出数据
    input [31:0] Result,  //ALU运算结果
    input [31:0] PC,  //当前PC+4
    output [31:0] WriteData  //写入数据
);

  //选择写入数据
  assign WriteData = (WriteReg == 5'b11111) ? PC : DBDataSrc ? MemData : Result;

endmodule
