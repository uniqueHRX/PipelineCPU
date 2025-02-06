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
    input rstn,  //�����ź�
    input Halt,  //ͣ���ź�, 0: ��������, 1: ͣ��
    input [31:0] IF_PC,  //IF��PC
    input [31:0] ID_PC,  //ID��PC+4
    input [31:0] EX_PC,  //EX��PC+4
    input [31:0] MEM_PC,  //MEM��PC+4
    input [31:0] WB_PC,  //WB��PC+4
    input WB_RegWre,  //WB��ָ��ļĴ���дʹ��, 0: ��д�Ĵ���, 1: д�Ĵ���
    input [4:0] WB_WriteReg,  //WB��ָ���Ŀ��Ĵ���
    input [31:0] WB_WriteData,  //WB��ָ���д������
    output reg [7:0] Demo_PC,  //PC��ʾ�ź����
    output reg [7:0] Demo_newPC,  //newPC��ʾ�ź����
    output reg [7:0] Demo_Reg,  //Ŀ��Ĵ�����ʾ�ź����
    output reg [7:0] Demo_DB  //����������ʾ�ź����
);

  //ʵʱ������ʾ�ź�
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
