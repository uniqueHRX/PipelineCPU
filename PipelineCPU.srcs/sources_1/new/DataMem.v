`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 16:31:44
// Design Name: 
// Module Name: DataMem
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


module DataMem (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input [31:0] Result,  //ALU������
    input [31:0] ReadData2,  //�Ĵ����������2
    input mRD,  //�����ݴ洢������, 0: �������̬, 1: �����ݴ洢��
    input mWR,  //д���ݴ洢������, 0: �޲���, 1: д���ݴ洢��
    output reg [31:0] MemData  //��������
);

  //����д������
  wire [31:0] DataAddr = Result;
  wire [31:0] DataIn = ReadData2;

  //�������ݴ洢��
  reg [7:0] DataMem[0:255];

  //��ʼ�����ݴ洢��
  integer i;
  initial begin
    for (i = 0; i < 256; i = i + 1) begin
      DataMem[i] <= 0;
    end
  end

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 1;

  //���������
  reg [31:0] cnt;

  //�ӳټ��������ڼ���ʱ�������ش�������ʱ���ź�Ϊ�ߵ�ƽ�����������������֮������
  always @(posedge cntCLK) begin
    if (clk) cnt <= cnt + 1;
    else cnt <= 0;
  end

  //д�����ݴ洢��
  always @(posedge cntCLK) begin
    if (cnt == _CLOCK_TO_Q && mWR) begin  //Clock-to-Qʱ����
      DataMem[DataAddr]   <= DataIn[31:24];
      DataMem[DataAddr+1] <= DataIn[23:16];
      DataMem[DataAddr+2] <= DataIn[15:8];
      DataMem[DataAddr+3] <= DataIn[7:0];
    end
  end

  //�����ݴ洢������
  always @(mRD or Result) begin
    if (mRD) begin
      MemData[31:24] <= DataMem[DataAddr];
      MemData[23:16] <= DataMem[DataAddr+1];
      MemData[15:8]  <= DataMem[DataAddr+2];
      MemData[7:0]   <= DataMem[DataAddr+3];
    end else begin
      MemData[31:24] <= 0;
      MemData[23:16] <= 0;
      MemData[15:8]  <= 0;
      MemData[7:0]   <= 0;
    end
  end

endmodule
