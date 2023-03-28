.data

size:     .word 16
.space 8
 arrayA:  .word 2,-2, 4,-4, 6,-6, 8,-8,-9, 9,-7, 7,-5, 5,-3, 3
.space 8
 arrayB:  .word 8, 7, 6, 5, 4, 3, 2, 1,-1,-2,-3,-4,-5,-6,-7,-8
.space 8 
arrayAM:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.space 8
arrayBM:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


    .text
main:
   daddi  R1, R0,size       # Store the address of size in R1.
   daddi  R2, R0,arrayA     # Store the address of A[i] in R2.
   daddi  R3, R0,arrayB     # Store the address of B[i] in R3.
   lw     R1, 0(R1)         # Load the size in R1.
   daddi  R6, R0,arrayAM    # Base address for AM[i].
   daddi  R7, R0,arrayBM    # Base address for BM[i].
   dsll   R1, R1,3          # Translate the size into the addresses.
   dadd   R4, R1,R2         # Find the last address of A[].
   dadd   R5, R1,R3         # Find the last address of B[].
   dadd   R8, R0,R2         # Store address of A[j] in R8.      
   dadd   R9, R0,R3         # Store address of B[j] in R9.
Loop_i:
   lw     R10, 0(R2)        # Get the value of A[i].
   lw     R11, 0(R3)        # Get the value of B[i].
Loop_j:
   lw     R13, 0(R9)        # Get the value of B[j].
   lw     R14, 0(R6)        # Get the value of AM[i].
   dmul   R16, R10,R13      # Multiple A[i] and B[j] and store it in R16.
   lw     R15, 0(R7)        # Get the value of BM[i]. [Changed]
   slt    R17, R14,R16      # if AM[i] < (A[i] * B[j]).
   lw     R12, 0(R8)        # Get the value of A[j]. [Changed]
   beq    R17, R0,false_am  # Check if the above statement is true or false.
   sw     R16, 0(R6)        # if the statement is true, then store the value in the AM[i].
false_am:                   # if the statemnt is false, then continue.
   dmul   R18, R12,R11      # Multiple A[j] and B[i] and store it in R18.
   lw     R20, 8(R8)        # Get the value of A[j + 1]. [Changed]
   slt    R19, R15,R18      # if BM[i] < A[j]*B[i].
   lw     R21, 8(R9)        # Get the value of B[j + 1]. [Changed]
   beq    R19, R0, false_amm# Check if the above statement is true or false.
   sw     R18, 0(R7)        # if the statement is true, then store the value in the BM[i].
false_amm:                  # if the statemnt is false, then continue.
   lw     R22, 0(R6)        # Get the value of AM[i].
   dmul   R24, R10,R21      # Multiple A[i] and B[j + 1] and store it in R24.
   lw     R23, 0(R7)        # Get the value of BM[i]. [Changed]
   slt    R25, R22,R24      # if AM[i] < (A[i] * B[j + 1]).
   dmul   R26, R20,R11      # Multiple A[j + 1] and B[i] and store it in R26. [Changed]
   beq    R25, R0,false_2   # Check if the above statement is true or false.
   sw     R24, 0(R6)        # if the statement is true, then store the value in the AM[i].
false_2:                    # if the statemnt is false, then continue.
   slt    R27, R23,R26      # if BM[i] < A[j + 1]*B[i].
   nop
   beq    R27, R0, false_a2 # Check if the above statement is true or false.
   sw     R26, 0(R7)        # if the statement is true, then store the value in the BM[i].
false_a2:                   # if the statemnt is false, then continue.
   daddi  R8, R8, 16        # Increace the A[j] addresses.
   daddi  R9, R9, 16        # Increase the B[j] addresses.
   bne    R8, R4, Loop_j    # if j < n.
   daddi  R8, R0, arrayA    # A[j].
   daddi  R9, R0, arrayB    # B[j].
   daddi  R2, R2, 8         # increase the A[i].
   daddi  R3, R3, 8         # increase the B[i].
   daddi  R6, R6, 8         # increase the AM[i].
   daddi  R7, R7, 8         # increase the BM[i].
   bne    R2, R4, Loop_i    # if i < n.
   halt