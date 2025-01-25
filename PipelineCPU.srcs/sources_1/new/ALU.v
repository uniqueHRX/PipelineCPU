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
    input sysCLK,
    input [2:0] ALUOp,
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] Extend,
    input [4:0] sa,
    input [31:0] MEM_Data,
    input [31:0] WB_Data,
    input ALUSrcA,
    input ALUSrcB,
    input [1:0] FSrcA,
    input [1:0] FSrcB,
    output [31:0] Result,
    output sign,
    output zero,
    output [31:0] ALUinA,
    output [31:0] ALUinB
);

  //定义输入ALU输入数据信号
  wire [31:0] inA;
  wire [31:0] inB;

  assign ALUinA = inA;
  assign ALUinB = inB;

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

  //核心功能
  //根据ALUOp进行算术运算
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
