`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 17:17:36
// Design Name: 
// Module Name: Basys3
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


module Basys3 (
    input clk,  //������ʱ��
    input reset,  //���ÿ���
    input Button,  //������ť
    input [1:0] SW,  //��ʾ�л�
    output [3:0] AN,  //�����ѡ���ź�
    output [7:0] DisplayCode  //��ʾ�ź�
);

  //ʱ���ź�
  wire userCLK;  //CPUʱ��
  wire sysCLK;  //��ʾʱ��
  wire cntCLK;  //����ʱ��

  //��ʾ����
  wire [7:0] DP_curPC;
  wire [7:0] DP_nextPC;
  wire [7:0] DP_Reg;
  wire [7:0] DP_DB;
  wire [7:0] DP_EX_PC;
  wire [7:0] DP_EX_Result;
  wire [7:0] DP_MEM_PC;
  wire [7:0] DP_MEM_Read;

  //ģ������
  //CPU
  PipelineCPU PipelineCPU (
      .cntCLK      (cntCLK),
      .clk         (userCLK),
      .rstn        (reset),
      .DP_curPC    (DP_curPC),
      .DP_nextPC   (DP_nextPC),
      .DP_Reg      (DP_Reg),
      .DP_DB       (DP_DB),
      .DP_EX_PC    (DP_EX_PC),
      .DP_EX_Result(DP_EX_Result),
      .DP_MEM_PC   (DP_MEM_PC),
      .DP_MEM_Read (DP_MEM_Read)
  );

  //��Ƶģ��
  ClockDiv ClockDiv (
      .clk   (clk),
      .rstn  (reset),
      .sysCLK(sysCLK),
      .cntCLK(cntCLK)
  );

  //����ģ��
  Debounce Debounce (
      .clk    (clk),
      .Button (Button),
      .userCLK(userCLK)
  );

  //��ʾģ��
  Display Display (
      .sysCLK      (sysCLK),
      .SW          (SW),
      .DP_curPC    (DP_curPC),
      .DP_nextPC   (DP_nextPC),
      .DP_Reg      (DP_Reg),
      .DP_DB       (DP_DB),
      .DP_EX_PC    (DP_EX_PC),
      .DP_EX_Result(DP_EX_Result),
      .DP_MEM_PC   (DP_MEM_PC),
      .DP_MEM_Read (DP_MEM_Read),
      .AN          (AN),
      .DisplayCode (DisplayCode)
  );

endmodule
