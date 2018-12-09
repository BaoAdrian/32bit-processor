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
//    always @(numin)
//    begin
//        //segment a
//        segout[6] <=    (numin[3]& numin[1]) |(numin[3]& numin[2]) | 
//                        (numin[2]& ~numin[1]& ~numin[0]) | (~numin[3]& ~numin[2]& ~numin[1]& numin[0]);
        
//        //segment b
//        segout[5] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (numin[2]&~numin[1]&numin[0]) |
//                        (numin[2]&numin[1]&~numin[0]);
        
//        //segment c
//        segout[4] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (~numin[2]&numin[1]&~numin[0]);
        
//        //segment d
//        segout[3] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (numin[2]&~numin[1]&~numin[0]) | 
//                        (~numin[2]&~numin[1]&numin[0]) | (numin[2]&numin[1]&numin[0]);
        
//        //segment e
//        segout[2] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (~numin[3]&numin[0]) | 
//                        (~numin[1]&numin[0]) | (numin[2]&~numin[1]);
       
//        //segment f
//        segout[1] <=    (numin[3]&numin[2]) | (~numin[2]&numin[1]) | (numin[1]&numin[0]) |
//                        (~numin[3]&~numin[2]&numin[0]);
        
//        //segment g
//        segout[0] <=    (numin[3]&numin[1]) | (numin[3]&numin[2]) | (~numin[3]&~numin[2]&~numin[1])|
//                        (numin[2]&numin[1]&numin[0]);
       
//    end

always @(numin)
    begin
        //segment a
        /*segout[6] <=    numin[0]&(numin[1]&~numin[2]&numin[3] | ~numin[1]&numin[2]&~numin[3]) |
                        numin[2]&~numin[3]&(~numin[1]&~numin[3] | numin[1]&numin[3]) | numin[2]&numin[3];
        // seg b
        segout[5] <=    numin[1]&~numin[2]&numin[3] | numin[2]&~numin[3]&(~numin[0]&numin[1] | ~numin[0]&numin[1]) |
                        numin[2]&numin[3];
        // seg c
        segout[4] <=    ~numin[0]&numin[1]&(~numin[2]&~numin[3] | ~numin[2]&numin[3]) | numin[0]&numin[1]&~numin[2]&numin[3] |
                        numin[2]&numin[3];
        //seg d
        segout[3] <=    ~numin[2]&(numin[0]&~numin[1]&~numin[3] | ~numin[0]&numin[1]&numin[3]) |
                        numin[0]&numin[1]&(~numin[2]&numin[3] | numin[2]&~numin[3]) | numin[2]&numin[3];
        //seg e
        segout[2] <=    numin[2]&~numin[3]&(numin[0] | ~numin[0]&~numin[1]) | numin[2]&numin[3] |
                        ~numin[2]&numin[3]&(numin[1]|numin[0]&~numin[1]);
        //seg f
        segout[1] <=    ~numin[2]&~numin[3]&(numin[0] | ~numin[0]&numin[1]) |
                        numin[2]&numin[3] | numin[2]&numin[3] | numin[0]&numin[1]&(~numin[2]&numin[3] |
                         numin[2]&~numin[3]) | ~numin[0]&numin[1]&~numin[2]&numin[3];
        //seg g 
        segout[0] <=    ~numin[3]&(~numin[1]&~numin[2] | numin[0] & numin[1] &numin[2]) | 
                        numin[1]&(~numin[0]&~numin[2]&numin[3]|numin[0]&numin[2]&~numin[3]) | numin[2]&numin[3];*/
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
