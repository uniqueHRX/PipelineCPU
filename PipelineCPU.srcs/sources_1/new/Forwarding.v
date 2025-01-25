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
      input sysCLK,
    input clk,
    input rstn,
    input MEM_RegWre,
    input WB_RegWre,
    input [4:0] MEM_WriteReg,
    input [4:0] WB_WriteReg,
    input [4:0] rs,
    input [4:0] rt,
    input [31:0] MEM_Data_in,
    input [31:0] WB_Data_in,
    output reg [1:0] FSrcA,
    output reg [1:0] FSrcB,
    output reg [31:0] MEM_Data_out,
    output reg [31:0] WB_Data_out
);

  // assign FSrcA = (MEM_RegWre && MEM_WriteReg == rs) ? 2'b01
  //               : (WB_RegWre && WB_WriteReg == rs) ? 2'b10
  //               : 2'b00;

  // assign FSrcB = (MEM_RegWre && MEM_WriteReg == rt) ? 2'b01
  //               : (WB_RegWre && WB_WriteReg == rt) ? 2'b10
  //               : 2'b00;

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
    if (rstn && cnt == 7) begin
      FSrcA <= (MEM_RegWre && MEM_WriteReg == rs) ? 2'b01
                : (WB_RegWre && WB_WriteReg == rs) ? 2'b10
                : 2'b00;
      FSrcB <= (MEM_RegWre && MEM_WriteReg == rt) ? 2'b01
                : (WB_RegWre && WB_WriteReg == rt) ? 2'b10
                : 2'b00;
      MEM_Data_out <= MEM_Data_in;
      WB_Data_out <= WB_Data_in;
    end else if (!rstn) begin
      FSrcA <= 2'b00;
      FSrcB <= 2'b00;
    end
  end

endmodule
