.data
n_size:  .word 16
.space 8
array_a: .word 2,-2, 4,-4, 6,-6, 8,-8,-9, 9,-7, 7,-5, 5,-3, 3
.space 8
array_b: .word 8, 7, 6, 5, 4, 3, 2, 1,-1,-2,-3,-4,-5,-6,-7,-8


.text
main:
    daddi R1, R0, n_size      # Store the base address of n_size in R1.
    daddi R2, R0, array_a     # Store the base address of array_a in R2.
    daddi R3, R0, array_b     # Store the base address of array_b in R3.
    lw    R1, 0(R1)           # Load the value of n_size in R1.
    dsll  R1, R1, 3           # Translate the n_size to n addresses and store it in R1.
    dadd  R4, R2, R1          # Find the last address of array_a and store it in R4.
    dadd  R5, R3, R1          # Find the last address of array_b and store it in R5.
    dadd  R6, R0, R2          # Address to look for A[j].
    dadd  R7, R0, R3          # Address to look for B[i].
    daddi R8, R4, 8           # Base address for AM[].
    dadd  R9, R8, R1          # Last address of AM[].
    daddi R9, R9, 8           # Base address for BM[].
    loop_i:
    lw    R10, 0(R2)          # Get the value of A[i] and store it in R10.
    lw    R11, 0(R7)          # Get the value of B[i] and store it in R11.
    loop_j:
    lw    R12, 0(R8)          # Get the value of AM[i] and store it in R12.
    lw    R13, 0(R9)          # Get the value of BM[i] and store it in R13.
    lw    R14, 0(R3)          # Get the value of B[j] and store it in R14.
    lw    R15, 0(R6)          # Get the value of A[j] and store it in R15.
    dmul  R16, R10, R14       # A[i] * B[J].
    slt   R16, R12, R16       # if (AM[i] < (A[i] * B[j])).
    beq   R16, R0, skip_i     # if the above statement is not true, then don't store in AM[i].
    sw    R16, 0(R8)          # AM[i] = A[i] * B[j].
    skip_i:
    dmul  R16, R11, R15       # B[i] * A[j].
    slt   R16, R13, R16       # if (BM[i] < (B[i] * A[j])).
    beq   R16, R0, skip_j     # if the above statement is not true, then don't store in BM[i]. 
    sw    R16, 0(R9)          # BM[i] = B[i] * A[j].
    skip_j:
    daddi R3, R3, 8           # increase j for B[j].
    daddi R6, R6, 8           # increase j for A[j].
    bne   R3, R5, loop_j      # if j != n. In our case j < n.
    dsub  R3, R3, R1          # reset B[j] to the base address.
    dsub  R6, R6, R1          # reset A[j] to the base address.
    daddi R2, R2, 8           # increase i for A[i].
    daddi R7, R7, 8           # increase i for B[i].
    daddi R8, R8, 8           # increase i for AM[i].
    daddi R9, R9, 8           # increase i for BM[i].
    bne   R2, R4, loop_i      # if i != n. In our case i < n.
    halt