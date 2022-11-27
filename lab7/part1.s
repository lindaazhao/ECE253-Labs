.global _start
.text 
_start: 
	la s2, LIST
	lw s3, 0(s2)
	addi s4, zero, -1
	addi s10, zero, 0 
	addi s11, zero, 0 
	
LOOP: beq s3, s4, END
	addi s11, s11, 1
	add s10, s10, s3
	
	addi s2, s2, 4 		# Increment address by 4 to access next element of list
	lw s3, 0(s2) 		# Load next element of list according to new address
	j LOOP


END: ebreak 

.global LIST
.data 

LIST: .word 1,2,3,5,0xA, -1
# LIST: .word 1, 2, 3, 4, 5, 6, 7, -1
