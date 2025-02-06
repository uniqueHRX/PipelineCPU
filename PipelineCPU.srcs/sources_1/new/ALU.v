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
    input [2:0] ALUOp,  //ALU�����ź�
    input [31:0] ReadData1,  //�Ĵ����������1
    input [31:0] ReadData2,  //�Ĵ����������2
    input [31:0] Extend,  //��չ������
    input [4:0] sa,  //ָ��sa��
    input [31:0] MEM_Data,  //MEM����·����
    input [31:0] WB_Data,  //WB����·����
    input ALUSrcA,  //ALU����Դ1, 0: ReadData1����·, 1: sa
    input ALUSrcB,  //ALU����Դ2, 0: ReadData2����·, 1: Extend
    input [1:0] FSrcA,  //ALU����Դ1��·����, 00: ReadData1, 01: MEM_Data, 10: WB_Data
    input [1:0] FSrcB,  //ALU����Դ2��·����, 00: ReadData2, 01: MEM_Data, 10: WB_Data
    output [31:0] Result,  //������
    output sign,  //������־
    output zero  //0��־
);

  //��������ALU���������ź�
  wire [31:0] inA;
  wire [31:0] inB;

  //��������ѡ����ģ��
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

  //����ALUOp���������߼�����
  assign Result = (ALUOp == 3'b000) ? (inA + inB)
                  : (ALUOp == 3'b001) ? (inA - inB)
                  : (ALUOp == 3'b010) ? (inB << inA)
                  : (ALUOp == 3'b011) ? (inA | inB)
                  : (ALUOp == 3'b100) ? (inA & inB)
                  : (ALUOp == 3'b101) ? ((inA < inB) ? 1 : 0)
                  : (ALUOp == 3'b110) ? ((((inA < inB) && (inA[31] == inB[31])) || (inA[31] && !inB[31])) ? 1 : 0)
                  : (ALUOp == 3'b111) ? (inA ^ inB)
                  : 0;

  //�������������sign��zero�ź�
  assign sign = Result[31] ? 1 : 0;
  assign zero = Result ? 0 : 1;

endmodule
