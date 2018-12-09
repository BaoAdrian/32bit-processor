`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//// Last Edits: Adrian Bao, Bob Bradford

//// Module - register_file.v
//// Description - Implements a register file with 32 32-Bit wide registers.
////                          (a 32x32 regsiter file with two read ports and one write port)
//// INPUTS:-
//// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
////                output port 'ReadRegister1'.
//// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
////                output port 'ReadRegister2'.
//// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
////                input port 'WriteRegister'.
//// WriteData: 32-Bit write input port.
//// RegWrite: 1-Bit control input signal.
////
//// OUTPUTS:-
//// ReadData1: 32-Bit registered output. 
//// ReadData2: 32-Bit registered output. 
////
//// FUNCTIONALITY:-
//// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
//// registers simultaneously. The two 32-bit data sets are available on ports 
//// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
//// registered outputs (output of register file is written into these registers 
//// at the falling edge of the clock). You can view it as if outputs of registers
//// specified by ReadRegister1 and ReadRegister2 are written into output 
//// registers ReadData1 and ReadData2 at the falling edge of the clock. 
////
//// 'RegWrite' signal is high during the rising edge of the clock if the input 
//// data is to be written into the register file. The contents of the register 
//// specified by address 'WriteRegister' in the register file are modified at the 
//// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
//// the register file are positive-edge (rising-edge) triggered. (You have to use 
//// this information to generate the write-clock properly.) 
////
//// NOTE:-
//// We will design the register file such that the contents of registers do not 
//// change for a pre-specified time before the falling edge of the clock arrives 
//// to allow for data multiplexing and setup time.
//////////////////////////////////////////////////////////////////////////////////

//--// Notice the addtional signals below //--//

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19, out_Reg23);

	
    input Clk;
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    input RegWrite;
    input [31:0]  WriteData;
    
    output reg [31:0] ReadData1, ReadData2;

    //--// below is for post-synthesis simulation //--//

    output [31:0] debug_Reg8, debug_Reg16, debug_Reg17,    
    debug_Reg18, debug_Reg19;
    
    output reg [31:0] out_Reg23;

   (* mark_debug = "true" *) reg [31:0] R_Addr [0:31];
 	
	
   //////////////////////////////////////////////////
   initial begin
       R_Addr[0] <= 32'd0;
       R_Addr[1] <= 32'd0;
       R_Addr[2] <= 32'd0;
       R_Addr[3] <= 32'd0;
       R_Addr[4] <= 32'd0;
       R_Addr[5] <= 32'd0;
       R_Addr[6] <= 32'd0;
       R_Addr[7] <= 32'd0;
       R_Addr[8] <= 32'd0;
       R_Addr[9] <= 32'd0;
       R_Addr[10] <= 32'd0;
       R_Addr[11] <= 32'd0;
       R_Addr[12] <= 32'd0;
       R_Addr[13] <= 32'd0;
       R_Addr[14] <= 32'd0;
       R_Addr[15] <= 32'd0;
       R_Addr[16] <= 32'd0;
       R_Addr[17] <= 32'd0;
       R_Addr[18] <= 32'd0;
       R_Addr[19] <= 32'd0;
       R_Addr[20] <= 32'd0;
       R_Addr[21] <= 32'd0;
       R_Addr[22] <= 32'd0;
       R_Addr[23] <= 32'd0;
       R_Addr[24] <= 32'd0;
       R_Addr[25] <= 32'd0;
       R_Addr[26] <= 32'd0;
       R_Addr[27] <= 32'd0;
       R_Addr[28] <= 32'd0;
       R_Addr[29] <= 32'd0;
       R_Addr[30] <= 32'd0;
       R_Addr[31] <= 32'd0;
   end
   
   // Write procedure
   always @ (posedge Clk)
   begin
       if (RegWrite == 1) begin
           R_Addr[WriteRegister] <= WriteData;
       end
   end
   
   // Read procedure
   always @ (negedge Clk) begin
      out_Reg23 <= R_Addr[23];
      ReadData1 <= R_Addr[ReadRegister1];
      ReadData2 <= R_Addr[ReadRegister2];
       
   end
   ///////////////////////////////////////////////////
		

    //below is for post-synthesis simulation
    assign debug_Reg8 = R_Addr[8];
    assign debug_Reg16 = R_Addr[16];
    assign debug_Reg17 = R_Addr[17];
    assign debug_Reg18 = R_Addr[18];
    assign debug_Reg19 = R_Addr[19];


endmodule
