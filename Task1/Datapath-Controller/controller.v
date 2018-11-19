`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ECE274
// Engineer: Adrian Bao, Bob Bradford
// 
// Additional Comments: 
// The controller for Task 1
// 
//////////////////////////////////////////////////////////////////////////////////


module controller(Clock, Reset, op, func, RegDst, RegWrite, ALUSrc, ALUOp,
     MemRead, MemWrite, MemtoReg, PCSrc, RegA, RegB);

    input Clock, Reset;
    input [5:0] op;
    input [5:0] func;
    output reg RegDst, RegWrite, ALUSrc, MemRead, MemWrite,
         MemtoReg, PCSrc, RegA, RegB;
    output reg [3:0] ALUOp;
    
    reg [3:0] state, statenext;
    parameter s0 = 0, add = 1, sub = 2, nd = 3, ur = 4, slt = 5, sll = 6, srl =7,
        clo = 8, clz =9, mul = 10, addi = 11, ori = 12;
        
    always @ (posedge Clock)
    begin
        if(Reset == 1) begin
           state <= s0;
        end
        else begin
           state <= statenext;
        end
    end
    
    always @ (op, func, state ) begin
      RegDst <= 0; RegWrite <= 1;
      ALUSrc <= 0; ALUOp <= 4'd0; MemRead <= 0; MemWrite <= 0;
      MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
      case(state)
      
        s0: begin
            if ((op == 6'b000000) && (func == 6'b100000))
                statenext <= add;
         end
         
        add: begin
            RegDst <= 1; RegWrite <= 1;
               ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
               MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'd0;
            if ((op == 6'b000000) && (func == 6'b100000))
                statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                statenext <= ori;      
         end
         
        sub: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0001;
            if ((op == 6'b000000) && (func == 6'b100000))
                statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                statenext <= ori;
         end

        nd: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0011;
            if ((op == 6'b000000) && (func == 6'b100000))
                statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                statenext <= ori;
         end                  

        ur: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0100;
            if ((op == 6'b000000) && (func == 6'b100000))
                statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                statenext <= ori;
         end
         
        slt: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0101;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end

        sll: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 1; RegB <= 1;
            ALUOp <= 4'b1000;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end
            
        srl: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 1; RegB <= 1;
            ALUOp <= 4'b1001;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end           

        clo: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b1011;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end           

        clz: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b1100;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end

        mul: begin
            RegDst <= 1; RegWrite <= 1;
                        ALUSrc <= 0; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0010;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end         

        addi: begin
            RegDst <= 0; RegWrite <= 1;
                        ALUSrc <= 1; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0000;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end

        ori: begin
            RegDst <= 0; RegWrite <= 1;
                        ALUSrc <= 1; MemRead <= 0; MemWrite <= 0;
                        MemtoReg <= 0; PCSrc <= 0; RegA <= 0; RegB <= 0;
            ALUOp <= 4'b0100;
            if ((op == 6'b000000) && (func == 6'b100000))
                 statenext <= add;
            else if ((op == 6'b000000) && (func == 6'b100010))
                 statenext <= sub;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= nd;
            else if ((op == 6'b000000) && (func == 6'b100100))
                 statenext <= ur;
            else if ((op == 6'b000000) && (func == 6'b101010))
                 statenext <= slt;
            else if ((op == 6'b000000) && (func == 6'b000000))
                 statenext <= sll;
            else if ((op == 6'b000000) && (func == 6'b000010))
                 statenext <= srl;  
            else if ((op == 6'b011100) && (func == 6'b100001))
                 statenext <= clo;
            else if ((op == 6'b011100) && (func == 6'b100000))
                 statenext <= clz;
            else if ((op == 6'b011100) && (func == 6'b000010))
                 statenext <= mul;
            else if ((op == 6'b001000) && (func == 6'b100000))
                 statenext <= addi;
            else if ((op == 6'b001101) && (func == 6'b100101))
                 statenext <= ori;
            end
                                                      
      endcase
        
   end
        
endmodule
