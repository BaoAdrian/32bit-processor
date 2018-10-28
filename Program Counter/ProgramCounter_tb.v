`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ProgramCounter_tb.v
// Description - Test the 'ProgramCounter.v' module.
//
//  
// Company: University of Arizona - ECE274A - Digital Logic
// Engineer(s): Adrian Bao, Bob Bradford
// Comments: This testbench was created to test the functionality of the 
//      Program Counter module.
// 
// Last Edit: 10/27/2018 - Implement 3 test cases to test Program Counter Module
//
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    integer i;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

	initial begin
	
        ///////////////////////////////////////////////////////////////////////
        // Test Case 1: Behavior when Rst == 1 and a 32-bit input is passed  //
        //   Steps: - Set Address to a 32-bit value.                         //
        //          - Set Reset to 1                                         //
        //          - Continue for one Clk Cycle                             //
        //                                                                   //
        //   Expected Behavior: Since Rst is ON, the address will not be     //
        //      be saved into PCResult.                                      //
        ///////////////////////////////////////////////////////////////////////
        Address <= 32'h0000FFFF;
        Reset <= 1'b1;
        @ (posedge Clk);




        ///////////////////////////////////////////////////////////////////////
        // Test Case 2: Rst == 0 and the Address from above is then accepted //
        //   Steps: - Set Address to a NEW 32-bit value.                     //
        //          - Set Reset to 0                                         //
        //          - Continue for two Clk Cycle                             //
        //                                                                   //
        //   Expected Behavior: Since the Address was changed BEFORE setting //
        //      Reset to 0, the previous Address is wiped, now replaced with //
        //      this one and is then saved as PCResult for two Clk Cycles    //
        ///////////////////////////////////////////////////////////////////////
        Address <= 32'h00002222; 
        #10 Reset <= 1'b0;
        @ (posedge Clk);
        @ (posedge Clk);


        ///////////////////////////////////////////////////////////////////////
        // Test Case 3: Rst == 0, Address is then changed, then Rst == 1,    // 
        //   Steps: - Set Address to another NEW 32-bit value                //
        //          - Note: Reset is still 0 (OFF)                           //
        //          - Continue for one Clk Cycle                             //
        //          - Set Reset to 1 (ON)                                    //
        //          - Set Address to another NEW 32-bit value                //
        //                                                                   //
        //   Expected Behavior: Since Reset is still 0(OFF), the new Address //
        //      is saved into PCResult for 1 Clk Cycle. Then when Reset is   //
        //      set back to 1 (ON), then the Address is wiped and the new    //
        //      Address that was entered is not saved                        //
        ///////////////////////////////////////////////////////////////////////
        Address <= 32'h00000027; // Will be stored for one Clk Cycle
        @ (posedge Clk);
        #10 Reset <= 1'b1;
        Address <= 32'hFFFFFFFF; // Will not be stored since Reset is now 1.               
        	
	end

endmodule

