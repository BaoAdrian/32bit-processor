`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2018 12:34:08 PM
// Design Name: 
// Module Name: TopLevel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TopLevel(Clock, Reset, out7, en_out);

    input Clock, Reset;
    output [6:0] out7;
    output [3:0] en_out;
    
    wire ClkOut; // For ClkDiv
    
    ClkDiv CDM1(Clock, 1'b0, ClkOut);
    
    //wire Instruction; // Just Ground, not needed in top level
    wire [15:0] out_Reg23;
    
    // circuitMother  (Clock, Reset, Instruction, out_Reg23);
    //circuitMother CMM1(ClkOut, Reset, Instruction, out_Reg23);
    circuitMother CMM1(ClkOut, Reset, out_Reg23);
    
    // TwoDigitDisplay(Clk, Number, out7, en_out)
    TwoDigitDisplay tdd1(Clock, out_Reg23[15:0], out7, en_out);
    
    

endmodule
