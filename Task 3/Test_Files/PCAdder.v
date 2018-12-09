`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - PCAdder.v
// Description - 32-Bit program counter (PC) adder.
// 
// INPUTS:-
// PCResult: 32-Bit input port.
// 
// OUTPUTS:-
// PCAddResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Design an incrementor by 4 
// (a hard-wired ADDER whose first input is from the PCResult, and 
// whose second input is a hard-wired value of 4 that outputs PCResult + 4. 
// The result should always be an increment of the signal 'PCResult' by 4 (i.e., PCAddResult = PCResult + 4).
//
// Company: University of Arizona - ECE274A - Digital Logic
// Engineer(s): Adrian Bao, Bob Bradford
// Comments: Implementation of an adder that adds 4 to given input
// Last Edit: 10/27/2018 - Implemented adder functionality
//
////////////////////////////////////////////////////////////////////////////////

module PCAdder(PCResult, PCAddResult);

    input [31:0] PCResult;

    output reg [31:0] PCAddResult;

    always @ (PCResult) begin
    
        PCAddResult <= PCResult + 32'h00000004; // Add 4 to PCResult
    
    end

endmodule

