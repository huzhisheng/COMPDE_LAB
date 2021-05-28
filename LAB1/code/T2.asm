.data
saved_answer:.word 0x00000000	#用于存储计算结果

.text
#本设计使用方法:[SW3-SW0]输入4位数据x,SW23代表立方计算,SW22代表平方计算,SW21代表存储器中的值清零并进行新的计算
#默认是进行平方计算,因此实际SW22打不打开都一样,如果SW23打开了则不管SW22是否打开都是进行立方计算

#注：
#如果结果没有显示出来,请将SW21打开,
#因为系统默认第一次输入的是0所以所有灯都是熄灭的,需要将SW21打开后才进行新的计算
#如果SW21一直打开则会不断进行计算不断更新LED值,因此建议在使用时一直打开SW21
start:
lui   $t0,0xFFFF
ori   $s0,$t0,0xF000
lw    $s1,0xC70($s0)
lw    $s2,0xC72($s0)
#andi   $s1,$t1,0xFFFF
#andi   $s2,$t2,0x00FF

addi $t9,$zero,1
addi $t8,$zero,4
addi $t7,$zero,8
#s0存放的是IO基地址 s1用作部分积和乘数 s2的低8位存放了要进行什么运算的标志 s3存放的是原数据左移8位的结果 s4存放的是原数据左移4位的结果 s7存放原数据以用作立方的时候用
#t9存放常数1 t8存放常数4 t7存放常数8
#复制一份原数据
addi   $s7,$s1,0x0000
#将s1左移4位存入s6,左移8位存入s4
sll $s4,$s1,4
sll $s3,$s1,8
#在进行平方运算
check1:
andi $t0,$s1,0x0001
bne $t0,$t9,shift1	#若最后一位不是1直接跳过加s6的过程
add $s1,$s1,$s4
shift1:
srl $s1,$s1,1
sub $t8,$t8,$t9
bne $t8,$zero,check1
#平方运算已经完成，接下来检查是否要再乘以原来的数以实现立方操作
andi $t2,$s2,0x0080
beq $t2,$zero,exit
#此时s1存放的是a^2,而s7存放的是a,还需要将s1和s7进行乘法
check2:
andi $t0,$s1,0x0001
bne $t0,$t9,shift2	#若最后一位不是1直接跳过加s6的过程
add $s1,$s1,$s3
shift2:
srl $s1,$s1,1
sub $t7,$t7,$t9
bne $t7,$zero,check2
exit:
sw $s1,0x0($zero)	#保存计算结果到存储器中
sw $s1,0xC60($s0)

wait:#一直循环等待直到SW21为1
#等待SW被打开
lui   $t0,0xFFFF
ori   $s0,$t0,0xF000
lw    $s2,0xC72($s0)
and   $t0,$s2,0x0020
beq   $t0,$zero,wait

sw $zero,saved_answer	#将存储器清零
j start

