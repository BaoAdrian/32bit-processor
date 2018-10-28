`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - PCAdder_tb.v
// Description - Test the 'PCAdder.v' module.
//
// Company: University of Arizona - ECE274A - Digital Logic
// Engineer(s): Adrian Bao, Bob Bradford
// Comments: Implementation of an 32-bit Adder TestBench.
// Last Edit: 10/27/2018 - Implemented 6 Test Case to test the functionality
//      of the 32-bit Adder. Includes 0xFFFFFFFC as stated in specifications.
//
////////////////////////////////////////////////////////////////////////////////

module PCAdder_tb();

    reg [31:0] PCResult;

    wire [31:0] PCAddResult;

    PCAdder u0(
        .PCResult(PCResult), 
        .PCAddResult(PCAddResult)
    );

	initial begin
    
    #100 PCResult <= 32'h00000007;
    #20 $display("Result: %h", PCAddResult); 
        
	#100 PCResult <= 32'h000003E8;
	#20 $display("Result: %h", PCAddResult);
	
	#100 PCResult <= 32'hFFFF0000;
    #20 $display("Result: %h", PCAddResult);
	
	#100 PCResult <= 32'h00000112;
    #20 $display("Result: %h", PCAddResult);
    
	#100 PCResult <= 32'hFFFFFFFC;
    #20 $display("Result: %h", PCAddResult);    
    	
	#100 PCResult <= 32'hFFFFFFFD;
    #20 $display("Result: %h", PCAddResult);
	
	end

endmodule

