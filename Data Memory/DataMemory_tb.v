`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

	initial begin
	
        MemWrite <= 1;
        MemRead <= 0;
        Address <= 32'h00000000;
        WriteData <= 32'h12345678;
        
        @ (posedge Clk)
        #50;
        
	    Address <= 32'h00000004;
	    WriteData <= 32'habcdef98;
	    
	    @ (posedge Clk)
	    #50;
	    
	    Address <= 32'h00000008;
	    WriteData <= 32'hffffffff;
	    
	    @ (posedge Clk)
	    #50;
	    
	    MemWrite <= 0;
	    MemRead <= 1;
	    
	    Address <= 32'h00000000;
	    WriteData <= 32'h00000000;
	    
	    @ (posedge Clk)
	    #50;
	    
	    Address <= 32'h0000008;
	
	end

endmodule

