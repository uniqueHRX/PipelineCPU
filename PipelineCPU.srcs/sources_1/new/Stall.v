`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/20 11:19:54
// Design Name: 
// Module Name: Stall
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


module Stall (
    input sysCLK,
    input clk,
    input rstn,
    input Branch,
    input [31:0] BranchPC,
    input [31:0] curPC,
    input [31:0] Ins,
    output reg PCSrc,
    output reg [31:0] newPC
);

  // assign PCSrc = Branch ? 1 : (Ins[31:26] == 6'b100011) ? 1 : 0;

  // assign newPC = Branch ? BranchPC : curPC;


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
    if (rstn && cnt == 6) begin
      PCSrc <= Branch ? 1 : (Ins[31:26] == 6'b100011) ? 1 : 0;
      newPC <= Branch ? BranchPC : curPC;
    end else if (!rstn) begin
      PCSrc <= 0;
      newPC <= 0;
    end
  end

endmodule
