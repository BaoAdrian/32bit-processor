`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your processor.
//
//
//we will store the machine code for a C function later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
   //Create 2D array for memory with 128 32-bit elements here
        reg [31:0] memory [0:127];
        
        
        initial begin                   //need to iniitalize this for the code!!!
//            memory[0] = 32'h2010000e;    //    main:   addi   $s0, $zero, 14                  #so = RegFile[16] = 14  (0+14)
//            memory[1] = 32'h2011000f;    //        addi    $s1, $zero, 15               #s1 = RegFile[17] = 15  (0+15)
//            memory[2] = 32'h2012001d;    //        addi    $s2, $zero, 29               #s2 = RegFile[18] = 29  (0+29)
//            memory[3] = 32'h2013fff1;    //        addi    $s3, $zero, -15              #s3 = RegFile[19] = -15 (0+-15)
//            memory[4] = 32'h02324020;    //        add     $t0, $s1, $s2                #t0 = RegFile[8] = 44  (15+29)
//            memory[5] = 32'h02504024;    //        and     $t0, $s2, $s0                #t0 = 12  (29 AND 14 => 11101 AND 01110 = 01100 = 12)
//            memory[6] = 32'h72114002;    //        mul     $t0, $s0, $s1                #t0 = 210 (14*15)
//            memory[7] = 32'h02504025;    //        or      $t0, $s2, $s0                #t0 = 31  (29 OR 14 => 11101 OR 01110 = 11111 = 31) 
//            memory[8] = 32'h36080010;    //        ori     $t0, $s0, 16                 #t0 = 30  (14 OR 16 = 01110 OR 10000 = 11110 = 30)
//            memory[9] = 32'h02124022;    //        sub     $t0, $s0, $s2                #t0 = -15 (14-29)  
//            memory[10] = 32'h72604021;    //        clo    $t0, $s3                     #t0 = 28  (count leading 1 of s3 = -15 =  1111 1111 1111 1111 1111 1111 1111 0001)
//            memory[11] = 32'h72404020;    //        clz    $t0, $s2                     #t0 = 27  (count leading 0 of s2 = 29 = 0000 0000 0000 0000 0000 0000 0001 1101)
//            memory[12] = 32'h0211402a;    //        slt    $t0, $s0, $s1                #t0 = 1
//            memory[13] = 32'h0230402a;    //        slt    $t0, $s1, $s0                #t0 = 0
//            memory[14] = 32'h00114080;    //        sll    $t0, $s1, 2                  #t0 = 60  (15*4)
//            memory[15] = 32'h001240c2;    //        srl    $t0, $s2, 3                  #t0 = 3   (29/8)

            memory[0] = 32'h34090000;	//	main:	ori	$t1, $zero, 0
            memory[1] = 32'h2012001d;	//		addi	$s2, $zero, 29
            memory[2] = 32'h2013000c;	//		addi	$s3, $zero, 12
            memory[3] = 32'had320004;	//		sw	$s2, 4($t1)
            memory[4] = 32'had330008;	//		sw	$s3, 8($t1)
            memory[5] = 32'h8d280004;	//		lw	$t0, 4($t1)
            memory[6] = 32'h8d280008;	//		lw	$t0, 8($t1)
            memory[7] = 32'h15120002;	//		bne	$t0, $s2, label1
            memory[8] = 32'h00004020;	//		add	$t0, $zero, $zero
            memory[9] = 32'h2008000c;	//		addi	$t0, $zero, 12
            memory[10] = 32'h15130001;	//	label1:	bne	$t0, $s3, label2
            memory[11] = 32'h20080001;	//		addi	$t0, $zero, 1
            memory[12] = 32'h2008001d;	//	label2:	addi	$t0, $zero, 29
           
        end
        
        always @ * begin
            Instruction <= memory[Address[8:2]];    
        end
        
        
    endmodule
