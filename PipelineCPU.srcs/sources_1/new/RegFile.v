`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 14:56:53
// Design Name: 
// Module Name: RegFile
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


module RegFile (
    input sysCLK,
    input clk,
    input rstn,
    input RegWre,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

  //¶¨Òå¼Ä´æÆ÷¶Ñ
  reg [31:0] RegFile[0:31];

  //³õÊ¼»¯¼Ä´æÆ÷¶Ñ
  integer i;
  // initial begin
  //   for (i = 0; i < 32; i = i + 1) begin
  //     RegFile[i] <= 0;
  //   end
  // end

  //¶Á¼Ä´æÆ÷
  assign ReadData1 = RegFile[rs];
  assign ReadData2 = RegFile[rt];

  reg [31:0] cnt;

  always @(posedge sysCLK) begin
    if (clk) cnt <= cnt + 1;
    else cnt <= 0;
  end

  //Ð´¼Ä´æÆ÷
  always @(posedge sysCLK or negedge rstn) begin
    if (rstn && cnt == 2 && RegWre) begin
      RegFile[WriteReg] <= WriteData;
    end else if (!rstn) begin
      for (i = 0; i < 32; i = i + 1) begin
        RegFile[i] <= 0;
      end
    end
  end

endmodule
