nop 
nop 
nop 
nop
nop
nop 	
addi $3, $0, 1	# r3 = 1
addi $4, $0, 35	# r4 = 35
addi $1, $0, 3	# r1 = 3
addi $2, $0, 21	# r2 = 21
sub $3, $0, $3	# r3 = -1
sub $4, $0, $4	# r4 = -35
nop 
nop 			# Positive Value Tests
add $5, $2, $1	# r5 = r2 + r1 = 24
sub $6, $2, $1	# r6 = r2 - r1 = 18
and $7, $2, $1	# r7 = r2 & r1 = 1
or $8, $2, $1 	# r8 = r2 | r1 = 23
sll $9, $1, 4 	# r9 = r1 << 4 = 48
sra $10, $2, 2	# r10 = r2 >> 2 = 5
nop 
nop 			    # Negative Value Tests
addi $11, $2, -89	# r11 = r2 - 89 = -68
add $12, $4, $2	    # r12 = r4 + r2 = -14
sub $13, $4, $2	    # r13 = r4 - r2 = -56
sll $14, $3, 16	    # r14 = r3 << 16 = -65536
sra $15, $4, 16	    # r15 = r4 >> 16 = -1
nop 
nop 			# Load/Store Tests
sw $1, 1($0) 	# mem[1] = r1 = 3
sw $2, 2($0) 	# mem[2] = r2 = 21
sw $3, 0($1) 	# mem[r1] = r3 = -1 (should be mem[3])
lw $16, 1($0) 	# r16 = mem[1] = 3
lw $17, 2($0) 	# r17 = mem[2] = 21
lw $18, 0($1) 	# r18 = mem[3] = -1
nop
nop
jal here
nop
addi $19, $0, 2	    # (incorrect!) r19 = 0
addi $20, $0, 4	    # (incorrect!) r20 = 0
nop
nop
here:
addi $21, $0, 7	# r21 = 7
nop
nop
nop
nop