`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Adrian Bao, Bob Bradford
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

//begin assignment Write
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd9;           //writing 32'h00002222 to Reg9
        WriteData       <= 32'h00002222;
        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd10;           //writing 32'h00002525 to Reg10
        WriteData       <= 32'h00002525;
        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd11;           
        WriteData       <= 32'h00003333;
                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd12;           
        WriteData       <= 32'h00003535;
        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd13;          
        WriteData       <= 32'h0000aaaa;
                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd14;           
        WriteData       <= 32'h0000a123;
                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd15;           
        WriteData       <= 32'h0000bbbb;
                        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd16;           
        WriteData       <= 32'h0000b123;
        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd17;           
        WriteData       <= 32'h0000f123;
                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd18;           
        WriteData       <= 32'h0000ff85;
                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd19;           
        WriteData       <= 32'h000085ff;
                        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd20;           
        WriteData       <= 32'h0000123f;
                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd21;          
        WriteData       <= 32'h0000ffee;
                        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd22;           
        WriteData       <= 32'h0000e12f;
                        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd23;           
        WriteData       <= 32'h00001e2f;
                                
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd24;           
        WriteData       <= 32'hf1e2ffff;
        
        @(posedge Clk); 
        #5;
        WriteRegister   <= 5'd25;           
        WriteData       <= 32'h2f1effff;
//end assignment Write 
               
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
        
//begin assignment Read
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 9;          
        ReadRegister2   <= 10;        
        
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 11;          
        ReadRegister2   <= 12;
        
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 13;          
        ReadRegister2   <= 14;        
              
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 15;          
        ReadRegister2   <= 16;
        
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 17;          
        ReadRegister2   <= 18;        
               
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 19;          
        ReadRegister2   <= 20;
                
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 21;          
        ReadRegister2   <= 22;        
                      
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 23;          
        ReadRegister2   <= 24;
        
        @(posedge Clk);
        #10; 
        ReadRegister1   <= 25;          
        ReadRegister2   <= 8;        //0ece274a
                
	end

endmodule
