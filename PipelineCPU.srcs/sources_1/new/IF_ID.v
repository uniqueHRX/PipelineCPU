`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/18 22:53:33
// Design Name: 
// Module Name: IF_ID
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


module IF_ID (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input clear,  //�����ź�, 0: ����, 1: ����
    input [31:0] PC_in,  //��IF�ζ�������
    input [31:0] Ins_in,
    output reg [31:0] PC_out,  //��ID���������
    output reg [31:0] Ins_out
);

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 7;

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

  //���������
  always @(posedge cntCLK or negedge rstn or posedge clear) begin
    if (rstn && !clear && cnt == _CLOCK_TO_Q) begin  //Clock-to-Qʱ����
      PC_out  <= PC_in;
      Ins_out <= Ins_in;
    end else if (!rstn || clear) begin  //���û������ź���Чʱ����
      PC_out  <= 0;
      Ins_out <= 0;
    end
  end

endmodule
