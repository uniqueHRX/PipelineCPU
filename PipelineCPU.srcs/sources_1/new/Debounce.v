`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 16:37:23
// Design Name: 
// Module Name: Debounce
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


module Debounce (
    input clk,  //Ӳ��ʱ��
    input Button,  //������ť
    output userCLK  //�û�ʱ��
);

  //�������������
  integer _STABLE_TIME = 5000;

  //�����ƽ��������
  reg [31:0] countLow = 0;
  reg [31:0] countHigh = 0;
  reg CLK = 0;

  //����
  always @(posedge clk) begin
    countLow  <= !Button ? 0 : countLow + 1;
    countHigh <= Button ? 0 : countHigh + 1;
    if (countHigh == _STABLE_TIME) CLK <= 1;
    else if (countLow == _STABLE_TIME) CLK <= 0;
  end

  //���
  assign userCLK = !CLK;

endmodule
