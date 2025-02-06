`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 14:47:33
// Design Name: 
// Module Name: InsMem
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


module InsMem (
    input  [31:0] PC,  //��ǰPC
    output [31:0] Ins  //ָ�������
);

  //����ָ��洢��
  reg [7:0] InsMem[0:255];

  //����ָ���ļ�
  initial begin
    $readmemh(
        "D:/OneDrive - As You Wish/HRX/Programming/Vivado/PipelineCPU/PipelineCPU.srcs/sources_1/new/instructions.txt",
        InsMem);
  end

  //��ȡָ��
  assign Ins[31:24] = InsMem[PC];
  assign Ins[23:16] = InsMem[PC+1];
  assign Ins[15:8]  = InsMem[PC+2];
  assign Ins[7:0]   = InsMem[PC+3];

endmodule
