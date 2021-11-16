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
    loop_i:
    lw    R6, 0(R2)         # Store in R6 the value of A[i].
    daddi R2, R2, 1         # Increase the i.
    loop_j:
    lw    R7, 0(R3)         # Store in R7 the value of B[i]
    daddi R3, R3, 1         # increase the j.

    bne   R3, R1, loop_j    # if j != n_size go to loop_j
    dsub  R3, R3, R4        # Restore array_b to the base address.
    bne   R2, R5, loop_i	# if i != n_size go to loop_i.
    

    halt