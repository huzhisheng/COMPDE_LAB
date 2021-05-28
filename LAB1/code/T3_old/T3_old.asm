.data
LED1_1:.word 0x00001800
LED1_2:.word 0x00003C00
LED1_3:.word 0x00007E00
LED1_4:.word 0x0000FF00
LED1_5:.word 0x0001FF80
LED1_6:.word 0x0003FFC0
LED1_7:.word 0x0007FFE0
LED1_8:.word 0x000FFFF0
LED1_9:.word 0x001FFFF8
LED1_10:.word 0x003FFFFC
LED1_11:.word 0x007FFFFE
LED1_12:.word 0x00FFFFFF
LED1_13:.word 0x00FFE7FF
LED1_14:.word 0x00FFC3FF
LED1_15:.word 0x00FF81FF
LED1_16:.word 0x00FF00FF
LED1_17:.word 0x00FE007F
LED1_18:.word 0x00FC003F
LED1_19:.word 0x00F8001F
LED1_20:.word 0x00F0000F
LED1_21:.word 0x00E00007
LED1_22:.word 0x00C00003
LED1_23:.word 0x00800001
LED1_24:.word 0x00000000
.text
initial:
lui $s0,0xFFFF
ori $s0,$s0,0xF000 #将IO区域基地址存入s0
addi $s1,$zero,0x18 #s1存放循环计数
addi $s2,$zero,0x0 #s2存放数据指针
#s0存放IO基地址 s1存放循环计数 s2存放数据指针 s3存放为了等半秒的计数
start:
addi $s3,$zero,0x01C0
lw $t0,0x0($s2)
srl $t1,$t0,0x10
sw $t0,0xC60($s0)
sw $t1,0xC62($s0)

half_second:
addi $s3,$s3,-1
bne $s3,$zero,half_second

addi $s2,$s2,4
addi $s1,$s1,-1
bne $s1,$zero, start
j initial


