`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ECE274
// Engineer: Adrian Bao, Bob Bradford
// 
// Additional Comments: 
// The controller for Task 1
// 
//////////////////////////////////////////////////////////////////////////////////


module controller(op, func, RegDst, RegWrite, ALUSrc, ALUOp,
     MemRead, MemWrite, MemtoReg, PCSrc, RegA, RegB, Zero);

    input [5:0] op, func;
    output reg RegDst, RegWrite, ALUSrc, MemRead, MemWrite,
         MemtoReg, PCSrc, RegA, RegB;
    output reg [3:0] ALUOp;
    input Zero;
    
            
    always @ (op,func ) begin
      
                  
                  if ((op == 6'b000000) && (func == 6'b100000))begin
                    RegDst <= 1; RegWrite <= 1;
                    ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                    MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                    ALUOp <= 4'd0;
                  end
                  
                  else if ((op == 6'b000000) && (func == 6'b100010))begin
                    RegDst <= 1; RegWrite <= 1;
                    ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                    MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                    ALUOp <= 4'b0001;
                  end
                  
                  else if ((op == 6'b000000) && (func == 6'b100100)) begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0011;
                  end
                      
                  else if ((op == 6'b000000) && (func == 6'b100101)) begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0100;
                  end
                  
                  else if ((op == 6'b000000) && (func == 6'b101010))begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0101;
                  end
                  
                  else if ((op == 6'b000000) && (func == 6'b000000))begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 1; RegB <= 1;
                      ALUOp <= 4'b1000;
                  end
                  
                  else if ((op == 6'b000000) && (func == 6'b000010))begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 1; RegB <= 1;
                      ALUOp <= 4'b1001;
                  end
                  
                  else if ((op == 6'b011100) && (func == 6'b100001))begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b1011;
                  end
                  
                  else if ((op == 6'b011100) && (func == 6'b100000))begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b1100;
                  end
                 
                  else if ((op == 6'b011100) && (func == 6'b000010)) begin
                      RegDst <= 1; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0010;
                  end
                  
                  else if ((op == 6'b001000))begin
                      RegDst <= 0; RegWrite <= 1;
                      ALUSrc <= 1; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0000;
                  end
                  
                  else if ((op == 6'b001101))begin
                      RegDst <= 0; RegWrite <= 1;
                      ALUSrc <= 1; MemRead <= 0; MemWrite <= 0;
                      MemtoReg <= 1; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0100;
                  end
                  
                  /* Task 2 - Addition of lw, sw, and bne capabilites */
                  
                  else if ((op == 6'b100011)) begin // lw
                      RegDst <= 0; RegWrite <= 1; // actually 1 to write to rt
                      ALUSrc <= 1; MemRead <= 1; MemWrite <= 0;
                      MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0000;                      
                  end

                  else if ((op == 6'b101011)) begin // sw
                      RegDst <= 0; RegWrite <= 1; // actually 1 to write to rt
                      ALUSrc <= 1; MemRead <= 0; MemWrite <= 1;
                      MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0000;                   
                  end

                  else if ((op == 6'b000101)) begin // bne
                      RegDst <= 0; RegWrite <= 1;
                      ALUSrc <= 0; MemRead <= 1; MemWrite <= 0;
                      MemtoReg <= 0; PCSrc <= ~Zero; // PC Source needs to equal !(zero) // need to add as input to controller
                      RegA <= 0; RegB <= 0;
                      ALUOp <= 4'b0111;
                  end
       
                  else begin
                        RegDst <= 0; RegWrite <= 0;
                        ALUSrc <= 0; ALUOp <= 4'd0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
                  end
                  
           end
        
endmodule
