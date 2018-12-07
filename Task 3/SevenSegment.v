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
    always @(numin)
    begin
        //segment a
        segout[6] <=    (numin[3]& numin[1]) |(numin[3]& numin[2]) | 
                        (numin[2]& ~numin[1]& ~numin[0]) | (~numin[3]& ~numin[2]& ~numin[1]& numin[0]);
        
        //segment b
        segout[5] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (numin[2]&~numin[1]&numin[0]) |
                        (numin[2]&numin[1]&~numin[0]);
        
        //segment c
        segout[4] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (~numin[2]&numin[1]&~numin[0]);
        
        //segment d
        segout[3] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (numin[2]&~numin[1]&~numin[0]) | 
                        (~numin[2]&~numin[1]&numin[0]) | (numin[2]&numin[1]&numin[0]);
        
        //segment e
        segout[2] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (~numin[3]&numin[0]) | 
                        (~numin[1]&numin[0]) | (numin[2]&~numin[1]);
       
        //segment f
        segout[1] <=    (numin[3]&numin[2]) | (~numin[2]&numin[1]) | (numin[1]&numin[0]) |
                        (~numin[3]&~numin[2]&numin[0]);
        
        //segment g
        segout[0] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (~numin[3]&~numin[2]&~numin[1])|
                        (numin[2]&numin[1]&numin[0]);
       
    end

endmodule
