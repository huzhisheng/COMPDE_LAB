.text
addi $t0,$zero,10
addi $s1,$zero,5

subbing:
addi $s1,$s1,-1
beq $s1,$zero,adding
j subbing

adding:
addi $s1,$s1,1
beq $s1,$t0,exit
j adding

exit:
addi $t0,$zero,0
