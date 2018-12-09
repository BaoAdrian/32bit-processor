`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ECE274
// Engineer: Adrian Bao, Bob Bradford
// 
// Additional Comments: 
// The circuit containing all the datapath modules for Task 1
// 
//////////////////////////////////////////////////////////////////////////////////


// circuitMother    (Clock, Reset, out7, en_out)
module circuitMother(Clock, Reset, out7, en_out);
    input Clock, Reset;
    
    wire [31:0] Instruction;
    
    //All control signals should be declared as wire.
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite,
             MemtoReg, PCSrc, RegA, RegB;
    wire [3:0] ALUOp;
    wire Zero;
    
    //SL2 zero
    wire SL2Zero;
    
    //wire for PCSEADD zero logic
    wire PCSEADDZero;
    
    // RegisterFile
    wire [4:0] WR, RR1;
    wire [31:0] RD1, RD2;
    wire [31:0] out_Reg23;
    
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
    
    // Two Digit Display
    output [6:0] out7;
    output [3:0] en_out;
    
    wire ClkOut; // For ClkDiv
    
    // Debug Register used to monitor values in Post-Synthesis Functional Simulations
    (* mark_debug = "true" *) wire [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;
   
   
    /* Module Instantiation */
   
   
    // InstructionMemory(Address, Instruction)
    InstructionMemory IM(PCOut,   InsMain);
        // Address - (output of PC)
        // Instruction - (Instruction [31:0])
         
         
    // controller(op,              func,            RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc, RegA, RegB, Zero);
    controller CTR(InsMain[31:26], InsMain[5:0],    RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc, RegA, RegB, ALUZero);

    
    //              out  rt                      rs                      RegA
    Mux32Bit2To1 RA(RR1, {27'b0,InsMain[20:16]}, {27'b0,InsMain[25:21]}, RegA);
        // inA - Instruction [20:16]
        // inB - Instruction [25:21]
        // sel - RegA
    
    
    //              out  rd                      rt                      RegA
    Mux32Bit2To1 RD(WR, {27'b0, InsMain[15:11]}, {27'b0,InsMain[20:16]}, RegDst);
        // inA - Instruction [15:11]
        // inB - Instruction [20:16]
        // sel - RegDst
    
        
   
   // SignExtension(in,            out);     
   SignExtension SE(InsMain[15:0], SESig);
        // in - Instruction[15:0]
        // out - new 32 bit signal
        
   
   // ALU32Bit( ALUControl,    A,        B,       ALUResult,  Zero)    
   ALU32Bit SL2(4'b1000,       SESig,    32'd2,   SL2Out,     SL2Zero);
        //ALUControl - 1000
        //A - *** output from (PC+4) ***
        //B - 32'd2 (32 to stay consistent)
        //Zero - ??? ground???
        
        
   // ProgramCounter(Address,  PCResult, Reset, Clk);
   ProgramCounter PC(PCSrcOut, PCOut,    Reset, ClkOut);
        //Address - out of MuxPCSrc "Instruction"         
        //PCResult - into InstructionMemory
        //Reset - ??
        //Clk - if we need an out from CLKDIV? 
        
        
   // PCAdder(   PCResult, PCAddResult);
   PCAdder PCpl4(PCOut,    PCpl4Out);
        //PCResult - output from PC
        //PCAddResult - output into mux PCSrc inB and PCSEADD 'B' 
        
   // ALU32Bit(     ALUControl, A,        B,      ALUResult,  Zero)    
   ALU32Bit PCSEADD(4'b0000,    PCpl4Out, SL2Out, PCSEADDOut, PCSEADDZero);
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
              
  
  // RegisterFile(ReadRegister1, ReadRegister2,  WriteRegister, WriteData,   RegWrite, Clk,   ReadData1, ReadData2, Debug Regs, out_Reg23); 
  RegisterFile a4(RR1,           InsMain[20:16], WR ,           Instruction, RegWrite, ClkOut,   RD1,       RD2,       debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19, out_Reg23);
       
  // Peviously used RegFile replaced with the debug capable RegFile above 
  // RegisterFile RFMain(RR1,           InsMain[20:16], WR,            Instruction, RegWrite, Clock, RD1,       RD2);
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
  
  
     
  // DataMemory( Address,    WriteData, Clk,    MemWrite, MemRead, ReadData);   
  DataMemory DM1(ALUMainOut, RD2,       ClkOut, MemWrite, MemRead, DMRD);  
  
  //               Output       inA         inB   sel  
  Mux32Bit2To1 MtR(Instruction, ALUMainOut, DMRD, MemtoReg); 
    // inA - ALUResult of ALU "Main"
    // inB - ReadData output of DataMemory
    // sel - MemtoReg
  
  
  
  // ClkDiv  (Clk,   Rst,  ClkOut)      
  ClkDiv CDM1(Clock, 1'b0, ClkOut);
  
  // TwoDigitDisplay(Clk,     Number,          out7, en_out)
  TwoDigitDisplay tdd1(Clock, out_Reg23[15:0], out7, en_out);
     
endmodule
