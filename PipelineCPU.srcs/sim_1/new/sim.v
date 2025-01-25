`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 18:42:56
// Design Name: 
// Module Name: sim
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


module sim ();

  //信号声明
  reg clk;
  reg rstn;

  //初始化信号
  initial begin
    clk   = 0;
    rstn = 0;
    #50;  //等待rstn完成
    clk = !clk;  //下降沿，使PC先清零
    #50;
    rstn = 1;  //清除保持信号
    forever
      #50 begin  //产生时钟信号，周期为50ns
        clk = !clk;
      end
  end

  //模块例化
  PipelineCPU PipelineCPU (
      .clk  (clk),
      .rstn(rstn)
  );

endmodule
