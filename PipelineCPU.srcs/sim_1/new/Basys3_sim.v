`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 17:26:06
// Design Name: 
// Module Name: Basys3_sim
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


module Basys3_sim ();

  //�ź�����
  reg clk;
  reg rstn;
  reg Button;

  //��ʼ���ź�
  initial begin
    clk = 0;
    rstn = 0;
    Button = 0;
    #1;  //�ȴ�rstn���
    clk = !clk;  //�½��أ�ʹPC������
    #1;
    rstn = 1;  //��������ź�
    forever
      #1 begin  //����ʱ���źţ�����Ϊ50ns
        clk = !clk;
      end
  end

  integer count = 0;

  always @(posedge clk) begin
    if (count == 500000) begin
      count  <= 0;
      Button <= !Button;
    end else count = count + 1;
  end

  //ģ������
  Basys3 Basys3 (
      .clk(clk),
      .reset(rstn),
      .Button(Button),
      .SW(2'b00)
  );


endmodule
