.data
data1:.word 0xFF000FFF

data3:.word 0xFF000000
.text
initial:
#将IO区域基地址存入s0
lui $s0,0xFFFF
ori $s0,$s0,0xF000
mode_check:
#判断应该进入哪个模式,mode1是指导书中模式1,mode2是指导书中模式2,mode3是指导书中模式3
#在这个设计中,读取[SW23,SW22]的值作为选择,选择01是模式1,10是模式2,11是模式3,如果是00则会熄灭所有LED灯
#如果在执行过程中改变模式选择,则会在当前模式执行完完整的循环后才会跳转到新选择的模式中去
lw $t0,0xC72($s0)
addi $s7,$t0,0			#将输入保存下来,每隔半秒检查是否模式发生了改变,一旦改变则回到mode_check
srl $t0,$t0,6
andi $t0,$t0,0x0003
beq $t0,$zero,mode_check	#选择是00,则循环mode_check,直到选择其它模式为止
addi $t0,$t0,-1
beq $t0,$zero,mode1		#选择是01,进入模式1
addi $t0,$t0,-1
beq $t0,$zero,mode2		#选择是10,进入模式2
j mode3				#选择是11,进入模式3


#模式1的实现思路是：将24个LED灯从中间分成2组,一组代表一边的12个LED,
#data1的值是FF000FFF,将这个值存到s1和s2中,s1负责右边12个LED,s2负责左边12个LED,每次都取32位中第23~12位作为该组LED灯的数据
#拿右边12盏LED来说明,刚开始是FF000FFF,第23~12位都是0,因此右边LED全熄灭,半秒后,将FF000FFF左移1位就可以使右边12盏LED中最右边的LED点亮,
#再左移就再点亮一盏灯,同时每半秒都会检查右边12盏LED是否全亮,当右边12盏全亮时,即代表24盏LED全亮,这时就需要反向移动来反向熄灭LED,
#当全亮时,s1中的数据从最初的FF000FFF已经左移12位变成了00FFF000,这时候只需要再算术右移,即可从中间向两边逐渐熄灭所有LED

#左边12盏LED同理
mode1:
#s1存右边的数据,s2存左边的数据,s3存移位的计数(为0时回到mode1标签),s4存放等待半秒的计数,t4存放移位反向标志
	lw $s1,data1
	lw $s2,data1
	addi $s3,$zero,24	#s3存放移位计数
	addi $t4,$zero,1	#t4存放是否需要反向的标志
	
	loop1:
	#t1存放临时右边数据,t2存放临时的左边数据,t3存放临时的拼接的数据
	add $t1,$s1,$zero
	srl $t1,$t1,12
	andi $t1,$t1,0x0FFF 
	add $t2,$s2,$zero
	srl $t2,$t2,12
	andi $t2,$t2,0x0FFF
	sll $t2,$t2,12
	addi $t3,$zero,0
	or $t3,$t1,$zero
	or $t3,$t3,$t2
	andi $t5,$t3,0x0FFF	#用t5保存临时的t3的后12位,以便之后判断是否24盏全亮
	#t3中的第23位到第0位就是24个LED的数据
	sw $t3,0xC60($s0) 
	srl $t3,$t3,16
	sw $t3,0xC62($s0) 

	jal wait		#延时半秒
	addi $t1,$zero,0x0FFF
	bne $t5,$t1,shift
	
	addi $t4,$zero,0
	shift:			#s1和s2移位,具体移动方向由t4中是0还是1来决定
	beq $t4,$zero,reverse_move
	
	sll $s1,$s1,1
	sra $s2,$s2,1
	j loop1_final
	reverse_move:
	sra $s1,$s1,1
	sll $s2,$s2,1		
	loop1_final:
	addi $s3,$s3,-1
	bne $s3,$zero,loop1
	j mode_check

#模式2的实现思路是：为了方便说明假设当前共有4个LED灯,因此我们取初始值为[1...110000]这样的数据的后四位来控制LED,
#等半秒后就将数据“符号右移”1位,上面的数据就变为了[1...111000]后四位就变为了1000,这样一直循环就有1100,1110,1111
#等后四位都为1,所有LED都是亮的时候,就将从第3位开始前面所有位用and来置为0,
#例如此时的[1...111111]就变为了[0...000111],后四位就变为了0111,再进行符号右移就有0011,0001,0000,等到全为0时就代表完整的执行了一次模式2
mode2:
	lw $s1,data3
	loop2:
	add $t1,$s1,$zero	#s1的数据复制到t1
	sw $t1,0xC60($s0) 
	srl $t1,$t1,16
	sw $t1,0xC62($s0)
	
	jal wait		#延时半秒

	#每次循环一次且等待半秒后都要再判断是否是全亮或者全灭两种特殊情况
	#判断是否是全亮
	lui $t1,0xFFFF
	ori $t1,$t1,0xFFFF		#t1设置为全1,再拿去和s1比较
	beq $s1,$t1,all_light
	#判断是否是全灭
	beq $s1,$zero,all_dark
	#否则则回到loop2
	sra $s1,$s1,1
	j loop2

	all_light:
	lui $s1,0x007F
	ori $s1,$s1,0xFFFF
	j loop2

	all_dark:	#所有LED灯都是熄灭的时候就代表模式2完整执行了一遍,回到mode_check去检查模式选择是否已经改变
	j mode_check	#注意不必担心第一次进入模式2的时候因为灯是全灭的就会直接跳回mode_check,
			#因为第一次取出的数据虽然后24位是全0，但是前12位都是1,因此不会被判定为与0相等

#模式3的实现思路是：通过[SW4,SW3,...,SW0]输入连续点亮LED个数为x,
#首先要创建初始的点亮的LED的队列,大致的思路就是取一个全为0的寄存器s1,每次将s1的末位置为1，然后将x减1,再判断x是否为0,不为0则s1左移1位进入下个构建s1的循环
#构建好s1后就每次循环：先判断s1末位是1还是0,是0则直接逻辑右移即可,末位是1则需要先逻辑右移,再将s1的第24位置为1(用or操作即可)
mode3:		#设计[SW4,SW3,...,SW0]5个开关决定了点亮的位数,因为共有24位LED灯,所以最大值是24,选择的值大于24也和24的效果一样,都是全亮的效果
	lw $t1,0xC70($s0)	
	addi $s6,$t1,0		#复制一份初始的键位输入,每隔半秒检查是否输入发生改变,若发生改变直接进入mode_check
	addi $s3,$zero,24	#s3存放移位次数
	add $s1,$zero,$zero
	beq $t1,$zero,loop3

	create_loop:		#创建初始点亮LED的队列s1
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
	
	jal wait		#延时半秒
	lw $t6,0xC70($s0)
	bne $t6,$s6,mode_check	#如果输入的应连续点亮的数目有改变，则返回mode_check

	andi $t1,$s1,0x0001
	beq $t1,$zero,zero_end	#判断末位是0则跳转到zero_end,否则直接顺序进入下面的one_end代表末位是1

	one_end:		#末位是1
	srl $s1,$s1,1
	lui $t2,0x0080		
	or $s1,$s1,$t2		#将s1的第23位置为1
	j back_to_loop3

	zero_end:		#末位是0
	srl $s1,$s1,1

	back_to_loop3:
	addi $s3,$s3,-1
	bne $s3,$zero,loop3	#判断是否已经完整执行了一次模式3
	j mode_check

wait:	#子函数,用于延时半秒
	addi $s4,$zero,0x024	#延时半秒的循环次数存入寄存器s4

	wait_loop:
	addi $s4,$s4,-1
	bne $s4,$zero,wait_loop
	lw $t0,0xC72($s0)
	bne $t0,$s7,mode_check 	#如果模式改变,返回mode_check
	jr $ra
