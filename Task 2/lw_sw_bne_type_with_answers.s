# Last edited by Nirmal Kumbhare and Ali Akoglu
.data
X:      .word 0, 0, 0 

.text               # Put program here
.globl main         # globally define 'main'

main:
#la      $t1, X	
ori $t1, $zero, 0
addi $s2, $zero, 29  #s2 = 29
addi $s3, $zero, 12   #s3 = 12
sw $s2, 4($t1) 
sw $s3, 8($t1)
lw $t0, 4($t1) #t0=29
lw $t0, 8($t1) #t0=12
bne $t0, $s2, label1 
add $t0, $zero, $zero  #t0=0 if this is executed bne not working!
addi $t0, $zero, 12   #t0=12 
label1:
bne $t0, $s3, label2
addi $t0, $zero, 1   #t0=1  if not executed then bne not working
label2:
addi $t0, $zero, 29 #t0=29 
# in the correct execution t0 will take the following values: 29, 12,1,29

