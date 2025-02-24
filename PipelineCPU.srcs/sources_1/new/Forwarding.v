`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 17:00:43
// Design Name: 
// Module Name: Forwarding
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


module Forwarding (
    input cntCLK,  //����ʱ��
    input clk,  //ʱ���ź�
    input rstn,  //�����ź�
    input MEM_RegWre,  //MEM�μĴ���дʹ��, 0: ��д�Ĵ���, 1: д�Ĵ���
    input WB_RegWre,  //WB�μĴ���дʹ��, 0: ��д�Ĵ���, 1: д�Ĵ���
    input [4:0] MEM_WriteReg,  //MEM��Ŀ��Ĵ���
    input [4:0] WB_WriteReg,  //WB��Ŀ��Ĵ���
    input [4:0] rs,  //��ǰָ��rs
    input [4:0] rt,  //��ǰָ��rt
    input [31:0] MEM_Data_in,  //MEM_Data����
    input [31:0] WB_Data_in,  //WB_Data����
    output reg [1:0] FSrcA,  //ALU����Դ1��·����, 00: ReadData1, 01: MEM_Data, 10: WB_Data
    output reg [1:0] FSrcB,  //ALU����Դ2��·����, 00: ReadData1, 01: MEM_Data, 10: WB_Data
    output reg [31:0] MEM_Data_out,  //MEM_Data���
    output reg [31:0] WB_Data_out  //WB_Data���
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

  //�����·�����ź�����·����
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Qʱ����
      FSrcA <= (MEM_RegWre && MEM_WriteReg == rs) ? 2'b01
                : (WB_RegWre && WB_WriteReg == rs) ? 2'b10
                : 2'b00;
      FSrcB <= (MEM_RegWre && MEM_WriteReg == rt) ? 2'b01
                : (WB_RegWre && WB_WriteReg == rt) ? 2'b10
                : 2'b00;
      MEM_Data_out <= MEM_Data_in;
      WB_Data_out <= WB_Data_in;
    end else if (!rstn) begin  //�����ź���Чʱ����
      FSrcA <= 2'b00;
      FSrcB <= 2'b00;
    end
  end

endmodule
