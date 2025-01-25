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
    input sysCLK,
    input clk,
    input rstn,
    input clear,
    input [31:0] PC_in,
    input [31:0] Ins_in,
    output reg [31:0] PC_out,
    output reg [31:0] Ins_out
);

  // reg [31:0] PC;
  // reg [31:0] Ins;

  //初始化
  // initial begin
  //   // PC  = 0;
  //   // Ins = 0;
  //   if (rstn) begin
  //     PC_out  = 0;
  //     Ins_out = 0;
  //   end
  // end

  reg [31:0] cnt;

  always @(posedge sysCLK or negedge rstn) begin
    if (!rstn) begin
      cnt <= 0;
    end else begin
      if (clk) cnt <= cnt + 1;
      else cnt <= 0;
    end
  end

  //更新与重置
  always @(posedge sysCLK or negedge rstn or posedge clear) begin
    if (rstn && !clear && cnt == 7) begin
      PC_out  <= PC_in;
      Ins_out <= Ins_in;
    end else if (!rstn || clear) begin
      PC_out  <= 0;
      Ins_out <= 0;
    end
  end

  // //更新与重置
  // always @(posedge clk or negedge rstn or posedge clear) begin
  //   if (rstn && !clear) begin
  //     PC_out  <= PC_in;
  //     Ins_out <= Ins_in;
  //   end else begin
  //     PC_out  <= 0;
  //     Ins_out <= 0;
  //   end
  // end

  // //输出
  // always @(posedge clk) begin
  //   PC_out  = PC;
  //   Ins_out = Ins;
  // end

  //重置
  // always @(negedge rstn or posedge clear) begin
  //   if (PC) PC  = 0;
  //   if (Ins) Ins = 0;
  // end

endmodule
