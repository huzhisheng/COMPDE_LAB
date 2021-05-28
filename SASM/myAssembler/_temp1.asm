.data
data1:.word 0x00FFF000
data2:.word 0x000FFF00
data3:.word 0xFF000000
.text
initial:

lui $s0,0xFFFF
ori $s0,$s0,0xF000
mode_check:



lw $t0,0xC72($s0)
addi $s7,$t0,0			
srl $t0,$t0,6
andi $t0,$t0,0x0003
beq $t0,$zero,mode_check	
addi $t0,$t0,-1
beq $t0,$zero,mode1		
addi $t0,$t0,-1
beq $t0,$zero,mode2		
j mode3				






mode1:

	lw $s1,data1
	lw $s2,data2
	addi $s3,$zero,24	

	loop1:
	
	andi $t1,$s1,0x0FFF
	add $t2,$s2,$zero
	srl $t2,$t2,20
	sll $t2,$t2,12
	addi $t3,$zero,0
	or $t3,$t1,$zero
	or $t3,$t3,$t2
	
	sw $t3,0xC60($s0) 
	srl $t3,$t3,16
	sw $t3,0xC62($s0) 

	jal wait		
	
	srl $s1,$s1,1
	sll $s2,$s2,1
	addi $s3,$s3,-1
	bne $s3,$zero,loop1
	j mode_check





mode2:
	lw $s1,data3
	loop2:
	add $t1,$s1,$zero	
	sw $t1,0xC60($s0) 
	srl $t1,$t1,16
	sw $t1,0xC62($s0)
	
	jal wait		

	
	
	lui $t1,0xFFFF
	ori $t1,$t1,0xFFFF		
	beq $s1,$t1,all_light
	
	beq $s1,$zero,all_dark
	
	sra $s1,$s1,1
	j loop2

	all_light:
	lui $s1,0x007F
	ori $s1,$s1,0xFFFF
	j loop2

	all_dark:	
	j mode_check	
			




mode3:		
	lw $t1,0xC70($s0)	
	addi $s6,$t1,0		
	addi $s3,$zero,24	
	add $s1,$zero,$zero
	beq $t1,$zero,loop3

	create_loop:		
	ori $s1,$s1,0x0001
	addi $t1,$t1,-1
	beq $t1,$zero,loop3
	sll $s1,$s1,1
	j create_loop

	loop3:
	add $t2,$s1,$zero
	sw $t2,0xC60($s0) 
	srl $t2,$t2,16
	sw $t2,0xC62($s0)
	
	jal wait		
	lw $t6,0xC70($s0)
	bne $t6,$s6,mode_check	

	andi $t1,$s1,0x0001
	beq $t1,$zero,zero_end	

	one_end:		
	srl $s1,$s1,1
	lui $t2,0x0080		
	or $s1,$s1,$t2		
	j back_to_loop3

	zero_end:		
	srl $s1,$s1,1

	back_to_loop3:
	addi $s3,$s3,-1
	bne $s3,$zero,loop3	
	j mode_check

wait:	
	addi $s4,$zero,0x032	

	wait_loop:
	addi $s4,$s4,-1
	bne $s4,$zero,wait_loop
	lw $t0,0xC72($s0)
	bne $t0,$s7,mode_check 	
	jr $ra
