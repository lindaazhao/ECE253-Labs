# Program that counts consecutive 1's from a list of words.
.global _start
.text

_start:
    la s2, LIST         # Load the memory address of LIST into s2 
    addi s4, zero, 0
    addi s5, zero, -1   # Used to compare with list element to see if we've reached the end
    addi s10, zero, 0   # s10 will hold the length of longest string of 1s in all words

LOOP: 
    lw t0, 0(s2)        # Load word into s3
    beq t0, s5, END     # End program if we've gone through all LIST elements (i.e. s3 == -1)

    addi s4, zero, 0    # s4 will hold the length of the longest string in the current word

    add a1, zero, s3
    add a2, zero, s3

    jal ONES            # Determine the longest string of 1s in current word
    bgt a0, s10, UPDATELENGTH # Update s10 if we've found a new longest string of 1s
NEXTWORD:
    addi s2, s2, 4      # Increment address by 4 to access next element of list
    b LOOP

ONES:
    beqz a1, ENDONES    # Loop until data contains no more 1's, branch to ENDONES
    srli a2, a1, 1      # Perform SHIFT, followed by AND
    and a1, a1, a2
    addi s4, s4, 1      # Count the string lengths so far
    b ONES
ENDONES:
    add a0, zero, s4
    jr ra               # Return to next instr in LOOP


UPDATELENGTH:
    add s10, zero, a0
    j NEXTWORD




END:
    ebreak

.global LIST
.data
LIST:
.word 0x1fffffff, 0x12345678, -1, 0x7fffffff
