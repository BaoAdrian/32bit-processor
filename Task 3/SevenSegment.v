`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona - ECE274A - Digital Logic
// Engineer: Adrian Bao
// 
// Create Date: 09/12/2018 01:23:19 PM
// Design Name: 
// Module Name: SevenSegment
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


module SevenSegment(numin, segout);
    input	[3:0] numin;
    output	reg [6:0] segout;//segout[6] - seg_a, segout[5] - seg_b, segout[4] - seg_c,
                          //segout[3] - seg_d, segout[2] - seg_e, segout[1] - seg_f, segout[0] - seg_g

    always @(numin)begin
        
            case(numin)
              4'b0000 : segout <= 7'b0000001;
              4'b0001 : segout <= 7'b1001111;
              4'b0010 : segout <= 7'b0010010;
              4'b0011 : segout <= 7'b0000110;
              4'b0100 : segout <= 7'b1001100;
              4'b0101 : segout <= 7'b0100100;
              4'b0110 : segout <= 7'b0100000;
              4'b0111 : segout <= 7'b0001111;
              4'b1000 : segout <= 7'b0000000;
              4'b1001 : segout <= 7'b0000100;
              default : segout <= 7'b1111111; 
              
              
            endcase
                        
                        
       
    end

endmodule
