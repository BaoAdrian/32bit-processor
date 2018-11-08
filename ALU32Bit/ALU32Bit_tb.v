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

	
    /* Please fill in the implementation here... */
//Use delay of 200 (#200) between the first operation and    //second operation when simulating using post-sysnthesis //functional simulation.
//after that, at least 50 between each change.

		


ALU32Bit ALU32Bit_tb(ALUControl, A, B, ALUResult, Zero);

         
    initial begin
    #20;
    
    //Addition
    //case 1
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0000;
    #200;
    //case 2
    A <= 32'hffff0000;
    B <= 32'h1000000f;
    ALUControl <=4'b0000;
    #50;
    //case 3
    A <= 32'hffffffff;
    B <= 32'h00000001;
    ALUControl <=4'b0000;
    #50;
    //case 4
    A <= 32'hffffffff;
    B <= 32'hffffffff;
    ALUControl <=4'b0000;
    #50;
    
    //Subtraction
    //case 5
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0001;
    #50;
    //case 6
    B <= 32'h000003E8;
    A <= 32'h00000112;
    ALUControl <=4'b0001;
    #50;
    //case 7
    A <= 32'hffff0000;
    B <= 32'h0000000f;
    ALUControl <=4'b0001;
    #50;
    //case 8
    A <= 32'hffffffff;
    B <= 32'h00000001;
    ALUControl <=4'b0001;
    #50;
    //case 9
    A <= 32'hffffffff;
    B <= 32'hffffffff;
    ALUControl <=4'b0001;
    #50;
    
    //Multiplication
    //case 
    A <= 32'h0000038e;
    B <= 32'h00000112;
    ALUControl <=4'b0010;
    #50;
    
    
    end        

endmodule



