`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:08:50
// Design Name: 
// Module Name: Extend
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


module Extend (
    input [15:0] immediate,  //immediate段
    input ExtSel,  //立即数扩展方式, 0: 0扩展, 1: 符号扩展
    output [31:0] Extend  //扩展后的立即数
);

  //根据ExtSel进行立即数扩展
  assign Extend[15:0]  = immediate[15:0];
  assign Extend[31:16] = ExtSel ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;

endmodule
