`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ProgramCounter.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.

//FUNCTIONALITY: a 32-bit register with a synchronous reset. 
//At the positive edge of the clock, if reset = 1, the 32-bit output is all 0's
//else the output is the 32-bit input

// FUNCTIONALITY (you can skip this paragraph for the first week of lab assignment):-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module. Hence, please add a synchronous 'Reset' 
// signal to your PC register to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(Address, PCResult, Reset, Clk);

	input [31:0] Address;
	input Reset, Clk;

	output reg [31:0] PCResult;

    /* Please fill in the implementation here... */

endmodule

