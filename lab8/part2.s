.global _start
.text

_start:
    la s0, LIST             # Load the address of LIST into s0
    lw s1, 0(s0)            # s1 holds the number of words in the list

    addi s0, s0, 4          # Increment address to look at first word in list

    addi s2, zero, 0        # s2 keeps track of how many swaps were performed per traversal
    addi s3, zero, 1        # s3 keeps track of which list element we're on
    addi a0, zero, 0

OUTERLOOP: # This loops iterates through LIST until all elements are sorted
    addi s2, zero, 0        # Reset s2 and s3 for each iteration
    addi s3, zero, 0

    # Call INNERLOOP
    jal INNERLOOP

    beq s2, zero, END       # List is sorted if no swaps were performed in most recent iteration
    j OUTERLOOP             # If above line does not go through, then keep iterating

INNERLOOP: # This loop goes element by element and calls swap on them
    bge s3, s1, ENDINNERLOOP
    lw a1, 0(s0)            # Load first word for SWAP
    lw a2, 4(s0)            # Load next word
    
    jal SWAP 

    add s2, s2, a0          # Increment s2 if a swap has been performed
    addi s0, s0, 4          # Increment address to load next word
    addi s3, s3, 1          # Increment s3 to next word
    j INNERLOOP
ENDINNERLOOP: 
    jr ra

SWAP:
    addi a0, zero, 0        # Keep this as 0 if a swap has not been performed
    bgt a1, a2, SWAPTRUE    # Branch if elements need to be swapped
ENDSWAP:
    jr ra                   # Jump back to where SWAP was called
SWAPTRUE:
    sw a2, 0(s0)            # Swap storage locations of a1 and a2
    sw a1, 4(s0)
    addi a0, zero, 1        # Return a0 = 1 since swap was performed
    j ENDSWAP

END:
    ebreak

.global LIST
.data
LIST: 
.word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33