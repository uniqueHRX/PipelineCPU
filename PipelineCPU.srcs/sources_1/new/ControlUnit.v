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


//���Ƶ�Ԫ
module ControlUnit (
    input [5:0] op,  //op�ֶ�
    input [5:0] funct,  //funct�ֶ�
    output [15:0] Signals  //�����ź�����
);

  //��������ź�
  reg ALUSrcA;  //ALU����Դ1, 0: ReadData1����·, 1: sa
  reg ALUSrcB;  //ALU����Դ2, 0: ReadData2����·, 1: Extend
  reg DBDataSrc;  //�Ĵ�������Դ, 0: ����ALU, 1: �������ݴ洢��
  reg RegWre;  //�Ĵ���дʹ��, 0: ��д�Ĵ���, 1: д�Ĵ���
  reg InsMemRW;  //ָ��洢����/д����, 0: дָ��洢��, 1: ��ָ��洢��
  reg mRD;  //�����ݴ洢������, 0: �������̬, 1: �����ݴ洢��
  reg mWR;  //д���ݴ洢������, 0: �޲���, 1: д���ݴ洢��
  reg ExtSel;  //��������չ��ʽ, 0: 0��չ, 1: ������չ
  reg [1:0] RegDst;  //Ŀ��д��Ĵ���, 00: д��rt, 01: д��rd, 10:д��$31
  reg [2:0] ALUOp;  //ALU�����ź�

  always @(*) begin
    //����op����������ź�
    case (op)

      //R����ָ��
      6'b000000: begin
        ALUSrcB = 1'b0;
        DBDataSrc = 1'b0;
        InsMemRW = 1'b1;
        mRD = 1'b0;
        mWR = 1'b0;
        ExtSel = 1'b1;
        RegDst = 2'b01;
        //����funct�����ALUSrcA��ALUOp
        case (funct)
          //����ָ��
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

          //��ָ֧��
          //jr
          6'b001000: begin
            ALUSrcA = 1'b0;
            ALUOp   = 3'b000;
            RegWre  = 1'b0;
          end
        endcase
      end


      //I����ָ��

      //����ָ��
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

      //�ô�ָ��
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

      //��ָ֧��
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


      //J����ָ��
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

  //�������źż��ɵ�����
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
