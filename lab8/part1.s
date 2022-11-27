# Program that counts consecutive 1's from a list of
.global _start
.text

_start:
    la s2, LIST         # Load the memory address into s2
    lw s3, 0(s2)        # Load first word in list
    addi a0, zero, 0    # Register a0 will hold the result
    addi s5, zero, -1   # Use to check if we're at the end of LIST
    addi s10, zero, 0   # Holds longest string of ones overall

LOOP: # Loops for each word to check longest length of 1s, update s10 if necessary
    beq s3, s5, END     # Reached end of list if s3 == -1
    addi a0, zero, 0    # Reset the 1's counter for each word
    
    jal ONES            # Get longest string of 1s into a0
    bgt a0, s10, NEWLONGEST # Update s10 if necessary, otherwise go to NEXTWORD

NEXTWORD:
    addi s2, s2, 4      # Increment address by 4 to access next element of list
    lw s3, 0(s2)        # Load next element using new address
    j LOOP

ONES:
    beqz s3, ENDONES    # Loop until data contains no more 1's
    srli s6, s3, 1      # Perform SHIFT, followed by AND
    and s3, s3, s6
    addi a0, a0, 1      # count the string lengths so far
    b ONES

ENDONES:
    jr ra

NEWLONGEST:
    add s10, zero, a0
    j NEXTWORD

END:
    ebreak

.global LIST
.data
LIST: 
.word 0x103fe00f