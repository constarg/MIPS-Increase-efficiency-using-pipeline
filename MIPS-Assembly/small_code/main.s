.data
n_size:  .word 16
.space 8
array_a: .word 2,-2, 4,-4, 6,-6, 8,-8,-9, 9,-7, 7,-5, 5,-3, 3
.space 8
array_b: .word 8, 7, 6, 5, 4, 3, 2, 1,-1,-2,-3,-4,-5,-6,-7,-8

.text 
main:
    daddi R1, R0, n_size    # Store the base address of size in R1.
    daddi R2, R0, array_a   # Store the base address of array A in R2.
    daddi R3, R0, array_b   # Store the base address of array B in R3.
    lw    R4, 0(R1)         # Load the value of size in R4.
    dsll  R4, R4, 3         # Translate the n_size to n addresses and store it in R4.
    dadd  R5, R4, R2        # Find the last address of array_a and store it in R5.
    dadd  R1, R4, R3        # Find the last address of array_b and store it in R6.
    dadd  R6, R0, R2        # Address to look for A[j].
    dadd  R7, R0, R3        # Address to look for B[i].
    daddi R8, R1, 8         # Base address for AM[].
    dadd  R9, R8, R4        # Last address of AM[].
    daddi R9, R9, 8         # Base address for BM[].

    loop_i:
    lw    R10, 0(R2)        # Get the value of A[i] and store it in R10.
    lw    R11, 0(R7)        # Get the value of B[i] and store it in R11.
    loop_j:
    lw    R12, 0(R8)        # Get the value of AM[i].
    lw    R13, 0(R9)        # Get the value of BM[i].
    lw    R14, 0(R3)        # Get the value of B[j] and store it in R14.
    lw    R15, 0(R6)        # Get the value of A[j] and store it in R15.
    dmul  R16, R10, R14     # A[i] * B[j].     
    slt   R17, R12, R16     # if (AM[i] < (A[i] * B[j])).
    beq   R17, R0, nch_am_i # if the above statement is not true, then don't store in AM[i].
    ch_am_i:                # Change AM[i].
    sw    R16, 0(R8)        # AM[i] = A[i] * B[j].
    nch_am_i:               # Do not change AM[i].
    dmul  R15, R11, R15     # B[i] * A[j].
    slt   R17, R13, R15     # if (BM[i] < (B[i] * A[j]))
    beq   R17, R0, nch_bm_j # if the above statement is not true, then don't store in BM[i]. 
    ch_bm_j:                # Change BM[i].
    sw    R15, 0(R9)        # BM[i] = B[i] * A[j].
    nch_bm_j:               # Do not change BM[i].
    daddi R3, R3, 8         # Increace j for B[j].
    daddi R6, R6, 8         # Increace j for A[j].
    bne   R3, R1, loop_j    # if j != n.
    dsub  R3, R3, R4        # reset B[j] to the base address.
    dsub  R6, R6, R4        # reset A[j] to the base address.
    daddi R2, R2, 8         # Increace i for A[i].
    daddi R7, R7, 8         # Increace i for B[i].
    daddi R8, R8, 8         # Increace i for AM[i].
    daddi R9, R9, 8         # Increace i for BM[i].
    bne   R2, R5, loop_i    # if i != n.

    halt