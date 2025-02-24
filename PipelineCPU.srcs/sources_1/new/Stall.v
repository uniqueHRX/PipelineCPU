`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 11:19:54
// Design Name: 
// Module Name: Stall
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


module Stall (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input Branch,  //��֧�ź�
    input [31:0] BranchPC,  //��֧Ŀ��PC
    input [31:0] curPC,  //��ǰPC+4
    input [31:0] Ins,  //��ǰָ����
    output reg PCSrc,  //PCѡ���ź�, 0: PC+4, 1: ��֧PC
    output reg [31:0] newPC  //��PC
);

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 6;

  //���������
  reg [31:0] cnt;

  //�ӳټ��������ڼ���ʱ�������ش�������ʱ���ź�Ϊ�ߵ�ƽ�����������������֮������
  always @(posedge cntCLK or negedge rstn) begin
    if (!rstn) begin
      cnt <= 0;
    end else begin
      if (clk) cnt <= cnt + 1;
      else cnt <= 0;
    end
  end

  //�ж��Ƿ���Ҫ���������PCSrc����PC
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Qʱ����
      PCSrc <= Branch ? 1 : (Ins[31:26] == 6'b100011) ? 1 : 0;
      newPC <= Branch ? BranchPC : curPC;
    end else if (!rstn) begin  //�����ź���Чʱ����
      PCSrc <= 0;
      newPC <= 0;
    end
  end

endmodule
