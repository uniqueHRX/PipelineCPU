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
    input sysCLK,
    input clk,
    input rstn,
    input PCSrc,
    input [31:0] newPC0,
    input [31:0] newPC1,
    output reg [31:0] curPC
);

  // reg [31:0] nextPC;

  //³õÊ¼»¯PC¼Ä´æÆ÷
  // initial begin
  //   curPC = 0;
  //   nextPC = 0;
  // end

  // always @(negedge clk) begin
  //   if (rstn) nextPC <= newPC0;
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

  always @(posedge sysCLK or negedge rstn) begin
    if (!rstn) begin
      curPC <= 0;
      // nextPC <= 0;
    end else if (rstn && cnt == 8) begin
      if (PCSrc) curPC <= newPC1;
      else curPC <= newPC0;
    end
  end

endmodule
