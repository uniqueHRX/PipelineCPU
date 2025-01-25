`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 17:15:10
// Design Name: 
// Module Name: DBSel
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


module DBSel (
    input DBDataSrc,
    input [4:0] WriteReg,
    input [31:0] MemData,
    input [31:0] Result,
    input [31:0] PC,
    output [31:0] WriteData
);

  assign WriteData = (WriteReg == 5'b11111) ? PC 
                    : DBDataSrc ? MemData
                    : Result;

endmodule
