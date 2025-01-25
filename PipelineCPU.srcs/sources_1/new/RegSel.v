`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:33:32
// Design Name: 
// Module Name: RegSel
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


module RegSel (
    input [1:0] RegDst,
    input [4:0] rt,
    input [4:0] rd,
    output [4:0] WriteReg
);

assign WriteReg = (RegDst == 2'b00) ? rt : (RegDst == 2'b01) ? rd : 5'b11111;

endmodule
