`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 15:15:34
// Design Name: 
// Module Name: Mux32bit
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


module Mux32bit (
    input sel,
    input [1:0] F_sel,
    input [31:0] src0,
    input [31:0] src1,
    input [31:0] F_src01,
    input [31:0] F_src10,
    output [31:0] ret
);

  assign ret = sel ? src1
              : (F_sel == 2'b01) ? F_src01
              : (F_sel == 2'b10) ? F_src10
              : src0;

endmodule
