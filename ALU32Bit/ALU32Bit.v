`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports a set of arithmetic and 
// logical operaitons. The 'ALUResult' will output the corresponding 
// result of the operation based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal determines the function of the ALU based 
// on the table below. 

// Op|'ALUControl' value  | Description | Notes
// ==========================
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)
// COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
// COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
//
// NOTES:-
// MULTIPLICATION : 32-bit signed multiplication results with 64-bit output.
//                  ALUResult will be set to lower 32 bits of the product value. 
//
// SET LESS THAN : ALUResult is '32'h000000001' if A < B.
// 
// LEFT SHIFT: The contents of the 32-bit "A" input are shifted left, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
// RIGHT SHIFT: The contents of the 32-bit "A" input are shifted right, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
//
// ROTR: logical right-rotate of a word by a fixed number of bits. 
//       The contents of the 32-bit "A" input are rotated right. 
//       The bit-rotate amount is specified by "B".
//	     ((A >> B) | (A << (32-B)))
//
// CLO: Count the number of leading ones in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
// 
// CLZ: Count the number of leading zeros in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
//
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	integer [31:0] index;
	integer [31:0] count;

    /* Please fill in the implementation here... */
    
    always @ (A,B) 
    begin
        
        Zero <=0;
            
        case (ALUControl)
        // ADDITION       | 0000 | ALUResult = A + B
        0000: begin
                ALUResult <= A + B;
                if (ALUResult == 0)
                    Zero <=1;
              end
    
        // SUBRACTION     | 0001 | ALUResult = A - B
        0001: begin
                ALUResult <= A - B;
                if (ALUResult == 0)
                    Zero <=1;
              end
              
        // MULTIPLICATION | 0010 | ALUResult = A * B
        0010: begin
                ALUResult <= A * B;
                if (ALUResult == 0)
                    Zero <=1;
              end
              
        // AND            | 0011 | ALUResult = A and B
        0011: begin
                ALUResult <= (A & B);
                if (ALUResult == 0)
                    Zero <=1;
              end
              
        // OR             | 0100 | ALUResult = A or B
        0100: begin
                ALUResult <= (A | B);
                
                if (ALUResult == 0)
                    Zero <=1;
              end
              
        // SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
        0101: begin
               
                if (A < B)
                    ALUResult <= 32'h00000001;
                    Zero <=1;
              end
              
        // SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
        0110: begin
                if (A == B)
                    ALUResult <= 32'h00000001;
                else
                    Zero <=1;
              end
              
        // SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
        0111: begin
               if (A != B)
                   ALUResult <= 32'h00000001;
               else
                   Zero <=1;
              end
        // LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
        1000: begin
            
            for(index = 0; index < B; index = (index +32'h00000001)) begin 
            ALUResult <= {A[30],A[29],A[28],A[27],A[26],A[25],A[24],A[23],A[22],A[21],
                            A[20],A[19],A[18],A[17],A[16],A[15],A[14],A[13],A[12],A[11],
                            A[10],A[9],A[8],A[7],A[6],A[5],A[4],A[3],A[2],A[1],A[0],0};
                          end
              end
            
        // RIGHT SHIFT    | 1001 | ALUResult = A >> B        (see notes below)
        1001: begin
                
            for(index = 0; index < B; index = (index +32'h00000001)) begin 
            ALUResult <= {0,A[31],A[30],A[29],A[28],A[27],A[26],A[25],A[24],A[23],A[22],A[21],
                            A[20],A[19],A[18],A[17],A[16],A[15],A[14],A[13],A[12],A[11],
                            A[10],A[9],A[8],A[7],A[6],A[5],A[4],A[3],A[2],A[1]};
                         end
             end
             
        // ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)
        1010: begin
                    
            for(index = 0; index < B; index = (index +32'h00000001)) begin 
            ALUResult <= {A[0],A[31],A[30],A[29],A[28],A[27],A[26],A[25],A[24],A[23],A[22],A[21],
                            A[20],A[19],A[18],A[17],A[16],A[15],A[14],A[13],A[12],A[11],
                            A[10],A[9],A[8],A[7],A[6],A[5],A[4],A[3],A[2],A[1]};
                         end
             end
             
        // COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
        1011: begin
            for (index = 5'd31; A[index] == 4'd0001; index = index-1)
                count <= count +1;
            ALUResult <= count;
              end
              
        // COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
        1100: begin
            for (index = 5'd31; A[index] == 4'd0000; index = index-1)begin
                count <= count +1;
                end
            ALUResult <= count;
              end
    end    

endmodule

