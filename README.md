# Introduction 
This repo consists of 3 codes. The first code is small but not very efficient for the processor. The second code is the same but with a description about the CPI ( Clock Per Instruction ) and other calculations that are relative to the program's efficiency. Lastly, the third code is a reformat of the first code to help MIPS execute the same instructions but more efficiently using pipeline technology. 

# pipeline
In both cases of the first and third programs's the simulation is using the pipeline technology as default. However, in the case of the third program, we use the pipeline in such a way that we are allowing the processor ( based on the architecture of MIPS with implemented the pipeline technology ) to execute the set of the instructions in our code more efficiently. Execute the instructions more efficiently using pipeline means that the processor, MIPS in our case, is using all its stages ( fetch instruction, decode, execute ) in such a way that we have no delays that are caused by hazards or any other causes that make a stage unavailable in a clock circle of CPU

# Simulator
- [x] WinMips64
