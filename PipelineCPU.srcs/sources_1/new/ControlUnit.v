`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/18 16:27:23
// Design Name: 
// Module Name: ControlUnit
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


//控制单元
module ControlUnit (
    input [5:0] op,  //op字段
    input [5:0] funct,  //funct字段
    output [15:0] Signals  //控制信号总线
);

  //定义控制信号
  reg ALUSrcA;  //ALU数据源1, 0: ReadData1或旁路, 1: sa
  reg ALUSrcB;  //ALU数据源2, 0: ReadData2或旁路, 1: Extend
  reg DBDataSrc;  //寄存器数据源, 0: 来自ALU, 1: 来自数据存储器
  reg RegWre;  //寄存器写使能, 0: 不写寄存器, 1: 写寄存器
  reg InsMemRW;  //指令存储器读/写控制, 0: 写指令存储器, 1: 读指令存储器
  reg mRD;  //读数据存储器控制, 0: 输出高阻态, 1: 读数据存储器
  reg mWR;  //写数据存储器控制, 0: 无操作, 1: 写数据存储器
  reg ExtSel;  //立即数扩展方式, 0: 0扩展, 1: 符号扩展
  reg [1:0] RegDst;  //目标写入寄存器, 00: 写入rt, 01: 写入rd, 10:写入$31
  reg [2:0] ALUOp;  //ALU控制信号

  always @(*) begin
    //根据op码输出控制信号
    case (op)

      //R类型指令
      6'b000000: begin
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b01;
        //根据funct码输出ALUSrcA和ALUOp
        case (funct)
          //算术指令
          //add
          6'b100000: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b000;
            RegWre  = 1'b1;
          end
          //sub
          6'b100010: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b001;
            RegWre  = 1'b1;
          end
          //sll
          6'b000000: begin
            ALUSrcA = 1'b1;
            ALUOp   = 3'b010;
            RegWre  = 1'b1;
          end
          //or
          6'b100101: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b011;
            RegWre  = 1'b1;
          end
          //and
          6'b100100: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b100;
            RegWre  = 1'b1;
          end
          //sltu
          6'b101011: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b101;
            RegWre  = 1'b1;
          end
          //slt
          6'b101010: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b110;
            RegWre  = 1'b1;
          end
          //xor
          6'b100110: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b111;
            RegWre  = 1'b1;
          end

          //分支指令
          //jr
          6'b001000: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b000;
            RegWre  = 1'b0;
          end
        endcase
      end


      //I类型指令

      //算术指令
      //addiu
      6'b001001: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b0;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b000;
      end

      //andi
      6'b001100: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b0;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b0;
        RegDst = 2'b00;
        ALUOp = 3'b100;
      end

      //ori
      6'b001101: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b0;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b0;
        RegDst = 2'b00;
        ALUOp = 3'b011;
      end

      //xori
      6'b001110: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b0;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b0;
        RegDst = 2'b00;
        ALUOp = 3'b111;
      end

      //slti
      6'b001010: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b0;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b110;
      end

      //访存指令
      //sw
      6'b101011: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b1;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b000;
      end

      //lw
      6'b100011: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b1;
        DBDataSrc = 1'b1;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b1;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b000;
      end

      //分支指令
      //beq
      6'b000100: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b001;
      end

      //bne
      6'b000101: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b001;
      end

      //blez
      6'b000110: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b001;
      end

      //bltz
      6'b000001: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b00;
        ALUOp = 3'b001;
      end


      //J类型指令
      //j
      6'b000010: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b0;
        RegDst = 2'b00;
        ALUOp = 3'b000;
      end

      //jal
      6'b000011: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b1;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b0;
        RegDst = 2'b10;
        ALUOp = 3'b000;
      end

      //halt
      6'b111111: begin
        ALUSrcA = 1'b0;
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        RegWre = 1'b0;
        InsMemRW = 1'b0;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b0;
        RegDst = 2'b00;
        ALUOp = 3'b000;
      end

    endcase
  end

  //将控制信号集成到总线
  assign Signals[0] = ALUSrcA;
  assign Signals[1] = ALUSrcB;
  assign Signals[2] = DBDataSrc;
  assign Signals[3] = RegWre;
  assign Signals[4] = InsMemRW;
  assign Signals[5] = mRD;
  assign Signals[6] = mWR;
  assign Signals[7] = ExtSel;
  assign Signals[9:8] = RegDst;
  assign Signals[12:10] = ALUOp;
  assign Signals[15:13] = 3'b000;

endmodule
