`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:11:21
// Design Name: 
// Module Name: ALU
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


module ALU (
    input [2:0] ALUOp,  //ALU控制信号
    input [31:0] ReadData1,  //寄存器输出数据1
    input [31:0] ReadData2,  //寄存器输出数据2
    input [31:0] Extend,  //扩展立即数
    input [4:0] sa,  //指令sa段
    input [31:0] MEM_Data,  //MEM段旁路数据
    input [31:0] WB_Data,  //WB段旁路数据
    input ALUSrcA,  //ALU数据源1, 0: ReadData1或旁路, 1: sa
    input ALUSrcB,  //ALU数据源2, 0: ReadData2或旁路, 1: Extend
    input [1:0] FSrcA,  //ALU数据源1旁路控制, 00: ReadData1, 01: MEM_Data, 10: WB_Data
    input [1:0] FSrcB,  //ALU数据源2旁路控制, 00: ReadData2, 01: MEM_Data, 10: WB_Data
    output [31:0] Result,  //运算结果
    output sign,  //正负标志
    output zero  //0标志
);

  //定义输入ALU输入数据信号
  wire [31:0] inA;
  wire [31:0] inB;

  //例化输入选择器模块
  Mux32bit MuxALUSrcA (
      .sel(ALUSrcA),
      .F_sel(FSrcA),
      .src0(ReadData1),
      .src1({27'b0, sa}),
      .F_src01(MEM_Data),
      .F_src10(WB_Data),
      .ret(inA)
  );

  Mux32bit MuxALUSrcB (
      .sel(ALUSrcB),
      .F_sel(FSrcB),
      .src0(ReadData2),
      .src1(Extend),
      .F_src01(MEM_Data),
      .F_src10(WB_Data),
      .ret(inB)
  );

  //根据ALUOp进行算术逻辑运算
  assign Result = (ALUOp == 3'b000) ? (inA + inB)
                  : (ALUOp == 3'b001) ? (inA - inB)
                  : (ALUOp == 3'b010) ? (inB << inA)
                  : (ALUOp == 3'b011) ? (inA | inB)
                  : (ALUOp == 3'b100) ? (inA & inB)
                  : (ALUOp == 3'b101) ? ((inA < inB) ? 1 : 0)
                  : (ALUOp == 3'b110) ? ((((inA < inB) && (inA[31] == inB[31])) || (inA[31] && !inB[31])) ? 1 : 0)
                  : (ALUOp == 3'b111) ? (inA ^ inB)
                  : 0;

  //根据运算结果输出sign和zero信号
  assign sign = Result[31] ? 1 : 0;
  assign zero = Result ? 0 : 1;

endmodule
