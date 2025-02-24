`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 17:00:43
// Design Name: 
// Module Name: Forwarding
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


module Forwarding (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    input MEM_RegWre,  //MEM段寄存器写使能, 0: 不写寄存器, 1: 写寄存器
    input WB_RegWre,  //WB段寄存器写使能, 0: 不写寄存器, 1: 写寄存器
    input [4:0] MEM_WriteReg,  //MEM段目标寄存器
    input [4:0] WB_WriteReg,  //WB段目标寄存器
    input [4:0] rs,  //当前指令rs
    input [4:0] rt,  //当前指令rt
    input [31:0] MEM_Data_in,  //MEM_Data输入
    input [31:0] WB_Data_in,  //WB_Data输入
    output reg [1:0] FSrcA,  //ALU数据源1旁路控制, 00: ReadData1, 01: MEM_Data, 10: WB_Data
    output reg [1:0] FSrcB,  //ALU数据源2旁路控制, 00: ReadData1, 01: MEM_Data, 10: WB_Data
    output reg [31:0] MEM_Data_out,  //MEM_Data输出
    output reg [31:0] WB_Data_out  //WB_Data输出
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

  //输出旁路控制信号与旁路数据
  always @(posedge cntCLK or negedge rstn) begin
    if (rstn && cnt == _CLOCK_TO_Q) begin  //Clock-to-Q时触发
      FSrcA <= (MEM_RegWre && MEM_WriteReg == rs) ? 2'b01
                : (WB_RegWre && WB_WriteReg == rs) ? 2'b10
                : 2'b00;
      FSrcB <= (MEM_RegWre && MEM_WriteReg == rt) ? 2'b01
                : (WB_RegWre && WB_WriteReg == rt) ? 2'b10
                : 2'b00;
      MEM_Data_out <= MEM_Data_in;
      WB_Data_out <= WB_Data_in;
    end else if (!rstn) begin  //重置信号生效时触发
      FSrcA <= 2'b00;
      FSrcB <= 2'b00;
    end
  end

endmodule
