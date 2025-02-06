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
    input DBDataSrc,  //�Ĵ�������Դ, 0: ����ALU, 1: �������ݴ洢��
    input [4:0] WriteReg,  //Ŀ��Ĵ���
    input [31:0] MemData,  //DataMem��������
    input [31:0] Result,  //ALU������
    input [31:0] PC,  //��ǰPC+4
    output [31:0] WriteData  //д������
);

  //ѡ��д������
  assign WriteData = (WriteReg == 5'b11111) ? PC : DBDataSrc ? MemData : Result;

endmodule
