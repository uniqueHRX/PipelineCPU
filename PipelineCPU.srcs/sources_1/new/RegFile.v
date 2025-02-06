`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 14:56:53
// Design Name: 
// Module Name: RegFile
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


module RegFile (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input RegWre,  //�Ĵ���дʹ��, 0: ��д�Ĵ���, 1: д�Ĵ���
    input [4:0] rs,  //��ǰָ��rs��
    input [4:0] rt,  //��ǰָ��rt��
    input [4:0] WriteReg,  //дĿ��Ĵ���
    input [31:0] WriteData,  //д������
    output [31:0] ReadData1,  //�Ĵ����������1
    output [31:0] ReadData2  //�Ĵ����������2
);

  //����Ĵ�����
  reg [31:0] RegFile[0:31];

  integer i;

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 2;

  //���������
  reg [31:0] cnt;

  //�ӳټ��������ڼ���ʱ�������ش�������ʱ���ź�Ϊ�ߵ�ƽ�����������������֮������
  always @(posedge cntCLK) begin
    if (clk) cnt <= cnt + 1;
    else cnt <= 0;
  end

  //д�Ĵ���
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q && RegWre) begin  //Clock-to-Qʱ����
      RegFile[WriteReg] <= WriteData;
    end else if (!rstn) begin
      for (i = 0; i < 32; i = i + 1) begin  //�����ź���Чʱ����
        RegFile[i] <= 0;
      end
    end
  end

  //���Ĵ���
  assign ReadData1 = RegFile[rs];
  assign ReadData2 = RegFile[rt];

endmodule
