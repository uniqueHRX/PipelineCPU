`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 20:20:56
// Design Name: 
// Module Name: DemoBus
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


module DemoBus (
    input rstn,  //重置信号
    input Halt,  //停机信号, 0: 正常运行, 1: 停机
    input [31:0] IF_PC,  //IF段PC
    input [31:0] ID_PC,  //ID段PC+4
    input [31:0] EX_PC,  //EX段PC+4
    input [31:0] MEM_PC,  //MEM段PC+4
    input [31:0] WB_PC,  //WB段PC+4
    input WB_RegWre,  //WB段指令的寄存器写使能, 0: 不写寄存器, 1: 写寄存器
    input [4:0] WB_WriteReg,  //WB段指令的目标寄存器
    input [31:0] WB_WriteData,  //WB段指令的写入数据
    output reg [7:0] Demo_PC,  //PC演示信号输出
    output reg [7:0] Demo_newPC,  //newPC演示信号输出
    output reg [7:0] Demo_Reg,  //目标寄存器演示信号输出
    output reg [7:0] Demo_DB  //数据总线演示信号输出
);

  //实时生成演示信号
  always @(*) begin
    if (rstn) begin
      if (WB_PC != 0) begin
        Demo_PC = WB_PC[7:0] ? WB_PC[7:0] - 4 : WB_PC[7:0];
        Demo_newPC = MEM_PC ? MEM_PC[7:0] - 4 : EX_PC ? EX_PC[7:0] - 4 : ID_PC ? ID_PC[7:0] - 4 : IF_PC[7:0];
      end
      if (Halt) Demo_newPC = Demo_PC;
      if (WB_RegWre) begin
        Demo_Reg = {3'b000, WB_WriteReg};
        Demo_DB  = WB_WriteData[7:0];
      end else begin
        Demo_Reg = 0;
        Demo_DB  = 0;
      end
    end else begin
      Demo_PC = 0;
      Demo_newPC = 0;
      Demo_Reg = 0;
      Demo_DB = 0;
    end
  end

endmodule
