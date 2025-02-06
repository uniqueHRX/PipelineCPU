`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:15:34
// Design Name: 
// Module Name: Mux32bit
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


module Mux32bit (
    input sel,  //选择信号
    input [1:0] F_sel,  //旁路选择信号
    input [31:0] src0,  //输入0
    input [31:0] src1,  //输入1
    input [31:0] F_src01,  //旁路输入01
    input [31:0] F_src10,  //旁路输入10
    output [31:0] ret  //输出
);

  //选择输出
  assign ret = sel ? src1
              : (F_sel == 2'b01) ? F_src01
              : (F_sel == 2'b10) ? F_src10
              : src0;

endmodule
