#Program 9
#Written by Michael Flanagan


# Program ID Number:consoleSubroutines.s
# Written by    :David Smith
# Date Created  :9/23/08
# Revision:	1.1
# Revisions made, date of revision, author:
#	First release   9/19/06		David Smith
#	Added inString	9/21/06 	David Smith
#	Added inFP_S	10/10/06 	David Smith
#	Added outFP_S	10/10/06	David Smith
#	Modified documentation for inString
#			9/23/08		David Smith


.text

# 
#Description: print a new line on the console 
#Internal registers used:  
#Declaration  (void)nextLine(void) 
###############
.globl nextLine
nextLine:
        addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	
	la	$a0, endl       # force end of line
        li	$v0, 4          # code for print string
	syscall                 # Print string 

retnextLine: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra		# Return.

# 
#Description: get input string from the console 
#Internal registers used:  
#Declaration  int inString(char *str) 
################
.globl inString 
inString:
        addi    $sp, $sp, -4   	# Make space on stack.
        sw      $ra, 0($sp)    	# Save return address.
           
        # simulator code to get string from console  
        # $a0 must contain pointer to input buffer
        # $a1 must contain maximum size of string allowed
        # as defined in your data area.
        li	$v0, 8  	# code for get string
        syscall                 # get string
        

retinString: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra            	# Return.
        
# 
#Description: output a string to the console 
#Internal registers used:  
#Declaration  outString(char *str) 
################
.globl outString 
outString:
        addi    $sp, $sp, -4   	# Make space on stack.
        sw      $ra, 0($sp)    	# Save return address.
           
        # simulator code to display string on console
        # a0 must contain pointer to string 
        li	$v0, 4  	# code for print string
        syscall                 # Print string .

retoutString: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra            	# Return.

# 
#Description: read an integer from the console 
#Internal registers used:  
#Declaration  (int num)inInt(void) 
############
.globl inInt 
inInt:
        addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
           
        # simulator code to get integer from console
        li	$v0, 5  	# code for get integer
        syscall                 # get integer
        # integer is returned in $v0

retinInt: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra		# Return.

# 
#Description: output an integer to the console 
#Internal registers used:  
#Declaration  outInt(int) 
#############
.globl outInt 
outInt:
        addi    $sp, $sp, -4      # Make space on stack.
        sw      $ra, 0($sp)       # Save return address.
           
        # simulator code to display integer on console
        # $a0 must contain value to print 
        li	$v0, 1  	# code for print integer
        syscall                     # Print string .
        
retoutInt: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra            	# Return.

# 
#Description: read a floating point number from the console 
#Internal registers used:  
#Declaration  (fp num)inFP_S(void) 
############
.globl inFP_S 
inFP_S:
        addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
           
        # simulator code to get integer from console
        li	$v0, 6		# code for get float number
        syscall                 # get integer
        # float is returned in $f0

retinFP_S: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra		# Return.

# 
#Description: output an floating point number to the console 
#Internal registers used:  
#Declaration  outFP_S(fp) 
#############
.globl outFP_S 
outFP_S:
        addi    $sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
           
        # simulator code to display integer on console
        # $f12 must contain float value to print 
        li	$v0, 2		# code for print float number
        syscall       		# Print string .
        
retoutFP_S: 
        lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra            	# Return.
        
        
  

.globl continue
continue:

	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	#Do you want to continue if yes 
contloop:		
	la	$a0, continueMsg1
	jal	outString
	la	$a0, continuein
	move	$s0, $a0
	li	$a1, 4
	jal 	inString
	lb 	$t0, ($s0)
	li	$t1, 0x79
	beq	$t0, $t1, true
	li	$t1, 0x59
	beq	$t0, $t1, true
	li	$t1, 0x6E
	beq	$t0, $t1, false
	li	$t1, 0x4E
	beq	$t0, $t1, false
	la	$a0, notInRange
	jal	outString
	j	contloop
true:
	 lw      $ra, 0($sp)     # Restore return address.
       	 addi    $sp, $sp, 4     # Restore stack pointer.
       	 jr      $ra            	# Return.
false:
	li	$v0, 0
	
retcontinue:
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jal	mainwhile
	#jr	$ra


.globl getInput
getInput:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	la	$a0, msg5
	jal	outString
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
.globl addfp
addfp:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
addfploop:	
	la	$a0, addend
	jal	outString
	jal	inFP_S
	mov.s	$f2, $f0
	la	$a0, adder
	jal 	outString
	jal	inFP_S
	mov.s	$f4, $f0
	add.s	$f0, $f2, $f4
	jal	roundFloat
	la	$a0, sum
	jal 	outString
	jal	outFP_S
	jal	continue
	beq	$v0,$zero,addfploop
	j	addfploop

retaddfp:
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

.globl subfp
subfp:addi	$sp, $sp, -4
	sw	$ra, 0($sp)
subfploop:	
	la	$a0, subtrahend
	jal	outString
	jal	inFP_S
	mov.s	$f2, $f0
	la	$a0, minuend
	jal 	outString
	jal	inFP_S
	mov.s	$f4, $f0
	sub.s	$f0, $f2, $f4
	jal	roundFloat
	la	$a0, sum
	jal 	outString
	
	jal	outFP_S
	jal	continue
	beq	$v0,$zero,subfploop
	j	subfploop

retsubfp:
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4


.globl mulfp
mulfp:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
mulfploop:	
	la	$a0, multiplicand
	jal	outString
	jal	inFP_S
	mov.s	$f2, $f0
	la	$a0, multiplier
	jal 	outString
	jal	inFP_S
	mov.s	$f4, $f0
	mul.s	$f0, $f2, $f4
	jal	roundFloat
	la	$a0, sum
	jal 	outString
	jal	outFP_S
	jal	continue
	beq	$v0,$zero,mulfploop
	j	mulfploop

retmulfp:
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	
.globl divfp
divfp:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
divfploop:
	jal	nextLine
	la	$a0, dividend
	jal	outString
	jal	inFP_S
	mov.s	$f2, $f0
	la	$a0, divisor
	jal 	outString
zeroretryfp:	
	jal	inFP_S
	mov.s	$f4, $f0
	l.s	$f6,zerofp
	c.eq.s 	$f6, $f4
	bc1t	dividezeroerrorfp
	div.s	$f0, $f2, $f4	#divide two numbers
	jal	roundFloat
	la	$a0, quotient
	jal 	outString
	mov.s	$f0, $f2
	jal	outFP_S
	jal	continue
	beq	$v0,$zero,divfploop
	j	divfploop
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

dividezeroerrorfp:
	la	$a0,zeroerrormsg
	jal	outString
	jal	zeroretryfp




.globl addnum
addnum:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
addnumloop:	
	la	$a0, addend
	jal	outString
	jal	inInt
	move	$s0, $v0
	la	$a0, adder
	jal 	outString
	jal	inInt
	move	$s1, $v0
	add	$s2, $s1, $s0
	la	$a0, sum
	jal 	outString
	move	$a0, $s2
	jal	outInt
	jal	continue
	beq	$v0,$zero,addnumloop
	j	addnumloop

retaddnum:
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
			
	
.globl subnum
subnum:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
subnumloop:
	la	$a0, subtrahend
	jal	outString
	jal	inInt
	move	$s0, $v0
	la	$a0, minuend
	jal 	outString
	jal	inInt
	move	$s1, $v0
	sub	$s0, $s0, $s1
	la	$a0, difference
	jal 	outString
	move	$a0, $s0
	jal	outInt
	jal	continue
	beq	$v0,$zero,subnumloop
	j	subnumloop

retsubnum:
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
			
	
.globl mulnum
mulnum:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
mulnumloop:
	la	$a0, multiplicand
	jal	outString
	jal	inInt
	move	$s0, $v0
	la	$a0, multiplier
	jal 	outString
	jal	inInt
	move	$s1, $v0
	mul	$s0, $s0, $s1
	la	$a0, product
	jal 	outString
	move	$a0, $s0
	jal	outInt
	jal	continue
	beq	$v0,$zero,mulnumloop
	j	mulnumloop
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
.globl divnum
divnum:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
divnumloop:
	jal	nextLine
	la	$a0, dividend
	jal	outString
	jal	inInt
	move	$t0, $v0
	la	$a0, divisor
	jal 	outString
zeroretry:	
	jal	inInt
	move	$t1, $v0
	beq	$t1, $zero,dividezeroerror
	div	$t0, $t1 	#divide two numbers
	mflo	$t2
	mfhi	$t3
	la	$a0, quotient
	jal 	outString
	move	$a0, $t2
	jal	outInt
	la	$a0, remainder
	jal 	outString
	move	$a0, $t3
	jal	outInt
	jal	continue
	beq	$v0,$zero,divnumloop
	j	divnumloop
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

dividezeroerror:
	la	$a0,zeroerrormsg
	jal	outString
	jal	zeroretry

.globl dectobin
dectobin:
	
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	la $a0, enterdecnum  # Put the address of the string in $a0
        jal outString
	jal inInt
        move $s0, $v0
        la $a0, binum
        jal outString
        move $t2, $s0      # Move the value to a different regsiter
        li $s1, 32         # Set up a loop counter
Loop:
        rol $t2, $t2, 1    # Roll the bits left by one bit - wraps highest bit to lowest bit (where we need it!)
        and $t0, $t2, 1    # Mask off low bit (logical AND with 000...0001)
        add $t0, $t0, 48   # Combine it with ASCII code for '0', becomes 0 or 1 
        move $a0, $t0      # Output the ASCII character
        li $v0, 11
        syscall
        
        subi $s1, $s1, 1   # Decrement loop counter
        bne $s1, $zero, Loop  # Keep looping if loop counter is not zero
        jal continue
        j	dectobin
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra


        
        

	
.globl bintodec
bintodec:

	addi	$sp, $sp, -4	# Make space on stack.
	sw	$ra, 0($sp)	# Save return address.

binToDecLoop:
	jal	nextLine	#go to next line
	la	$a0, enterbinum	#load messag
	jal 	outString	#print message	
	jal	nextLine
	la	$a0, marker 	#loading **************
	jal	outString	#printing **************
		
	
	la	$a0, buffer	#loading bufer
	li	$a1, 36		#loading the buffer limit ( the loop will only repeat 32 times )
	
	jal	inString	#getting user input must use inString here
	move	$s1, $a0	#moving user input to s1
	
	li	$s2,	32	#loop counter will loop 32 times in total
	li	$t5,	0	#used to check if 0
	li	$t6,	1	#used to check if 1 		
	lb	$t0,	0($s1)	#loading first byte
	
binDecLoop:	
	beq	$t0,	$zero	endBinDecLoop	#check to see if the loaded byte is null
	beq	$t0,	0x0,	endBinDecLoop	#check to see if the loaded byte is null // Same as above I believe
	subi	$t0,	$t0,	0x30		#subtract hex value to see if 1 or 0	
	blt	$t0,	$t5,	inproperInput	#if less than 0, jump to error message 
	bgt	$t0,	$t6,	inproperInput	#if greater than 1, jump to error message	
	ori 	$t2,	$t0,	0	# 0 & 0 = 0, 1 & 0 = 1
	add	$t3,	$t3,	$t2	#adding my number to t3
	rol	$t3,	$t3,	1	#rotate left ( sll would mess up my number )
	addi	$s1,	$s1,	1	#increment string so when we load the next byte it's not the same we already had
	lb	$t0,	($s1)		#loading next byte	
	subi	$s2,	$s2,	1	#subtract one from the loop counter
	beqz	$s2,	endBinDecLoop	#check to see if counter is 0	
	j	binDecLoop		#jump back to loop
	
#####################################
#checks to see if loop ran 32 times
#moves anwer to a0 and prints it
#clears t3
#jumps to continue loop
####################################
endBinDecLoop:
	bnez 	$s2,	inproperInput	#if it didn't loop 32 times, then the input is not proper
	ror	$t3,	$t3,	1	#need to rotate right once because otherwise the right most 1 will never be counted so the number will always be even
	la	$a0,	decimalmsg		#loading result string
	jal	outString		#printing string
	move	$a0,	$t3		#move t3 to a0
	jal	outInt			#printing result
	move	$t3,	$zero		#clearing t3, for some reason if I choose to continue it seems to keep adding to it
	j	endbinloop
	
##################################################################
#if the number consists of anything other than 1's and 0's or
#the number is not 32 bits long, the user will be prompted with
#an error message and sent back to try again
##################################################################	
inproperInput:
	la	$a0,	inpropermsg	#load msg
	jal	outString		#print msg
	move	$t3,	$zero
	j	binToDecLoop		#jump back to start of loop
	
endbinloop:
	#check to see whether user wants to continue or not
	jal	continue
	beq	$v0, 0, retbintodec
	j	binToDecLoop
	
retbintodec:
	lw      $ra, 0($sp)     # Restore return address.
        addi    $sp, $sp, 4     # Restore stack pointer.
        jr      $ra		# Return.
        
	
	
	
	 
.globl factorial

	addi	$sp, $sp, -8	# Make space on stack.
	sw	$ra, 0($sp)	# Save return address.
factorial:	
	la $a0, enterInt
	jal outString
	jal inInt	#
	move $a0, $v0 	# $a0 = $v0
	jal fac 	# $v0 = fib(n)
	move $s4, $v0   # $s4 = fib(n)
	la $a0, facout
	jal outString
	move $a0, $s4
	jal outInt 	# print	#
	jal continue
	j factorial
	
 
fac: 
	bne 	$a0, $zero, gen # if $a0<>0, goto generic case
	ori 	$v0, $zero, 1 	# else set result $v0 = 1
	jr 	$ra 		# return
gen:
	addiu 	$sp, $sp, -8 	# make room for 2 registers on stack
	sw 	$ra, 4($sp) 	# save return address register $ra
	sw 	$a0, 0($sp) 	# save argument register $a0=n
	
	addiu 	$a0, $a0, -1 	# $a0 = n-1
	jal fac 		# $v0 = fac(n-1)
		
	lw 	$a0, 0($sp) 	# restore $a0=n
	lw 	$ra, 4($sp) 	# restore $ra
	addiu 	$sp, $sp, 8 	# multipop stack
		
	mul 	$v0, $v0, $a0 	# $v0 = fac(n-1) x n
	jr 	$ra 		# return

.globl exponent
exponent:
getX:	
	la	$a0,	exp_promptX 	# Load address of the promptX string
	jal outString		# System call code for print string
	jal inInt			# call OS to Read integer into $v0
	move 	$s0,	$v0 		# Move the integer into $s0
getY:	
	la	$a0,	exp_promptY		# Load address of the promptY string
	jal outString		# System call code for print string
	
	jal inInt
	bltz  $v0, lessthanzerocheck    #checks if value entered for Y is less than zero, if so goes to less than zero subroutine
	move 	$s1,	$v0 		# Move the integer into $s1
	move	$a0,	$s0		# Move the integer in $s0 into $a0
	move	$a1,	$s1		# Move the integer in $s1 into $a1
	jal	exponential		# Jum and link to exponential sub routine
	
	# Print out the result
	move	$s4,	$v0
	la 	$a0, exp_promptR
	jal outString
	move 	$a0, $s4
	jal 	outInt 
	# End the Program
	jal continue
	j exponent			
exponential: 
	addi	$sp,	$sp,	-4
	sw	$t0,	4($sp)
	move	$t0,	$zero
	li	$v0,	1
loop: 
	
	beq	$t0,	$a1,	end	# Checks to see if $t0 is equal to $a1 if not
					# it continues, if it is it jumps to end
	mul	$v0,	$v0,	$a0	# Multiplies the value in $a0 by the value in $v0
	addi	$t0,	$t0,	1	# Adds 1 to $t0 and stores it in $t0 because
					# $t0 is the loop counter
	j	loop			# Jumps to the beginning of the loop to start
					# the process over
end:
	#restore $t0 and the stack
	lw	$t0,	4($sp)
	addi	$sp,	$sp,	4
	jr	$ra

lessthanzerocheck:
	la $a0, exp_zeroerrormsg  #throws invalid input error and requests another y by jumping back to start of get y subroutine
	jal outString
	jal nextLine
	j getY


.globl squareroot
squareroot:
	
	
	la	$a0, sqrt_input		
	jal	outString		# Call outString(sqrt_input)
	
		# Read the integer to take the square root of from the user.
		jal inFP_S		# Integer read is returned in $v0
	
	mfc1 $a0, $f0
	jal calsqrt
	
	
	mtc1 $v0, $f12
	jal outFP_S
	jal continue 
	j squareroot


	
	# calsqrt: 
	# calculating the square root of n
	# using the formular x'=(x+n/x)/2
	# loop until |x'-x| < 0.001
	
calsqrt:
	addi $sp, $sp, -24
	swc1 $f0, 20($sp)
	swc1 $f1, 16($sp)
	swc1 $f2, 12($sp)
	swc1 $f3, 8($sp)
	swc1 $f20, 4($sp)
	swc1 $f21, 0($sp)
	mtc1 $a0, $f0        # $f0 gets n
	l.s $f20, two      # $f20 storing constant 2 for dividing
	l.s $f21, exitcompare     # $f21 storing constant 0.001 for exit comparision
	div.s $f1, $f0, $f20 # $f1 gets n/2
	
	
calsqrtloop:	
	div.s $f2, $f0, $f1  # $f2 gets n/x
	add.s $f2, $f2, $f1  # $f2 gets n/x + x
	div.s $f2, $f2, $f20 # $f2 gets x'=(n/x + x)/2
	sub.s $f3, $f2, $f1  # $f3 gets x'-x
	abs.s $f3, $f3       # $f3 gets |x'-x|
	c.lt.s $f3, $f21     # set the flag if |x'-x| < 0.001
	bc1t calsqrtdone  
	mov.s $f1, $f2
	j calsqrtloop
		
calsqrtdone:	
	mfc1 $v0, $f2

	lwc1 $f0, 20($sp)
	lwc1 $f1, 16($sp)
	lwc1 $f2, 12($sp)
	lwc1 $f3, 8($sp)
	lwc1 $f20, 4($sp)
	lwc1 $f21, 0($sp)
	addi $sp, $sp, 24
	jr $ra
	
	
	
	

	
.globl typeofroots				

typeofroots:
	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	
	# coefficients
	la $a0, enterA # get coefficient of x^2
	jal outString
	jal inFP_S
	l.s	$f6,zerofp
	c.eq.s $f6, $f0
	bc1t notquadratic
	

	mov.s $f2, $f0
	la $a0, enterB #get coefficient of x
	jal outString
	jal inFP_S
	mov.s $f4, $f0
	la $a0, enterC # get constant term
	jal outString
	jal inFP_S
	mov.s $f6, $f0
	jal cases

	

########################################################### quad_solver
discriminant:

 	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.

# calculate discriminant
	mul.s $f8, $f4, $f4 # f8 = B^2
	mul.s $f9, $f6, $f2 # f9 = A*C
	l.s  $f5, four

	mul.s $f9, $f9, $f5 # f9 = 4*A*C
	sub.s $f10,$f8,$f9
		
discriminantret:

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	

		
cases:	
	jal 	discriminant		
	l.s 	$f14, zerofp	
	c.lt.s $f10,$f14 
	bc1t   Case3
	c.eq.s $f10,$f14, 
	bc1t Case2
	
	j  Case1
	
	
	
Case1:
	
	la $a0, Case1msg
	jal outString
	mov.s $f12,$f10
	
	jal outFP_S
	jal continue
	j typeofroots
		 	 	
Case2:
	la $a0, Case2msg
	jal outString
	mov.s $f12,$f10
	
	jal outFP_S
	jal continue
	j typeofroots
Case3:
	la $a0, Case3msg
	jal outString
	mov.s $f12, $f10
	
	jal outFP_S
	jal continue
	j typeofroots	

notquadratic:
	la $a0, notquadraticmsg
	jal outString
	jal continue
	j typeofroots

rettypeofroots:
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	

	
.globl torvalues				

torvalues:
	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	# coefficients
	la $a0, enterA # get coefficient of x^2
	jal outString
	jal inFP_S
	l.s	$f6,zerofp
	c.eq.s $f6, $f0
	bc1t notquadratic
	

	mov.s $f2, $f0
	la $a0, enterB #get coefficient of x
	jal outString
	jal inFP_S
	mov.s $f4, $f0
	la $a0, enterC # get constant term
	jal outString
	jal inFP_S
	mov.s $f6, $f0	
	jal  discriminant
	
	
	
torcases:

	l.s 	$f14, zerofp	
	c.lt.s $f10,$f14 
	bc1t   torCase3
	c.eq.s $f10,$f14, 
	bc1t torCase2
	j  torCase1
	
computesolutions:


	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.

	neg.s $f9, $f9 # f9 = -4*A*C
	add.s $f9, $f8, $f9 # f9 = B^2 - 4*A*C
	sqrt.s $f9, $f9 # f9 = sqrt(B^2 - 4*A*C)
	mov.s $f7, $f4
	neg.s $f7, $f7 # f7 = -B
	l.s $f5, two
	
	mul.s $f8, $f5, $f2 # f8 = 2*A
	add.s $f10, $f7, $f9
	div.s $f10, $f10, $f8 # f10 = one root
	neg.s $f9, $f9
	add.s $f11, $f7, $f9
	div.s $f11, $f11, $f8 # f11 = other root	
	
computersolutionsret:

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
		
torCase1:
	
	
	jal computesolutions
	mov.s $f12, $f10
	
	jal outFP_S
	la $a0, torCase1msgplus
	jal outString
	mov.s $f12,$f11
	
	jal outFP_S
	la $a0, torCase1msgand
	jal outString
	mov.s $f12, $f10
	
	jal outFP_S
	la $a0, torCase1msgminus
	jal outString
	mov.s $f12, $f11
	
	jal outFP_S
	jal continue
	j torvalues
		 	 	
torCase2:
	jal computesolutions
	la $a0, torCase2msg
	jal outString
	mov.s $f12,$f10
	
	jal outFP_S
	jal continue
	j torvalues
torCase3:
	jal computesolutions
	mov.s $f12, $f10
	jal outFP_S
	la $a0, torCase3msgplus
	jal outString
	mov.s $f12,$f11
	jal outFP_S
	la $a0, torCase3msgi
	jal outString
	la $a0, torCase3msgand
	jal outString
	mov.s $f12, $f10
	jal outFP_S
	la $a0, torCase3msgminus
	jal outString
	mov.s $f12, $f11
	jal outFP_S
	la $a0, torCase3msgi
	jal outString
	jal continue
	j torvalues

rettorvalues:										
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

.globl aoftriangle

aoftriangle:
	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	
	la $a0, trianglebasemsg
	jal outString
	jal inFP_S
	l.s $f14, zerofp
	c.le.s $f0, $f14
	bc1t  aoftzeroretry
	mov.s $f1,$f0
	
	la $a0, triangleheightmsg
	jal outString
	jal inFP_S
	l.s $f14, zerofp
	c.le.s $f0, $f14
	bc1t  aoftzeroretry
	mov.s $f2, $f0
	
	mul.s $f2,$f2,$f1
	l.s $f3, onehalf
	mul.s $f3,$f3,$f2
	mov.s $f12,$f3
	la $a0, aoftoutmsg
	jal outString
	jal outFP_S
	jal continue
	j aoftriangle

aoftzeroretry:
	la, $a0, aofzeroretrymsg
	jal outString
	jal continue
	j aoftriangle		
				
retaoftriangle:										
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
	
	   
 
        
.globl aofcircle

aofcircle: 

	

	la $a0, aofcirclegetradmsg
	jal outString
	jal inFP_S
	l.s $f14, zerofp
	c.le.s $f0, $f14
	bc1t  aofzeroretry
	mov.s $f2, $f0
	l.s $f4,pi
	mul.s $f6,$f2,$f2
	mul.s $f8,$f4,$f6
	mov.s $f12, $f8
	la $a0, aofcircleoutmsg
	jal outString
	jal outFP_S
	jal continue
	j aofcircle	
	

		
aofzeroretry:
	la, $a0, aofzeroretrymsg
	jal outString
	jal continue
	j aofcircle


aoftrap:
	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	
	la $a0, trapazoidbase1msg
	jal outString
	jal inFP_S
	l.s $f14, zerofp
	c.le.s $f0, $f14
	bc1t  aoftrapzeroretry
	mov.s $f1,$f0 		#f1 is base 1
	
	la $a0, trapazoidbase2msg
	jal outString
	jal inFP_S
	l.s $f14, zerofp
	c.le.s $f0, $f14
	bc1t  aoftrapzeroretry
	mov.s $f3,$f0		#f3 is base2
	
	la $a0, trapazoidheightmsg
	jal outString
	jal inFP_S
	l.s $f14, zerofp
	c.le.s $f0, $f14
	bc1t  aoftrapzeroretry
	mov.s $f5, $f0 		#f5 is height
	
	add.s $f16,$f3,$f1
	mul.s $f18,$f5,$f16
	l.s $f3, onehalf
	mul.s $f4,$f3,$f18
	mov.s $f12,$f4
	la $a0, aoftrapoutmsg
	jal outString
	jal outFP_S
	jal continue
	j aoftrap

aoftrapzeroretry:
	la, $a0, aofzeroretrymsg
	jal outString
	jal continue
	j aoftrap	
				
retaoftrap:										
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

heronsformula:

	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	
	# coefficients
	la $a0, enterA # get coefficient of x^2
	jal outString
	jal inFP_S
	l.s	$f14,zerofp #putting 0.0 into f6
	c.le.s $f0, $f14  #if the value put into inFP_S is equal to zero than (read next line)
	bc1t HFRetry 	#branch to HFRetry
	mov.s $f2, $f0 #else move the value from inFP_S into $f2
			#A = $f2
	
	la $a0, enterB #get coefficient of x
	jal outString
	jal inFP_S
	l.s	$f14,zerofp #putting 0.0 into f6
	c.le.s $f0, $f14  #if the value put into inFP_S is equal to zero than (read next line)
	bc1t HFRetry 	#branch to HFRetry
	mov.s $f4, $f0 #else move the value from inFP_S into $f4
			#B = $f4
	
	la $a0, enterC # get constant term
	jal outString
	jal inFP_S
	l.s	$f14,zerofp #putting 0.0 into f6
	c.le.s $f0, $f14  #if the value put into inFP_S is equal to zero than (read next line)
	bc1t HFRetry 	#branch to HFRetry
	mov.s $f6, $f0 #else move the value from inFP_S into $f4
			#C = $f8
	
	add.s $f16, $f2, $f4    #f16 is equal to a + b
	c.le.s $f16, $f6	#if c < (a+b)  
	bc1t, HFRetry		#branch to retry else move on
	
	add.s $f18, $f2, $f6  #$16 is equal a + c
	c.le.s $f18,$f4	     #if b < (a + c) 		
	bc1t, HFRetry	    #branch to retry else move on	
	
	add.s $f20, $f4, $f6 #$f16 is equal b + c
	c.le.s $f20,$f2    #if a < (b + c) 	
	bc1t,HFRetry	  #branch to retry else move on	
	
	
	

	
	add.s $f8, $f2, $f4
	add.s $f10, $f6, $f8
	l.s   $f16, two	
	div.s $f18,$f10,$f16 #side is $f18
	sub.s $f20, $f18, $f2 #f26 is side 1
	sub.s $f22, $f18, $f4 #f28 is side 2	
	sub.s $f24, $f18, $f6 #f30 is side 3
	
	mul.s $f26,$f22,$f24 #side 3 x side 2
	mul.s $f28, $f18, $f20 #side 1 x side
	mul.s $f30, $f28, $f26 #(side 1 * side) * (side * side3)
	sqrt.s $f30,$f30
		
	
	
	
	mov.s $f12, $f30
	la 	$a0, aoftoutmsg
	jal 	outString
	jal 	outFP_S
	jal continue
	j heronsformula

		
	


HFRetry:
	la, $a0, HFRetrymsg
	jal outString
	jal continue
	j heronsformula
	
pythagorean:
	addi 	$sp, $sp, -4    # Make space on stack.
        sw      $ra, 0($sp)     # Save return address.
	
	# coefficients
	la $a0, enterA # get coefficient of x^2
	jal outString
	jal inFP_S
	l.s	$f14,zerofp #putting 0.0 into f6
	c.le.s $f0, $f14  #if the value put into inFP_S is equal to zero than (read next line)
	bc1t HFRetry 	#branch to HFRetry
	mov.s $f2, $f0 #else move the value from inFP_S into $f2
			#A = $f2
	
	la $a0, enterB #get coefficient of x
	jal outString
	jal inFP_S
	l.s	$f14,zerofp #putting 0.0 into f6
	c.le.s $f0, $f14  #if the value put into inFP_S is equal to zero than (read next line)
	bc1t HFRetry 	#branch to HFRetry
	mov.s $f4, $f0 #else move the value from inFP_S into $f4
			#B = $f4	
	
	mul.s $f6,$f2, $f2
	mul.s $f8, $f4, $f4
	add.s $f10,$f6, $f8
	sqrt.s $f10,$f10
	
	mov.s $f12, $f10
	la 	$a0, Pythagoreanoutmsg
	jal 	outString
	jal 	outFP_S
	jal continue
	j pythagorean							
			


	
PRetry:
	la, $a0, HFRetrymsg
	jal outString
	jal continue
	j pythagorean
			

.globl procCMD
procCMD:
	li	$t1, 4		#set up to divide by 4 bytes
	la	$s0, cmdTable	#get base address of Table
	la	$s1, endTable	#get the end of Table
	subu	$t0, $s1,$s0	#get the range
	divu	$t2, $t0, $t1	#divide range by 4 to get real range
	bgt	$a0, $t2, upperBad
	blt	$a0, $zero, lowerBad	
	sll	$a0, $a0, 2	#multiply by four
	add	$s0, $s0, $a0	#add the offset
	lw	$s1, 0($s0)	#get address from table
	jr	$s1		# go to subroutine
	
upperBad:
lowerBad:
	la	$a0, notInRange
	jal	outString
	j	mainwhile	
	
.globl roundFloat
# $f10 (rounder) saved to stack and then restored
# $f0 input unrounded float 
# $f12 return rounded float
#Declaration	float roundFloat(float)
#


roundFloat:
	addi	$sp, $sp, -8	# Make space on stack.
	sw	$ra, 0($sp)	# Save return address.

	#save register on stack
	swc1	$f10, 4($sp)
	l.s	$f10, rounder
	mul.s	$f0,$f0,$f10
	round.w.s $f0, $f0
	cvt.s.w	$f0,$f0
	div.s	$f12, $f0,$f10	
	
	#restore stack to register
	lwc1	$f10, 4($sp)
	
retRoundFloat:
	lw	$ra, 0($sp)	# Restore return address.
	addi	$sp, $sp, 8	# Restore stack pointer.
	jr	$ra		# Return.			
	
.globl main
main:
	la $a0,WelcomeMsg
	jal outString
	
	#display instructions
	#while (true) {
		#display menu choices
		#get menu choice
		#process command choice
			#}
	
mainwhile:
	jal	nextLine
	
	la	$a0, cmdPrompt
	jal	outString
	jal	inInt
	move	$a0, $v0	# copy the input number to $a0 for cmdProc
	jal	procCMD		# process the input
	j	mainwhile	# repeat
retmain:
	la	$a0, doneMsg
	jal	outString
	
	#all done
	li	$v0, 10 	#return sero
	syscall

.data
WelcomeMsg:	.asciiz "\tWelcome to Mike's Calculator!\n"
cmdPrompt:	.ascii	"\tChoose calculator command number below:\n"
		.ascii	"\t\t Quit     		- 0\n"		
		.ascii 	"\t\t Add      		- 1\n"
		.ascii	"\t\t Subtract 		- 2\n"
		.ascii 	"\t\t Multiply 		- 3\n"
		.ascii 	"\t\t Divide   		- 4\n"
		.ascii  "\t\t Add decimal\t	- 5\n"
		.ascii  "\t\t Subtract decimal 	- 6\n"
		.ascii  "\t\t Multiply decimal 	- 7\n"
		.ascii  "\t\t Divide decimal 	- 8\n"
		.ascii  "\t\t Convert Decimal to Binary - 9\n "
		.ascii  "\t\t Convert Binary to Decimal - 10\n"
		.ascii  "\t\t Get the Factorial - 11\n"
		.ascii  "\t\t Calculate the Exponent - 12\n"
		.ascii  "\t\t Calculate the Square Root - 13\n"
		.ascii  "\t\t Calculate the Type of Roots of a Quadratic Equation - 14\n"
		.ascii  "\t\t Calculate the Type of Roots of a Quadratic Equation and display values - 15\n"
		.ascii  "\t\t Calculate the Area of a Triangle - 16\n"
		.ascii  "\t\t Calculate the Area of a Circle - 17\n"
		.ascii  "\t\t Calculate the Area of a Trapazoid - 18\n"
		.ascii  "\t\t Calculate the area of a Triangle using the three sides of the triangle (Heron's formula) - 19\n"
		.ascii  "\t\t Calculate the distance of the third side of a Triangle using the Pythagorean theorem - 20\n"
		.asciiz "\tEnter: "
enterInt:	.asciiz "\tEnter an Integer: "
facout:		.asciiz "\tThe Factorial of the number entered is "
enterbinum:	.asciiz "\tEnter a binary number: "
enterdecnum:	.asciiz "\tEnter a decimal number: "
binum:		.asciiz "\tThe decimal number in binary is "
decimalmsg:	.asciiz "\tThe decimal representation of the number is "
addend:		.asciiz	"\tEnter the addend: "
adder:		.asciiz	"\tEnter the adder: "
sum:		.asciiz "\tThe sum is "
subtrahend:	.asciiz	"\tEnter the subtraend: "
minuend:	.asciiz	"\tEnter the minuend: "
difference:	.asciiz	"\tThe difference is "
dividend:	.asciiz	"\tEnter the dividend: "
divisor:	.asciiz	"\tEnter the divisor: "
quotient:	.asciiz	"\tThe quotient is "
remainder:	.asciiz	"\tYour remainder is "
multiplicand:	.asciiz	"\tEnter the multiplicand: "
multiplier:	.asciiz	"\tEnter the multiplier: "
product:	.asciiz	"\tThe product is  "
exp_promptX: 	.asciiz "\tEnter a number for X: "
exp_promptY: 	.asciiz "\tEnter a number for Y: "
exp_promptR: 	.asciiz "\tThe result of the exponential function is "
exp_zeroerrormsg:	.asciiz "\tPlease enter a new Y that is not equal to zero "
zerofp:		.float	0.0 
zeroerrormsg:	.asciiz "\tPlease enter a new divisor that is not equal to zero "
rounder:	.float  10000.0
two: 		.float  2.0
onehalf:	.float	0.5
buffer:		.space 36
endl:		.asciiz "\n"
marker: 	.asciiz "********************************\n"
inpropermsg:	.asciiz	" \n\t The input must consist of only 1's and 0's and must be 32 bits long."
sqrt_input: 	.asciiz "\tEnter input number: " 
sqrt_result:	.asciiz "\tThe square root of that number is "
sqrt_errormsg:	.asciiz "\tError: Can't take the square root of a negative number!"
enterA:		.asciiz "\tPlease enter a value for A:"
enterB:		.asciiz	"\tPlease enter a value for B:"
enterC: 	.asciiz	"\tPlease enter a value for C:"
trianglebasemsg:.asciiz "\tPlease enter the Base of the Triangle: "
triangleheightmsg:.asciiz "\tPlease enter the Height of the Triangle: "
msg1:		.asciiz	"You have reached the addnum subroutine\n"
msg2:		.asciiz	"You have reached the subnum subroutine\n"
msg3:		.asciiz	"You have reached the mulnum subroutine\n"
msg4:		.asciiz	"You have reached the divnum subroutine\n"
msg5:		.asciiz "You have reached the getInput subroutine\n"
continueMsg1:	.asciiz "\n\tDo you want to continue (y) or quit (n)? "
continuein:	.space 20
doneMsg:	.asciiz "\tThank you for using Mike's Calculator"
exitcompare: 	.float 0.001
notquadraticmsg:.asciiz "\tthis is not a quadratic equation"
Case1msg:		.asciiz "\ttwo real roots with a discriminant of "
Case2msg:		.asciiz "\tone real roots with a discriminant of "
Case3msg:		.asciiz "\ttwo imaginary roots with a discriminant of "
torCase1msgplus:		.asciiz " + "
torCase1msgand:		.asciiz " and "
torCase1msgminus:		.asciiz " - "
torCase2msg:		.asciiz ""
torCase3msgplus:		.asciiz " + "
torCase3msgi:		.asciiz "i "
torCase3msgand:		.asciiz " and "
torCase3msgminus:		.asciiz " - "
aofcirclepromptmsg:	.asciiz	"\t Would you like to use the radius or the diameter?\n \t\tEnter 1. For Radius\n \t\tEnter 2. for Diameter\n"
aofcirclegetradmsg:	.asciiz "\t Please enter the radius: "
aofcirclegetdimsg:	.asciiz "\t Please enter the diameter: "
aofcircleoutmsg:	.asciiz "\t The area of the circle is: "
pi:		.float	3.14
one:		.word 	1
dos:		.word	2
aofzeroretrymsg:.asciiz "\tPlease use only use posiive real numbers (numbers that are equal to 1 or greater)"
aoftoutmsg:	.asciiz "\tThe area of the triangle is "
aoftrapoutmsg:  .asciiz "\tThe area of the trapazoid is "
trapazoidbase1msg: .asciiz "\tPlease enter Base 1 of the Trapazoid: "
trapazoidbase2msg: .asciiz "\tPlease enter Base 2 of the Trapazoid: "
trapazoidheightmsg:.asciiz "\tPlease enter the Height of the Trapazoid: "
four: 		.float 4.0
HFRetrymsg:	.asciiz	"\tThis is not a valid triangle"
Pythagoreanoutmsg: .asciiz "\tThe length of the third side of the triangle is: "


msg_done:	.asciiz "done\n"
cmdTable:
		.word	retmain
		.word	addnum
		.word	subnum
		.word	mulnum
		.word 	divnum
		.word	addfp
		.word	subfp
		.word	mulfp
		.word	divfp
		.word	dectobin
		.word 	bintodec
		.word   factorial
		.word 	exponent		 
		.word 	squareroot		 
		.word 	typeofroots
		.word 	torvalues	
		.word	aoftriangle
		.word	aofcircle
		.word 	aoftrap	
		.word 	heronsformula
endTable:	.word	pythagorean	 #end of command table
notInRange:	.asciiz "\n\tEntry is out of Range, try again\n"
