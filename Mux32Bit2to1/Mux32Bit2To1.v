`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - Mux32Bit2To1.v
// Description - Use the sel input signal to choose which 32-bit inputs should be at the output
//              - sel = 1, out = inA
//              - sel = 0, out = inB
//
// Company: University of Arizona - ECE274A - Digital Logic
// Engineer(s): Adrian Bao, Bob Bradford
// Comments: Implementation of 32-bit 2x1 Mux logic shown below 
// Last Edit: 10/27/2018 - Implemented 2x1 Mux logic
//
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(out, inA, inB, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input sel;

    // Output Expression for 2x1 mux: out = (inA & sel) | (inB & !sel)
    always @ (sel, inA, inB) begin
        if (sel)
            out <= inA;
        else
            out <= inB;
    end

endmodule
