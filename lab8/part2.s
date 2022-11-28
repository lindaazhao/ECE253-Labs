.global _start
.text

_start: # Set up, iterate through LIST until all elements are sorted
    la s0, LIST             # Load the address of LIST into s0
    lw s1, 0(s0)            # s1 holds the number of words in the list

    addi s0, s0, 4          # Increment address to first word to sort in list

    addi s2, zero, 0        # s2 keeps track of how many swaps were performed per traversal 
                            # (= 0 if no swaps were performed)
    addi s3, zero, 1        # s3 keeps track of which list element we're on

INNERLOOP: # Go through element by element
    bge s3, s1, ENDINNER

    add a0, zero, s0        # Put the address of the first word into a0 too
    jal SWAP

    add s2, s2, a0         # Update s2 with value in a0, will increment if a swap was performed
    addi s3, s3, 1          # Increment s3 to next word
    addi s0, s0, 4          # Increment address to next word
    j INNERLOOP


ENDINNER:
    beqz s2, END            # List is sorted if no swaps were performed in most recent iteration
    j _start                # List not sorted --> start next iteration


SWAP:
    lw t0, 0(a0)
    lw t1, 4(a0)
    ble t0, t1, ENDSWAP # Don't need to swap if t0 <= t1

    # This will execute if t0 > t1
    sw t1, 0(a0)            # Swap memory positions of t0 and t1
    sw t0, 4(a0)
    addi a0, zero, 1        # Swap completed, a0 = 1
    jr ra
ENDSWAP:
    addi a0, zero, 0        # No swap was done, a0 = 0
    jr ra


END:
    ebreak

.global LIST
.data
LIST: 
.word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33