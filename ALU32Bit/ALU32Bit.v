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
	input [31:0] A, B;
	output reg [31:0] ALUResult;
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	integer index;
	reg [5:0] count;
	
    always @ (ALUControl, A ,B)
    begin
        
        Zero <= 0;
        count <= 0;
        
        case (ALUControl)
        // ADDITION       | 0000 | ALUResult = A + B
        4'b0000: begin
              ALUResult <= (A + B);
              if (ALUResult == 0)
                Zero <= 1;
        end
    
        // SUBRACTION     | 0001 | ALUResult = A - B
        4'b0001: begin
                ALUResult <= A - B;
                if (ALUResult == 0)
                    Zero <= 1;
        end
              
        // MULTIPLICATION | 0010 | ALUResult = A * B
        4'b0010: begin
                ALUResult <= A*B;
                if (ALUResult == 0)
                    Zero <= 1;
        end
              
        // AND            | 0011 | ALUResult = A and B
        4'b0011: begin
                ALUResult <= (A & B);
                if (ALUResult == 0)
                    Zero <=1;
        end
              
        // OR             | 0100 | ALUResult = A or B
        4'b0100: begin
                ALUResult <= (A | B);
                
                if (ALUResult == 0)
                    Zero <=1;
        end
              
        // SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
        4'b0101: begin
               
                if (A < B)begin
                    ALUResult <= 32'h00000001;
                    Zero <= 0;
                end
                else begin
                    ALUResult <= 32'h00000000;
                    Zero <= 1;
                end
        end
              
        // SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
        4'b0110: begin
                if (A == B) begin
                    ALUResult <= 32'h00000001;
                    Zero <= 0;
                end
                else begin
                    ALUResult <= 32'h00000000;
                    Zero <=1;
                end
        end
              
        // SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
        4'b0111: begin
               if (A != B) begin
                   ALUResult <= 32'h00000001;
                   Zero <= 0;
               end
               else begin
                   ALUResult <= 32'h00000000;
                   Zero <= 1;
               end
        end
        // LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
        4'b1000: begin
            ALUResult <= A << B;
        end
            
        // RIGHT SHIFT    | 1001 | ALUResult = A >> B        (see notes below)
        4'b1001: begin 
            ALUResult <= A >> B;
        end
             
        // ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)
        4'b1010: begin 
            ALUResult <= ((A >> B) | (A << (32-B)));
        end
             
        // COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
        4'b1011: begin
            for (index = 31; index >= 0 && A[index] != 0; index = index - 1) begin
                count = count + 1;
            end
            ALUResult <= count;
        end
              
        // COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
        4'b1100: begin
            for (index = 31; index >= 0 && A[index] != 1; index = index - 1) begin
                count = count + 1;
            end
            ALUResult <= count;
        end
    endcase    
    end
endmodule

