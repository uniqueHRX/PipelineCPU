`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 18:42:56
// Design Name: 
// Module Name: sim
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


module sim ();

  //�ź�����
  reg clk;
  reg rstn;

  //��ʼ���ź�
  initial begin
    clk   = 0;
    rstn = 0;
    #50;  //�ȴ�rstn���
    clk = !clk;  //�½��أ�ʹPC������
    #50;
    rstn = 1;  //��������ź�
    forever
      #50 begin  //����ʱ���źţ�����Ϊ50ns
        clk = !clk;
      end
  end

  //ģ������
  PipelineCPU PipelineCPU (
      .clk  (clk),
      .rstn(rstn)
  );

endmodule
