`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 16:38:03
// Design Name: 
// Module Name: PC
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


module PC (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input PCSrc,  //PCѡ���ź�, 0: PC+4, 1: ��֧PC
    input [31:0] newPC0,  //PC+4
    input [31:0] newPC1,  //��֧PC
    output reg [31:0] curPC  //��ǰPC���
);

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 8;

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

  //����PC
  always @(posedge cntCLK or negedge rstn) begin
    if (!rstn) begin  //�����ź���Чʱ����
      curPC <= 0;
    end else if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Qʱ����
      if (PCSrc) curPC <= newPC1;
      else curPC <= newPC0;
    end
  end

endmodule
