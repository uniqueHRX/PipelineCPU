`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 16:38:03
// Design Name: 
// Module Name: PC
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


module PC (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input PCSrc,  //PC选择信号, 0: PC+4, 1: 分支PC
    input [31:0] newPC0,  //PC+4
    input [31:0] newPC1,  //分支PC
    output reg [31:0] curPC  //当前PC输出
);

  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 8;

  //定义计数器
  reg [31:0] cnt;

  //延迟计数器，在计数时钟上升沿触发，若时钟信号为高电平，则计数器自增，反之则清零
  always @(posedge cntCLK or negedge rstn) begin
    if (!rstn) begin
      cnt <= 0;
    end else begin
      if (clk) cnt <= cnt + 1;
      else cnt <= 0;
    end
  end

  //更新PC
  always @(posedge cntCLK or negedge rstn) begin
    if (!rstn) begin  //重置信号生效时触发
      curPC <= 0;
    end else if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Q时触发
      if (PCSrc) curPC <= newPC1;
      else curPC <= newPC0;
    end
  end

endmodule
