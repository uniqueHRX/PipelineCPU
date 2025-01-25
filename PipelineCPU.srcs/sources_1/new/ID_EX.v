`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/18 22:53:33
// Design Name: 
// Module Name: ID_EX
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


module ID_EX (
    input sysCLK,
    input clk,
    input rstn,
    input clear,
    input [31:0] PC_in,
    input [31:0] Ins_in,
    input [15:0] Signals_in,
    input [31:0] ReadData1_in,
    input [31:0] ReadData2_in,
    input [31:0] Extend_in,
    output reg [31:0] PC_out,
    output reg [31:0] Ins_out,
    output reg [15:0] Signals_out,
    output reg [31:0] ReadData1_out,
    output reg [31:0] ReadData2_out,
    output reg [31:0] Extend_out
);

  // reg [31:0] PC;
  // reg [31:0] Ins;
  // reg [15:0] Signals;
  // reg [31:0] ReadData1;
  // reg [31:0] ReadData2;
  // reg [31:0] Extend;

  // //初始化
  // initial begin
  //   PC = 0;
  //   Ins = 0;
  //   Signals = 0;
  //   ReadData1 = 0;
  //   ReadData2 = 0;
  //   Extend = 0;
  //   PC_out = 0;
  //   Ins_out = 0;
  //   Signals_out = 0;
  //   ReadData1_out = 0;
  //   ReadData2_out = 0;
  //   Extend_out = 0;
  // end

  //输入与重置
  // always @(negedge clk or negedge rstn or posedge clear) begin
  //   if (rstn && !clear) begin
  //     PC <= PC_in;
  //     Ins <= Ins_in;
  //     Signals <= Signals_in;
  //     ReadData1 <= ReadData1_in;
  //     ReadData2 <= ReadData2_in;
  //     Extend <= Extend_in;
  //   end else begin
  //     PC <= 0;
  //     Ins <= 0;
  //     Signals <= 0;
  //     ReadData1 <= 0;
  //     ReadData2 <= 0;
  //     Extend <= 0;
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

  //输出与重置
  always @(posedge sysCLK or negedge rstn or posedge clear) begin
    if (rstn && !clear && cnt == 5) begin
      PC_out <= PC_in;
      Ins_out <= Ins_in;
      Signals_out <= Signals_in;
      ReadData1_out <= ReadData1_in;
      ReadData2_out <= ReadData2_in;
      Extend_out <= Extend_in;
    end else if (!rstn || clear) begin
      PC_out <= 0;
      Ins_out <= 0;
      Signals_out <= 0;
      ReadData1_out <= 0;
      ReadData2_out <= 0;
      Extend_out <= 0;
    end
  end

  //重置
  // always @(negedge rstn or posedge clear) begin
  //   PC <= 0;
  //   Ins <= 0;
  //   Signals <= 0;
  //   ReadData1 <= 0;
  //   ReadData2 <= 0;
  //   Extend <= 0;
  //   PC_out <= 0;
  //   Ins_out <= 0;
  //   Signals_out <= 0;
  //   ReadData1_out <= 0;
  //   ReadData2_out <= 0;
  //   Extend_out <= 0;
  // end

endmodule
