`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:56:48
// Design Name: 
// Module Name: Branch
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


module Branch (
    input sysCLK,
    input clk,
    input rstn,
    input zero,
    input sign,
    input Halt,
    input [31:0] PC,
    input [31:0] BranchPC,
    input [31:0] HaltPC,
    input [31:0] Ins,
    input [31:0] Result,
    output reg Branch,
    output reg [31:0] newPC
);

  // assign Branch = Halt ? 1
  //                 : (Ins[31:26] == 6'b000010) ? 1
  //                 : (Ins[31:26] == 6'b000011) ? 1
  //                 : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? 1
  //                 : (Ins[31:26] == 6'b000100 && zero) ? 1
  //                 : (Ins[31:26] == 6'b000101 && !zero) ? 1
  //                 : (Ins[31:26] == 6'b000110 && (sign || zero)) ? 1
  //                 : (Ins[31:26] == 6'b000001 && sign) ? 1
  //                 : 0;

  // assign newPC = Halt ? HaltPC
  //               : (Ins[31:26] == 6'b000010) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
  //               : (Ins[31:26] == 6'b000011) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
  //               : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? Result
  //               : (Ins[31:26] == 6'b000100 && zero) ? BranchPC
  //               : (Ins[31:26] == 6'b000101 && !zero) ? BranchPC
  //               : (Ins[31:26] == 6'b000110 && (sign || zero)) ? BranchPC
  //               : (Ins[31:26] == 6'b000001 && sign) ? BranchPC
  //               : PC;


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
    if (rstn && cnt == 4) begin
      Branch <= Halt ? 1
                : (Ins[31:26] == 6'b000010) ? 1
                : (Ins[31:26] == 6'b000011) ? 1
                : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? 1
                : (Ins[31:26] == 6'b000100 && zero) ? 1
                : (Ins[31:26] == 6'b000101 && !zero) ? 1
                : (Ins[31:26] == 6'b000110 && (sign || zero)) ? 1
                : (Ins[31:26] == 6'b000001 && sign) ? 1
                : 0;
      newPC <= Halt ? HaltPC
                : (Ins[31:26] == 6'b000010) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
                : (Ins[31:26] == 6'b000011) ? (PC[31:28] << 28) + (Ins[25:0] << 2)
                : (Ins[31:26] == 6'b000000 && Ins[5:0] == 6'b001000) ? Result
                : (Ins[31:26] == 6'b000100 && zero) ? BranchPC
                : (Ins[31:26] == 6'b000101 && !zero) ? BranchPC
                : (Ins[31:26] == 6'b000110 && (sign || zero)) ? BranchPC
                : (Ins[31:26] == 6'b000001 && sign) ? BranchPC
                : PC;
    end else if (!rstn) begin
      Branch <= 0;
      newPC  <= 0;
    end
  end


endmodule
