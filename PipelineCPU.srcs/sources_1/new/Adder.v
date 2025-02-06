`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:27:26
// Design Name: 
// Module Name: Adder
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


module Adder (
    input  [31:0] inA,  //输入1
    input  [31:0] inB,  //输入2
    output [31:0] Sum   //输出
);

  //对输入2移位并与输入1求和输出
  assign Sum = inA + (inB << 2);

endmodule
