# 32bit_Datapath_Controller
32-bit processor with Datapath and Controller designed to support various operations.


<h1> Latest Adjustments </h1>
<ul>

  <li> 10/27/2018 - Modify and implement logic for Mux32Bit2to1, PCAdder, and ProgramCounter Modules. Testbenches included for all of them with their respecitve waveforms produced (Behavioral and Post-Synthesis) included in their folders. </li>
  <li> 10/28/2018 - Modify and implement logic for Sign Extension Module. Testbench ran and verified with included waveforms produced (Behavioral and Post-Synthesis Simulations). </li>
  <li> 11/01/2018 - Implement 32-Bit ALU Logic for various arithmetic operations including: </li>
  <ul>
    <li> ADD/SUB/MULT </li>
    <li> AND/OR </li>
    <li> A&ltB, A==B, A!=B </li>
    <li> Bitwise Shifting: A&lt&ltB, A&gt&gtB </li>
    <li> Bitwise Right Rotation A ROTR B </li>
  </ul>
  <li> 11/09/2018 - Updated ALU32Bit Module and TestBench to include all test cases provided in specifications. The following ALU32Bit Modules were updated: </li>
  <ul>
    <li> MULT </li>
    <li> A << B </li>
    <li> A >> B </li>
    <li> A ROTR B </li>
    <li> CLO </li>
    <li> CLZ </li>
  </ul>
  <li> 11/09/2018 - Implemented TestBench for InstructionMemory and DataMemory Modules with their Post-Synthesis Simulation waveforms included in their respective folders. </li>

</ul>

<br>

<h1> Task0 - DataPath Components Implementation </h1>
<p> Eight DataPath Components implemented including: 32-Bit 2x1 Multiplexor, PCAdder, Program Counter, Sign Extension, 32x32 Register File, 32-Bit ALU with 13 supported operations, Instruction Memory, and Data Memory. </p>

<h3> 32-Bit 2x1 Mux </h3>
<ul>
  <li> The mux takes two 32-Bit inputs and based on the selector (sel) input, will allow either inA or inB to pass through:
    
``` Verilog
      
always @ (sel) begin
  if (sel)
     out <= inA;
  else
     out <= inB;
end
      
```
      
  
  </li>
  <li> Behavioral and Post-Synthesis Functional Simulations yeilded the following waveform: </li>
  <br>
  <img src = "Mux32Bit2to1/32Bit2to1Mux_Waveform.PNG" width = "800" height = "200" hspace = "20" alt = "32-Bit 2x1 Mux Waveform"/>
</ul>
