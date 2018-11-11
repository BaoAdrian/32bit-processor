`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
//
//
// Last Edit: Implementation of all 37 Test Cases included below. Tests various
//      cases for all modules within the ALU. Test Case Table included in 
//      documentation.
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
    //case 10
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0010;
    #50;
    //case 11
    A <= 32'hFFFF0000;
    B <= 32'h0000000F;
    ALUControl <=4'b0010;
    #50;
    //case 12
    A <= 32'hFFFFFFFF;
    B <= 32'hFFFFFFFF;
    ALUControl <=4'b0010;
    #50;
    
    //AND
    //case 13
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0011;
    #50;      
    //case 14
    A <= 32'hFFFF0000;
    B <= 32'h0000000F;
    ALUControl <=4'b0011;
    #50;  
    
    
    // OR
    //case 15
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0100;
    #50;      
    //case 16
    A <= 32'hFFFF0000;
    B <= 32'h0000000F;
    ALUControl <=4'b0100;
    #50;   
    
    
    // SET LESS THAN
    //case 17 
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0101;
    #50;      
    //case 18
    A <= 32'h00000112;
    B <= 32'h000003E8;
    ALUControl <=4'b0101;
    #50;    
    //case 19
    A <= 32'hFFFFFFFF;
    B <= 32'hFFFFFFFF;
    ALUControl <=4'b0101;
    #50;    
    
    
    // SET EQUAL TO
    //case 20
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0110;
    #50;      
    //case 21
    A <= 32'hFFFFFFFF;
    B <= 32'hFFFFFFFF;
    ALUControl <=4'b0110;
    #50;    
    
    
    // SET NOT EQUAL TO
    //case 22
    A <= 32'h000003E8;
    B <= 32'h00000112;
    ALUControl <=4'b0111;
    #50;      
    //case 23
    A <= 32'hFFFFFFFF;
    B <= 32'hFFFFFFFF;
    ALUControl <=4'b0111;
    #50;    
    
    
    // SHIFT RIGHT
    //case 24
    A <= 32'h00000FED;
    B <= 32'h00000001;
    ALUControl <=4'b1000;
    #50;    
    //case 25
    A <= 32'h00000FED;
    B <= 32'h0000000A;
    ALUControl <=4'b1000;
    #50;    
    
    
    // SHIFT LEFT
    //case 26
    A <= 32'h00000FED;
    B <= 32'h00000001;
    ALUControl <=4'b1001;
    #50;    
    //case 27
    A <= 32'h00000FED;
    B <= 32'h0000000A;
    ALUControl <=4'b1001;
    #50;    
    
    
    
    // A ROTR B
    //case 28
    A <= 32'h00000FED;
    B <= 32'h00000001;
    ALUControl <=4'b1010;
    #50;    
    //case 29
    A <= 32'h00000FED;
    B <= 32'h0000000A;
    ALUControl <=4'b1010;
    #50;    
    
    
    
    
    
    // COUNT ONES
    //case 30
    A <= 32'b11111111111111111111111111110001;
    B <= 32'b0; // Set to zero, no longer needed
    ALUControl <=4'b1011;
    #50;
    //case 31
    A <= 32'b11111111111111111111111111111111;
    ALUControl <=4'b1011;
    #50;
    //case 32
    A <= 32'b11000000000000000000000000000011;
    ALUControl <=4'b1011;
    #50;
    //case 33
    A <= 32'b00000000000000000000000000000011;
    ALUControl <=4'b1011;
    #50;        
    
    
    // COUNT ZEROS
    //case 34
    A <= 32'b00000000000000000000000000000011;
    ALUControl <=4'b1100;
    #50;
    //case 35
    A <= 32'b00001000000000000000000000000011;
    ALUControl <=4'b1100;
    #50;
    //case 36
    A <= 32'b11000000000000000000000000000011;
    ALUControl <=4'b1100;
    #50;
    //case 37
    A <= 32'b0; // 32 zeros
    ALUControl <=4'b1100;
    #50;    
    
    
    
      
    
    end        

endmodule

