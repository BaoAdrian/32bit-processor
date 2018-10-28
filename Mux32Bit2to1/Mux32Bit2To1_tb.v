`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - Mux32Bit2To1_tb.v
// Description - Test the 32-bit 2 to 1 Mux module.
//
// Company: University of Arizona - ECE274A - Digital Logic
// Engineer(s): Adrian Bao, Bob Bradford
// Comments: Implementation of an Mux Testbench.
// Last Edit: 10/27/2018 - Implemented 4 test cases to test the 32-bit Mux module
//
////////////////////////////////////////////////////////////////////////////////
module Mux32Bit2To1_tb();

	reg	[31:0] inA;
	reg	[31:0] inB;
	reg	sel;
    
	wire [31:0]	out;

	Mux32Bit2To1 u0(
        .out(out), 
        .inA(inA), 
        .inB(inB), 
        .sel(sel)
    );
        
	initial begin

        #100 inA <= 32'h00000001; inB <= 32'h00000002; sel <= 1'b0;
        #20 $display("sel=%h, out=%h", sel, out);

        #100 inA <= 32'h00000001; inB <= 32'h00000002; sel <= 1'b1;
        #20 $display("sel=%h, out=%h", sel, out);
        
        #100 inA <= 32'hF0000001; inB <= 32'hF0000002; sel <= 1'b0;
        #20 $display("sel=%h, out=%h", sel, out);

        #100 inA <= 32'hF0000001; inB <= 32'hF0000002; sel <= 1'b1;
        #20 $display("sel=%h, out=%h", sel, out);
        
	end

endmodule
