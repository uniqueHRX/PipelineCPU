`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 22:54:48
// Design Name: 
// Module Name: Halt
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


module Halt (
    input rstn,  //�����ź�
    input [31:0] WB_Ins,  //WB��ָ��
    input [31:0] WB_PC,  //WB��PC
    output reg Halt,  //ͣ���ź�, 0: ��������, 1: ͣ��
    output reg [31:0] PC  //ͣ��Ŀ��PC
);

  //��ʼ��
  initial begin
    Halt = 0;
    PC   = 0;
  end

  //�ж�ͣ��ָ��
  always @(*) begin
    if (!Halt && WB_Ins[31:26] == 6'b111111 && rstn) begin
      Halt = 1;
      PC   = WB_PC;
    end else if (!rstn) begin
      Halt = 0;
      PC   = 0;
    end
  end

endmodule
