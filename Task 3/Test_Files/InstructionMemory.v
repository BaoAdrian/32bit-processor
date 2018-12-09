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

//            memory[0] = 32'h34090000;	//	main:	ori	$t1, $zero, 0
//            memory[1] = 32'h2012001d;	//		addi	$s2, $zero, 29
//            memory[2] = 32'h2013000c;	//		addi	$s3, $zero, 12
//            memory[3] = 32'had320004;	//		sw	$s2, 4($t1)
//            memory[4] = 32'had330008;	//		sw	$s3, 8($t1)
//            memory[5] = 32'h8d280004;	//		lw	$t0, 4($t1)
//            memory[6] = 32'h8d280008;	//		lw	$t0, 8($t1)
//            memory[7] = 32'h15120002;	//		bne	$t0, $s2, label1
//            memory[8] = 32'h00004020;	//		add	$t0, $zero, $zero
//            memory[9] = 32'h2008000c;	//		addi	$t0, $zero, 12
//            memory[10] = 32'h15130001;	//	label1:	bne	$t0, $s3, label2
//            memory[11] = 32'h20080001;	//		addi	$t0, $zero, 1
//            memory[12] = 32'h2008001d;	//	label2:	addi	$t0, $zero, 29
           
           
        memory[0] = 32'h34070000;	//	main:		ori	$a3, $zero, 0
        memory[1] = 32'h8ce70000;	//			lw	$a3, 0($a3)
        memory[2] = 32'h34040004;	//			ori	$a0, $zero, 4
        memory[3] = 32'h34054004;	//			ori	$a1, $zero, 16388
        memory[4] = 32'h34068004;	//			ori	$a2, $zero, 32772
        memory[5] = 32'h34100000;	//			ori	$s0, $zero, 0
        memory[6] = 32'h34110000;	//	L1:		ori	$s1, $zero, 0
        memory[7] = 32'h34120000;	//	L2:		ori	$s2, $zero, 0
        memory[8] = 32'h34160000;	//			ori	$s6, $zero, 0
        memory[9] = 32'h36f70000;	//			ori	$s7, $s7, 0
        memory[10] = 32'h72074002;	//	inner:		mul	$t0, $s0, $a3
        memory[11] = 32'h01124820;	//			add	$t1, $t0, $s2
        memory[12] = 32'h00094880;	//			sll	$t1, $t1, 2
        memory[13] = 32'h00895020;	//			add	$t2, $a0, $t1
        memory[14] = 32'h8d530000;	//			lw	$s3, 0($t2)
        memory[15] = 32'h72474002;	//			mul	$t0, $s2, $a3
        memory[16] = 32'h01114820;	//			add	$t1, $t0, $s1
        memory[17] = 32'h00094880;	//			sll	$t1, $t1, 2
        memory[18] = 32'h01255020;	//			add	$t2, $t1, $a1
        memory[19] = 32'h8d540000;	//			lw	$s4, 0($t2)
        memory[20] = 32'h7274a802;	//			mul	$s5, $s3, $s4
        memory[21] = 32'h02d5b020;	//			add	$s6, $s6, $s5
        memory[22] = 32'h22520001;	//			addi	$s2, $s2, 1
        memory[23] = 32'h1647fff2;	//			bne	$s2, $a3, inner
        memory[24] = 32'h72074002;	//			mul	$t0, $s0, $a3
        memory[25] = 32'h01114820;	//			add	$t1, $t0, $s1
        memory[26] = 32'h00094880;	//			sll	$t1, $t1, 2
        memory[27] = 32'h01265020;	//			add	$t2, $t1, $a2
        memory[28] = 32'had560000;	//			sw	$s6, 0($t2)
        memory[29] = 32'h02c0b825;	//			or	$s7, $s6, $zero
        memory[30] = 32'h22310001;	//			addi	$s1, $s1, 1
        memory[31] = 32'h1627ffe7;	//			bne	$s1, $a3, L2
        memory[32] = 32'h22100001;	//			addi	$s0, $s0, 1
        memory[33] = 32'h1607ffe4;	//			bne	$s0, $a3, L1
        memory[34] = 32'h34100001;	//			ori	$s0, $zero, 1
        memory[35] = 32'h34110002;	//			ori	$s1, $zero, 2
        memory[36] = 32'h1611ffff;	//	endhere1:	bne	$s0, $s1, endhere1
        memory[36] = 32'h00000000;	//           
           
        end
        
        always @ * begin
            Instruction <= memory[Address[8:2]];    
        end
        
        
    endmodule
