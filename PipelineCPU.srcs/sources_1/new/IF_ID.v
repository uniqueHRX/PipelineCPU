`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/18 22:53:33
// Design Name: 
// Module Name: IF_ID
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


module IF_ID (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input clear,  //清零信号, 0: 保持, 1: 清零
    input [31:0] PC_in,  //从IF段读入数据
    input [31:0] Ins_in,
    output reg [31:0] PC_out,  //向ID段输出数据
    output reg [31:0] Ins_out
);

  //定义Clock-to-Q
  integer _CLOCK_TO_Q = 7;

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

  //输出与重置
  always @(posedge cntCLK or negedge rstn or posedge clear) begin
    if (rstn && !clear && cnt == _CLOCK_TO_Q) begin  //Clock-to-Q时触发
      PC_out  <= PC_in;
      Ins_out <= Ins_in;
    end else if (!rstn || clear) begin  //重置或清零信号生效时触发
      PC_out  <= 0;
      Ins_out <= 0;
    end
  end

endmodule
