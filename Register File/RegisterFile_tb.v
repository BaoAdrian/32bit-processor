`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

	initial begin
	
	    ReadRegister1   <= 5'b0;       //reading from Reg0
        ReadRegister2   <= 5'b0;
        
        @(posedge Clk); 
        ReadRegister1   <= 5'b0111;     //reading from Reg7 
                                        //In Behavioral simulation, doyou see xxxx in the waveform of ReadData1?
                                        //If yes, do you know why? 
                                        //In post-synthesis functional simulation, do you still see xxx?   
        #5;
        RegWrite        <= 5'd1;           
        WriteRegister   <= 0;               //Reg0
        WriteData       <= 32'hABCDEF98;    //writing 32'hABCDEF98 to Reg0
        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd8;           //writing 32'h0ECE274a to Reg8
        WriteData       <= 32'h0ECE274a;

        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'h15;          //writing 32'h00000014 to Reg21 (15 in hexadecimal)
        WriteData       <= 32'h00000014;
        
        @(posedge Clk); 
        #5;     
        WriteRegister   <= 5'h1F;          //writing 1000 in decimal to Reg31
        WriteData       <= 32'd1000;
        
        @(posedge Clk); 
        #10;        
        RegWrite        <= 0;
        
        ReadRegister1   <= 0;           //using port 1 to read Reg0
        ReadRegister2   <= 8;          //using port 2 to read Reg8
        
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 21;          //using port 1 to read Reg21
        ReadRegister2   <= 31;          //using port 2 to read Reg31
	
	end

endmodule
