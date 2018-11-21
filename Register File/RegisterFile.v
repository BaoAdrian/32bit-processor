`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Adrian Bao, Bob Bradford

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
input [31:0] WriteData;
input RegWrite, Clk;

output reg [31:0] ReadData1, ReadData2;

reg [31:0] R_Addr [0:31]; // 32x32 Slots for Register

initial begin
    R_Addr[0] <= 32'h0;
end

// Write procedure
always @(posedge Clk) 
begin
    if (RegWrite == 1) begin
        R_Addr[WriteRegister] <= WriteData;
    end
end

// Read procedure
always @(negedge Clk) begin
   
   ReadData1 <= R_Addr[ReadRegister1];
   ReadData2 <= R_Addr[ReadRegister2];
    
end
endmodule

//ballin'
