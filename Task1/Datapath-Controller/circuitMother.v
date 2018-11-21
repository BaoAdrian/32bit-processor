/*
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ECE274
// Engineer: Adrian Bao, Bob Bradford
// 
// Additional Comments: 
// The circuit containing all the datapath modules for Task 1
// 
//////////////////////////////////////////////////////////////////////////////////


module circuitMother(Clock, Reset, Instruction);
    input Clock, Reset;
    output reg [31:0] Instruction;
    
    
    //All control signals should be declared as wire.
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite,
             MemtoReg, PCSrc, RegA, RegB;
    wire [4:0] ALUOp;
    
    //instances
    //declare inputs outputs of each module as wires between instances
    
    //module InstructionMemory IM(Address, Instruction);
        // Address - (output of PC)
        // Instruction - (Instruction [31:0])
    
    //module Mux32Bit2To1 RA(out, inA, inB, sel);
        // inA - Instruction [20:16]
        // inB - Instruction [25:21]
        // sel - RegA
    
    //module Mux32Bit2To1 RD(out, inA, inB, sel);
        // inA - Instruction [15:11]
        // inB - Instruction [20:16]
        // sel - RegDst
        
   //module SignExtension SE(in, out);
        // in - Instruction[15:0]
        // out - new 32 bit signal
        
        
   //module ALU32Bit SL2(ALUControl, A, B, ALUResult, Zero);
        //ALUControl - 1000
        //A - *** output from (PC+4) ***
        //B - new 32 bit signal of SE^^
        //Zero - ??? ground???
        
        //this one might be redundant... all we need to do if shift the 
        //sign extension <<2 bits...
        
        
   //module ProgramCounter PC(Address, PCResult, Reset, Clk);
       //Address - out of MuxPCSrc
       //PCResult - into InstructionMemory
       //Reset - ??
       //Clk - if we need an out from CLKDIV?
       
   //module ALU32Bit PCSEADD(ALUControl, A, B, ALUResult, Zero);
      //ALUControl - 0000
      //A - *** output from (PCpl4) ***
      //B - new 32 bit signal of SE^^ that is <<2
      //ALUResult - [31:0] into next mux
      //Zero - ??? ground???

   //module PCAdder PCpl4(PCResult, PCAddResult);
     //PCResult - output from PC
     //PCAddResult - output into mux PCSrc inB and PCSEADD 'B'
     
        
  //module Mux32Bit2To1 RD(out, inA, inB, sel);
      // inA - ALUResult of PCSEADD
      // inB - *** output from PC+4 ***
      // sel - PCSrc
    
  //module RegisterFile RFMain(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
     //ReadRegister1 - output from mux RA
     // ReadRegister2 - Instruction [20:16]
     // WriteRegister - output from mux RD
     // WriteData - output from mux MtR
     // RegWrite - RegWrite
     // Clk - clock
     // ReadData1 - output to mother ALU input A
     // ReadData2 - out to inB of mux ASRC
     
  //module Mux32Bit2To1 ASRC(out, inA, inB, sel);
     // inA - new 32 bit signal of SE
     // inB - output of ReadData2 ^^
     // sel - ALUSrc
     
  //module Mux32Bit2To1 RB(out, inA, inB, sel);
     // inA - Instruction [10:6]
     // inB - out from mux ASRC
     // sel - ARegB
     
     // *** THE ALU OF THE HOUR LADIES AND GENTLEMEN!!!!! *** //
     
  //module ALU32Bit Main(ALUControl, A, B, ALUResult, Zero);
    //ALUControl - ALUOp
    //A - ReadData1
    //B - out of mux RB
    //ALUResult - [31:0] into Data Memory
    //Zero - into DataMemory
    
  //module Mux32Bit2To1 MtR(out, inA, inB, sel);
    // inA - ALUResult of ALU "Main"
    // inB - ReadData output of DataMemory
    // sel - MemtoReg  
// endmodule
*/


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ECE274
// Engineer: Adrian Bao, Bob Bradford
// 
// Additional Comments: 
// The circuit containing all the datapath modules for Task 1
// 
//////////////////////////////////////////////////////////////////////////////////


module circuitMother(Clock, Reset, Instruction);
    input Clock, Reset;
    
    output reg [31:0] Instruction;
    
    //All control signals should be declared as wire.
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite,
             MemtoReg, PCSrc, RegA, RegB;
    wire [4:0] ALUOp;
    wire Zero;
    
    // RegisterFile
    wire [4:0] WR, RR1;
    wire [31:0] RD1, RD2;
    
    // PC and PCAdder 
    wire [31:0] PCpl4Out, PCOut, PCSrcOut;
    
    // Sign Extension
    wire [31:0] PCSEADDOut, SL2Out, SESig;
    
    // ALU
    wire [31:0] ALUMainOut, ASrcOut, RBOut;
    wire ALUZero;
       
    // Data Memory   
    wire [31:0] DMRD, MtROut;
    
    // Instruction Memory  
    wire [31:0] AddrIns, InsMain;
   
    //instances
    //declare inputs/outputs of each module as wires between instances
    
    
    // For Reference InsMain[31:26] = op
    //               InsMain[25:21] = rs
    //               InsMain[20:16] = rt
    //               InsMain[15:11] = rd
    //               InsMain[10:6] = shamt
    //               InsMain[5:0] = func
    
    
      
    // InstructionMemory(Address, Instruction)
    InstructionMemory IM(PCOut,   InsMain);
        // Address - (output of PC)
        // Instruction - (Instruction [31:0])
            
    


    // controller( Clock, Reset, op,             func,         RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc, RegA, RegB);
    controller CTR(Clock, Reset, InsMain[31:26], InsMain[5:0], RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc, RegA, RegB);

    
    //              out  rt                      rs                      RegA
    Mux32Bit2To1 RA(RR1, {27'b0,InsMain[20:16]}, {27'b0,InsMain[25:21]}, RegA);
        // inA - Instruction [20:16]
        // inB - Instruction [25:21]
        // sel - RegA
    
    
    //              out  rd                      rt                      RegA
    Mux32Bit2To1 RD(WR, {27'b0,InsMain[15:11]}, {27'b0,InsMain[20:16]}, RegDst);
        // inA - Instruction [15:11]
        // inB - Instruction [20:16]
        // sel - RegDst
    
        
   
   // SignExtension(in,            out);     
   SignExtension SE(InsMain[15:0], SESig);
        // in - Instruction[15:0]
        // out - new 32 bit signal
        
   
   // ALU32Bit( ALUControl,    A,        B,       ALUResult,  Zero)    
   ALU32Bit SL2(4'b1000,       SESig,    32'd2,   SL2Out,     Zero);
        
        //ALUControl - 1000
        //A - *** output from (PC+4) ***
        //B - 32'd2 (32 to stay consistent)
        //Zero - ??? ground???
        
        
   // ProgramCounter(Address,  PCResult, Reset, Clk);
   ProgramCounter PC(PCSrcOut, PCOut,    Reset, Clock);
        //Address - out of MuxPCSrc "Instruction"         
        //PCResult - into InstructionMemory
        //Reset - ??
        //Clk - if we need an out from CLKDIV? 
        
        
   // PCAdder(   PCResult, PCAddResult);
   PCAdder PCpl4(PCOut,    PCpl4Out);
        //PCResult - output from PC
        //PCAddResult - output into mux PCSrc inB and PCSEADD 'B' 
        
   // ALU32Bit(     ALUControl, A,        B,      ALUResult,  Zero)    
   ALU32Bit PCSEADD(4'b0000,    PCpl4Out, SL2Out, PCSEADDOut, Zero);
      //ALUControl - 0000
      //A - *** output from (PCpl4) ***
      //B - new 32 bit signal of SE^^ that is <<2
      //ALUResult - [31:0] into next mux
      //Zero - ??? ground???

   //                  out       inA         inB       sel
   Mux32Bit2To1 MPCSrc(PCSrcOut, PCSEADDOut, PCpl4Out, PCSrc);
        // inA - ALUResult of PCSEADD
        // inB - *** output from PC+4 ***
        // sel - PCSrc
              
       
  // RegisterFile(    ReadRegister1, ReadRegister2,  WriteRegister, WriteData,  RegWrite, Clk,   ReadData1, ReadData2);  
  RegisterFile RFMain(RR1,           InsMain[20:16], WR,            ALUMainOut, RegWrite, Clock, RD1,       RD2);
     //ReadRegister1 - output from mux RA
     // ReadRegister2 - Instruction [20:16]
     // WriteRegister - output from mux RD
     // WriteData - output from mux MtR
     // RegWrite - RegWrite
     // Clk - clock
     // ReadData1 - output to mother ALU input A
     // ReadData2 - out to inB of mux ASRC
     
  
  //                out      inA    inB  sel   
  Mux32Bit2To1 ASrc(ASrcOut, SESig, RD2, ALUSrc);
     // inA - new 32 bit signal of SE
     // inB - output of ReadData2 ^^
     // sel - ALUSrc
  
  
  //              out    inA                    inB      sel   
  Mux32Bit2To1 RB(RBOut, {27'b0,InsMain[10:6]}, ASrcOut, RegB);
     // inA - Instruction [10:6]
     // inB - out from mux ASRC
     // sel - RegB
     
      /*** THE ALU OF THE HOUR LADIES AND GENTLEMEN ***/
  
  
  // ALU32Bit(  ALUControl, A,   B,     ALUResult,  Zero)    
  ALU32Bit Main(ALUOp,      RD1, RBOut, ALUMainOut, ALUZero);
    //ALUControl - ALUOp
    //A - ReadData1
    //B - out of mux RB
    //ALUResult - [31:0] into Data Memory
    //Zero - into DataMemory
  
  
     
  // DataMemory( Address,    WriteData, Clk,   MemWrite, MemRead, ReadData);   
  DataMemory DM1(ALUMainOut, RD2,       Clock, MemWrite, MemRead, DMRD);  
  
  //               Output  inA         inB   sel  
  Mux32Bit2To1 MtR(MtROut, ALUMainOut, DMRD, MemtoReg);
    // inA - ALUResult of ALU "Main"
    // inB - ReadData output of DataMemory
    // sel - MemtoReg
  
     
endmodule
