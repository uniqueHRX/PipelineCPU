`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/18 22:53:33
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input clear,  //�����ź�, 0: ����, 1: ����
    input [31:0] PC_in,  //��EX�ζ�������������ź�
    input [31:0] BranchPC_in,
    input [31:0] Ins_in,
    input [15:0] Signals_in,
    input [31:0] ReadData2_in,
    input [31:0] Result_in,
    input zero_in,
    input sign_in,
    input [4:0] WriteReg_in,
    output reg [31:0] PC_out,  //��MEM���������������ź�
    output reg [31:0] BranchPC_out,
    output reg [31:0] Ins_out,
    output reg [15:0] Signals_out,
    output reg [31:0] ReadData2_out,
    output reg [31:0] Result_out,
    output reg zero_out,
    output reg sign_out,
    output reg [4:0] WriteReg_out
);

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 3;

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
      PC_out <= PC_in;
      BranchPC_out <= BranchPC_in;
      Ins_out <= Ins_in;
      Signals_out <= Signals_in;
      ReadData2_out <= ReadData2_in;
      Result_out <= Result_in;
      zero_out <= zero_in;
      sign_out <= sign_in;
      WriteReg_out <= WriteReg_in;
    end else if (!rstn || clear) begin  //���û������ź���Чʱ����
      PC_out <= 0;
      BranchPC_out <= 0;
      Ins_out <= 0;
      Signals_out <= 0;
      ReadData2_out <= 0;
      Result_out <= 0;
      zero_out <= 0;
      sign_out <= 0;
      WriteReg_out <= 0;
    end
  end

endmodule
