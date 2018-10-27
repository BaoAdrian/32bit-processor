`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;          // control bits for ALU operation
	reg [31:0] A, B;	          // inputs

	wire [31:0] ALUResult;	        // answer
	wire Zero;	                    // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
    /* Please fill in the implementation here... */
//Use delay of 200 (#200) between the first operation and    //second operation when simulating using post-sysnthesis //functional simulation.
//after that, at least 50 between each change.

	
	end

endmodule

