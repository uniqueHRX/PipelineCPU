`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:56:48
// Design Name: 
// Module Name: Branch
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


module Branch (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input zero,  //0��־
    input sign,  //������־
    input Halt,  //ͣ���ź�, 0: ��������, 1: ͣ��
    input [31:0] PC,  //��ǰָ���PC+4
    input [31:0] BranchPC,  //��֧Ŀ��PC
    input [31:0] HaltPC,  //ͣ��Ŀ��PC
    input [31:0] Ins,  //��ǰָ����
    input [31:0] Result,  //ALU������
    output reg Branch,  //��֧�ź�, 0: ˳��ִ��, 1: ִ�з�֧
    output reg [31:0] newPC  //��PC
);

  // assign Branch = Halt ? 1
  //                 : (Ins[31:26] == 6'b000010) ? 1
  //                 : (Ins[31:26] == 6'b000011) ? 1
  //                 : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? 1
  //                 : (Ins[31:26] == 6'b000100 && zero) ? 1
  //                 : (Ins[31:26] == 6'b000101 && !zero) ? 1
  //                 : (Ins[31:26] == 6'b000110 && (sign || zero)) ? 1
  //                 : (Ins[31:26] == 6'b000001 && sign) ? 1
  //                 : 0;

  // assign newPC = Halt ? HaltPC
  //               : (Ins[31:26] == 6'b000010) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
  //               : (Ins[31:26] == 6'b000011) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
  //               : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? Result
  //               : (Ins[31:26] == 6'b000100 && zero) ? BranchPC
  //               : (Ins[31:26] == 6'b000101 && !zero) ? BranchPC
  //               : (Ins[31:26] == 6'b000110 && (sign || zero)) ? BranchPC
  //               : (Ins[31:26] == 6'b000001 && sign) ? BranchPC
  //               : PC;

  //����Clock-to-Q
  integer _CLOCK_TO_Q = 4;

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

  //���з�֧�жϣ������֧�ź�����PC
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Qʱ����
      Branch <= Halt ? 1
                : (Ins[31:26] == 6'b000010) ? 1
                : (Ins[31:26] == 6'b000011) ? 1
                : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? 1
                : (Ins[31:26] == 6'b000100 && zero) ? 1
                : (Ins[31:26] == 6'b000101 && !zero) ? 1
                : (Ins[31:26] == 6'b000110 && (sign || zero)) ? 1
                : (Ins[31:26] == 6'b000001 && sign) ? 1
                : 0;
      newPC <= Halt ? HaltPC
                : (Ins[31:26] == 6'b000010) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
                : (Ins[31:26] == 6'b000011) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
                : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? Result
                : (Ins[31:26] == 6'b000100 && zero) ? BranchPC
                : (Ins[31:26] == 6'b000101 && !zero) ? BranchPC
                : (Ins[31:26] == 6'b000110 && (sign || zero)) ? BranchPC
                : (Ins[31:26] == 6'b000001 && sign) ? BranchPC
                : PC;
    end else if (!rstn) begin  //�����ź���Чʱ����
      Branch <= 0;
      newPC  <= 0;
    end
  end

endmodule
