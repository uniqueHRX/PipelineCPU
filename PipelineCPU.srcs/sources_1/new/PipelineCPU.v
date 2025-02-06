`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/19 16:54:03
// Design Name: 
// Module Name: PipelineCPU
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


module PipelineCPU (
    input cntCLK,  //计数时钟
    input clk,  //时钟信号
    input rstn,  //重置信号
    output [7:0] DP_curPC,  //显示数据输出
    output [7:0] DP_nextPC,
    output [7:0] DP_Reg,
    output [7:0] DP_DB,
    output [7:0] DP_EX_PC,
    output [7:0] DP_EX_Result,
    output [7:0] DP_MEM_PC,
    output [7:0] DP_MEM_Read
);


  // 定义常量，指示控制信号在总线中的位置
  parameter _ALUSrcA = 0;
  parameter _ALUSrcB = 1;
  parameter _DBDataSrc = 2;
  parameter _RegWre = 3;
  parameter _InsMemRW = 4;
  parameter _mRD = 5;
  parameter _mWR = 6;
  parameter _ExtSel = 7;
  parameter _RegDst_1 = 9;
  parameter _RegDst_2 = 8;
  parameter _ALUOp_1 = 12;
  parameter _ALUOp_2 = 11;
  parameter _ALUOp_3 = 10;


  //定义数据通路

  //IF
  wire [31:0] IF_PC;
  wire [31:0] IF_newPC;
  wire [31:0] IF_Ins;

  //ID
  wire [31:0] ID_PC;
  wire [31:0] ID_Ins;
  wire [15:0] ID_Signals;
  wire [31:0] ID_ReadData1;
  wire [31:0] ID_ReadData2;
  wire [31:0] ID_Extend;

  //EX
  wire [31:0] EX_PC;
  wire [31:0] EX_BranchPC;
  wire [31:0] EX_Ins;
  wire [15:0] EX_Signals;
  wire [31:0] EX_ReadData1;
  wire [31:0] EX_ReadData2;
  wire [31:0] EX_Extend;
  wire [31:0] EX_Result;
  wire [4:0] EX_WriteReg;
  wire EX_zero;
  wire EX_sign;

  //MEM
  wire [31:0] MEM_PC;
  wire [31:0] MEM_BranchPC;
  wire [31:0] MEM_Ins;
  wire [15:0] MEM_Signals;
  wire [31:0] MEM_ReadData2;
  wire [31:0] MEM_MemData;
  wire [31:0] MEM_Result;
  wire [4:0] MEM_WriteReg;
  wire MEM_zero;
  wire MEM_sign;

  //WB
  wire [31:0] WB_PC;
  wire [31:0] WB_Ins;
  wire [15:0] WB_Signals;
  wire [31:0] WB_MemData;
  wire [31:0] WB_Result;
  wire [31:0] WB_WriteData;
  wire [4:0] WB_WriteReg;

  //Branch and Stall
  wire BS_Halt;
  wire BS_Branch;
  wire BS_PCSrc;
  wire [31:0] BS_HaltPC;
  wire [31:0] BS_BranchPC;
  wire [31:0] BS_newPC;

  //Forwarding
  wire [1:0] FW_FSrcA;
  wire [1:0] FW_FSrcB;
  wire [31:0] FW_MEM_Data;
  wire [31:0] FW_WB_Data;

  //Demo
  wire [7:0] Demo_PC;
  wire [7:0] Demo_newPC;
  wire [7:0] Demo_Reg;
  wire [7:0] Demo_DB;


  ////
  //模块例化
  ////

  //段寄存器

  //IF/ID寄存器
  IF_ID IF_ID (
      .cntCLK (cntCLK),
      .clk    (clk),
      .rstn   (rstn),
      .clear  (BS_PCSrc),
      .PC_in  (IF_newPC),
      .Ins_in (IF_Ins),
      .PC_out (ID_PC),
      .Ins_out(ID_Ins)
  );

  //ID/EX寄存器
  ID_EX ID_EX (
      .cntCLK       (cntCLK),
      .clk          (clk),
      .rstn         (rstn),
      .clear        (BS_Branch),
      .PC_in        (ID_PC),
      .Ins_in       (ID_Ins),
      .Signals_in   (ID_Signals),
      .ReadData1_in (ID_ReadData1),
      .ReadData2_in (ID_ReadData2),
      .Extend_in    (ID_Extend),
      .PC_out       (EX_PC),
      .Ins_out      (EX_Ins),
      .Signals_out  (EX_Signals),
      .ReadData1_out(EX_ReadData1),
      .ReadData2_out(EX_ReadData2),
      .Extend_out   (EX_Extend)
  );

  //EX/MEM寄存器
  EX_MEM EX_MEM (
      .cntCLK       (cntCLK),
      .clk          (clk),
      .rstn         (rstn),
      .clear        (BS_Halt),
      .PC_in        (EX_PC),
      .BranchPC_in  (EX_BranchPC),
      .Ins_in       (EX_Ins),
      .Signals_in   (EX_Signals),
      .ReadData2_in (EX_ReadData2),
      .Result_in    (EX_Result),
      .zero_in      (EX_zero),
      .sign_in      (EX_sign),
      .WriteReg_in  (EX_WriteReg),
      .PC_out       (MEM_PC),
      .BranchPC_out (MEM_BranchPC),
      .Ins_out      (MEM_Ins),
      .Signals_out  (MEM_Signals),
      .ReadData2_out(MEM_ReadData2),
      .Result_out   (MEM_Result),
      .zero_out     (MEM_zero),
      .sign_out     (MEM_sign),
      .WriteReg_out (MEM_WriteReg)
  );

  //MEM/WB寄存器
  MEM_WB MEM_WB (
      .cntCLK      (cntCLK),
      .clk         (clk),
      .rstn        (rstn),
      .PC_in       (MEM_PC),
      .Ins_in      (MEM_Ins),
      .Signals_in  (MEM_Signals),
      .MemData_in  (MEM_MemData),
      .Result_in   (MEM_Result),
      .WriteReg_in (MEM_WriteReg),
      .PC_out      (WB_PC),
      .Ins_out     (WB_Ins),
      .Signals_out (WB_Signals),
      .MemData_out (WB_MemData),
      .Result_out  (WB_Result),
      .WriteReg_out(WB_WriteReg)
  );


  //IF段

  //程序计数器
  PC PC (
      .cntCLK(cntCLK),
      .clk   (clk),
      .rstn  (rstn),
      .PCSrc (BS_PCSrc),
      .newPC0(IF_newPC),
      .newPC1(BS_newPC),
      .curPC (IF_PC)
  );

  //PC+4加法器
  Adder Add4toPC (
      .inA(IF_PC),
      .inB({31'b0, 1'b1}),
      .Sum(IF_newPC)
  );

  //指令存储器
  InsMem InsMem (
      .PC (IF_PC),
      .Ins(IF_Ins)
  );


  //ID段

  //控制单元
  ControlUnit ControlUnit (
      .op     (ID_Ins[31:26]),
      .funct  (ID_Ins[5:0]),
      .Signals(ID_Signals)
  );

  //寄存器堆
  RegFile RegFile (
      .cntCLK   (cntCLK),
      .clk      (clk),
      .rstn     (rstn),
      .RegWre   (WB_Signals[_RegWre]),
      .rs       (ID_Ins[25:21]),
      .rt       (ID_Ins[20:16]),
      .WriteReg (WB_WriteReg),
      .WriteData(WB_WriteData),
      .ReadData1(ID_ReadData1),
      .ReadData2(ID_ReadData2)
  );

  //立即数扩展
  Extend Extend (
      .immediate(ID_Ins[15:0]),
      .ExtSel   (ID_Signals[_ExtSel]),
      .Extend   (ID_Extend)
  );


  //EX段

  //算术逻辑单元
  ALU ALU (
      .ALUOp    ({EX_Signals[_ALUOp_1], EX_Signals[_ALUOp_2], EX_Signals[_ALUOp_3]}),
      .ReadData1(EX_ReadData1),
      .ReadData2(EX_ReadData2),
      .Extend   (EX_Extend),
      .sa       (EX_Ins[10:6]),
      .MEM_Data (FW_MEM_Data),
      .WB_Data  (FW_WB_Data),
      .ALUSrcA  (EX_Signals[_ALUSrcA]),
      .ALUSrcB  (EX_Signals[_ALUSrcB]),
      .FSrcA    (FW_FSrcA),
      .FSrcB    (FW_FSrcB),
      .Result   (EX_Result),
      .sign     (EX_sign),
      .zero     (EX_zero)
  );

  //PC分支加法器
  Adder AddExttoPC (
      .inA(EX_PC),
      .inB(EX_Extend),
      .Sum(EX_BranchPC)
  );

  //目标寄存器选择
  RegSel RegSel (
      .RegDst  ({EX_Signals[_RegDst_1], EX_Signals[_RegDst_2]}),
      .rt      (EX_Ins[20:16]),
      .rd      (EX_Ins[15:11]),
      .WriteReg(EX_WriteReg)
  );

  //旁路单元
  Forwarding Forwarding (
      .cntCLK      (cntCLK),
      .clk         (clk),
      .rstn        (rstn),
      .MEM_RegWre  (MEM_Signals[_RegWre]),
      .WB_RegWre   (WB_Signals[_RegWre]),
      .MEM_WriteReg(MEM_WriteReg),
      .WB_WriteReg (WB_WriteReg),
      .rs          (EX_Ins[25:21]),
      .rt          (EX_Ins[20:16]),
      .MEM_Data_in (MEM_Result),
      .WB_Data_in  (WB_WriteData),
      .FSrcA       (FW_FSrcA),
      .FSrcB       (FW_FSrcB),
      .MEM_Data_out(FW_MEM_Data),
      .WB_Data_out (FW_WB_Data)
  );

  //阻塞控制单元
  Stall Stall (
      .cntCLK  (cntCLK),
      .clk     (clk),
      .rstn    (rstn),
      .Branch  (BS_Branch),
      .BranchPC(BS_BranchPC),
      .curPC   (EX_PC),
      .Ins     (EX_Ins),
      .PCSrc   (BS_PCSrc),
      .newPC   (BS_newPC)
  );


  //MEM段

  //数据存储器
  DataMem DataMem (
      .cntCLK   (cntCLK),
      .clk      (clk),
      .Result   (MEM_Result),
      .ReadData2(MEM_ReadData2),
      .mRD      (MEM_Signals[_mRD]),
      .mWR      (MEM_Signals[_mWR]),
      .MemData  (MEM_MemData)
  );

  //分支控制单元
  Branch Branch (
      .cntCLK  (cntCLK),
      .clk     (clk),
      .rstn    (rstn),
      .zero    (MEM_zero),
      .sign    (MEM_sign),
      .Halt    (BS_Halt),
      .PC      (MEM_PC),
      .BranchPC(MEM_BranchPC),
      .HaltPC  (BS_HaltPC),
      .Ins     (MEM_Ins),
      .Result  (MEM_Result),
      .Branch  (BS_Branch),
      .newPC   (BS_BranchPC)
  );


  //WB段

  //数据总线选择器
  DBSel DBSel (
      .DBDataSrc(WB_Signals[_DBDataSrc]),
      .WriteReg (WB_WriteReg),
      .MemData  (WB_MemData),
      .Result   (WB_Result),
      .PC       (WB_PC),
      .WriteData(WB_WriteData)
  );

  //停机控制单元
  Halt Halt (
      .rstn  (rstn),
      .WB_Ins(WB_Ins),
      .WB_PC (WB_PC),
      .Halt  (BS_Halt),
      .PC    (BS_HaltPC)
  );


  //演示总线
  DemoBus DemoBus (
      .rstn        (rstn),
      .Halt        (BS_Halt),
      .IF_PC       (IF_PC),
      .ID_PC       (ID_PC),
      .EX_PC       (EX_PC),
      .MEM_PC      (MEM_PC),
      .WB_PC       (WB_PC),
      .WB_RegWre   (WB_Signals[_RegWre]),
      .WB_WriteReg (WB_WriteReg),
      .WB_WriteData(WB_WriteData),
      .Demo_PC     (Demo_PC),
      .Demo_newPC  (Demo_newPC),
      .Demo_Reg    (Demo_Reg),
      .Demo_DB     (Demo_DB)
  );


  //显示信号输出
  assign DP_curPC = Demo_PC;
  assign DP_nextPC = Demo_newPC;
  assign DP_Reg = Demo_Reg;
  assign DP_DB = Demo_DB;
  assign DP_EX_PC = EX_PC[7:0] ? EX_PC[7:0] - 4 : EX_PC[7:0];
  assign DP_EX_Result = EX_Result[7:0];
  assign DP_MEM_PC = MEM_PC[7:0] ? MEM_PC[7:0] - 4 : MEM_PC[7:0];
  assign DP_MEM_Read = MEM_MemData[7:0];


endmodule
