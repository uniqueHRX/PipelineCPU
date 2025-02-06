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
    input [1:0] RegDst,  //Ŀ��д��Ĵ���, 00: д��rt, 01: д��rd, 10:д��$31
    input [4:0] rt,  //��ǰָ��rt��
    input [4:0] rd,  //��ǰָ��rd��
    output [4:0] WriteReg  //дĿ��Ĵ������
);

  //ѡ��Ŀ��Ĵ���
  assign WriteReg = (RegDst == 2'b00) ? rt : (RegDst == 2'b01) ? rd : 5'b11111;

endmodule
