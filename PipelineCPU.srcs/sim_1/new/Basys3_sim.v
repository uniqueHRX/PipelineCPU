`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/21 17:26:06
// Design Name: 
// Module Name: Basys3_sim
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


module Basys3_sim ();

  //信号声明
  reg clk;
  reg rstn;
  reg Button;

  //初始化信号
  initial begin
    clk = 0;
    rstn = 0;
    Button = 0;
    #1;  //等待rstn完成
    clk = !clk;  //下降沿，使PC先清零
    #1;
    rstn = 1;  //清除保持信号
    forever
      #1 begin  //产生时钟信号，周期为50ns
        clk = !clk;
      end
  end

  integer count = 0;

  always @(posedge clk) begin
    if (count == 500000) begin
      count  <= 0;
      Button <= !Button;
    end else count = count + 1;
  end

  //模块例化
  Basys3 Basys3 (
      .clk(clk),
      .reset(rstn),
      .Button(Button),
      .SW(2'b00)
  );


endmodule
