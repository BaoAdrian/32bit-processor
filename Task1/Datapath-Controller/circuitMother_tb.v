`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 05:56:21 PM
// Design Name: 
// Module Name: circuitMother_tb
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


module circuitMother_tb();

    reg Clk_tb, Rst_tb;
    wire [31:0] Instruction_tb;
    
    circuitMother tb1(Clk_tb, Rst_tb, Instruction_tb);
    
    // Clock Procedure
    always begin
       Clk_tb <= 0;
       #100;
       Clk_tb <= 1;
       #100;
    end
        
       
    initial begin
        
       // Start at initial
       Rst_tb <= 1;
       @ (posedge Clk_tb);
       #100 Rst_tb <= 0;
   
    end

endmodule
