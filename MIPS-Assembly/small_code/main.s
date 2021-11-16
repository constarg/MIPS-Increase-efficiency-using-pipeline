.data
n_size:  .word 16
.space 8
array_a: .word 2,-2, 4,-4, 6,-6, 8,-8,-9, 9,-7, 7,-5, 5,-3, 3
.space 8
array_b: .word 8, 7, 6, 5, 4, 3, 2, 1,-1,-2,-3,-4,-5,-6,-7,-8

.text 
main:
    daddi R1, R0, n_size  # Store the base address of size in R1
    daddi R2, R0, array_a # Store the base address of array A in R2
    daddi R3, R0, array_b # Store the base address of array B in R3
    lw    R4, 0(R1)       # Load the value of size in R4
    dadd R1, R4, R4
    dadd R6, R1, R2

    halt