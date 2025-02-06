`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 16:37:23
// Design Name: 
// Module Name: ClockDiv
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


module ClockDiv (
    input clk,  //Ӳ��ʱ��
    input rstn,  //�����ź�
    output reg sysCLK,  //ϵͳʱ��
    output reg cntCLK  //����ʱ��
);

  //����ϵͳʱ������ʱ��
  integer _sysCLK_TIME = 100000;
  integer _cntCLK_TIME = 1000;

  //���������
  reg [31:0] count1 = 0;
  reg [31:0] count2 = 0;

  initial begin
    sysCLK = 0;
    cntCLK = 0;
  end

  //��Ӳ��ʱ�ӽ��з�Ƶ
  always @(posedge clk) begin
    if (count1 >= _sysCLK_TIME) begin
      count1 <= 0;
      sysCLK <= !sysCLK;  //�ڼ�������Ŀ��ʱ��ϵͳʱ���ź�ȡ��
    end else count1 <= count1 + 1;

    if (count2 >= _cntCLK_TIME) begin
      count2 <= 0;
      cntCLK <= !cntCLK;  //�ڼ�������Ŀ��ʱ�Լ���ʱ���ź�ȡ��
    end else count2 <= count2 + 1;
  end

endmodule

