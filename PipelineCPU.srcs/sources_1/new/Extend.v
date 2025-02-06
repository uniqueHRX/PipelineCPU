`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:08:50
// Design Name: 
// Module Name: Extend
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


module Extend (
    input [15:0] immediate,  //immediate��
    input ExtSel,  //��������չ��ʽ, 0: 0��չ, 1: ������չ
    output [31:0] Extend  //��չ���������
);

  //����ExtSel������������չ
  assign Extend[15:0]  = immediate[15:0];
  assign Extend[31:16] = ExtSel ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;

endmodule
