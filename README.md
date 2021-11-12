# Introduction 
This repo consists of 3 codes. The first code is small but not very efficient for the processor. The second code is the same but with a description about the <b>CPI ( Clock Per Instruction )</b> and other calculations that are relative to the program's efficiency. Lastly, the third code is a reformat of the first code to help <b>MIPS</b> execute the same instructions but more efficiently using <b>pipeline technology</b>. 

# pipeline
In both cases of the first and third programs's the simulation is using the <b>pipeline technology</b> as default. However, in the case of the third program, we wrote our code in such a way that we are allowing the processor ( based on the architecture of <b>MIPS</b> with implemented the <b>pipeline technology</b> ) to execute the set of the instructions in our code more efficiently. Execute the instructions more efficiently using <b>pipeline</b> means that the processor, <b>MIPS</b> in our case, is using all its <b>stages</b> ( <b>fetch instruction</b>, <b>decode</b>, <b>execute</b> ) in such a way that we have no delays that are caused by <b>hazards</b> or any other causes that makes a <b>stage</b> unavailable in a <b>clock circle</b> of <b>CPU</b>.

# Simulator
- [x] WinMips64
