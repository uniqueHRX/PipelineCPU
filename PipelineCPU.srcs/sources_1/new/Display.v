`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 16:47:23
// Design Name: 
// Module Name: Display
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


module Display (
    input sysCLK,
    input [1:0] SW,
    input [7:0]  DP_curPC,
    input [7:0]  DP_nextPC,
    input [7:0] DP_Reg,
    input [7:0] DP_DB,
    input [7:0]  DP_EX_PC,
    input [7:0]  DP_EX_Result,
    input [7:0]  DP_MEM_PC,
    input [7:0]  DP_MEM_Read,
    output reg [3:0] AN,
    output reg [7:0] DisplayCode
);

  //定义计数器
  integer i = 0;

  //i循环
  always @(posedge sysCLK) begin
    if (i == 3) i = 0;
    else i = i + 1;
  end

  //定义数据选择器
  wire [15:0] data;
  assign data = (SW == 0) ? {DP_curPC, DP_nextPC}
              : (SW == 1) ? {DP_Reg, DP_DB}
              : (SW == 2) ? {DP_EX_PC, DP_EX_Result}
              : {DP_MEM_PC, DP_MEM_Read};

  //循环输出显示信号
  always @(negedge sysCLK) begin
    case (i)
      0: AN = 4'b0111;
      1: AN = 4'b1011;
      2: AN = 4'b1101;
      3: AN = 4'b1110;
    endcase
  end

  wire [3:0] code;
  assign code = (i == 0) ? data[3:0] : (i == 1) ? data[7:4] : (i == 2) ? data[11:8] : data[15:12];

  always @(negedge sysCLK) begin
    case (code)
      4'b0000: DisplayCode = 8'b1100_0000;  //0
      4'b0001: DisplayCode = 8'b1111_1001;  //1
      4'b0010: DisplayCode = 8'b1010_0100;  //2
      4'b0011: DisplayCode = 8'b1011_0000;  //3
      4'b0100: DisplayCode = 8'b1001_1001;  //4 
      4'b0101: DisplayCode = 8'b1001_0010;  //5 
      4'b0110: DisplayCode = 8'b1000_0010;  //6 
      4'b0111: DisplayCode = 8'b1101_1000;  //7 
      4'b1000: DisplayCode = 8'b1000_0000;  //8 
      4'b1001: DisplayCode = 8'b1001_0000;  //9 
      4'b1010: DisplayCode = 8'b1000_1000;  //A 
      4'b1011: DisplayCode = 8'b1000_0011;  //B 
      4'b1100: DisplayCode = 8'b1100_0110;  //C 
      4'b1101: DisplayCode = 8'b1010_0001;  //D 
      4'b1110: DisplayCode = 8'b1000_0110;  //E 
      4'b1111: DisplayCode = 8'b1000_1110;  //F 
      default: DisplayCode = 8'b0000_0000;  //不亮
    endcase
  end

endmodule
