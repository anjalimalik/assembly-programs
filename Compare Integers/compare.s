
.section 	.data
    	message1: .asciz "Enter the first number: "
    	num1: .word 0
    	message2: .asciz "Enter the second number: "
    	num2: .word 0
    	eq: .asciz "%d and %d are equal.\n"
    	notEq: .asciz "%d is strictly greater than %d by %d.\n"
    	format: .asciz "%d"

.section	 .text
    	.global main

main:
    	ldr r0,  =message1 	
    	bl printf           @print message1
    	ldr r0, =format     @load format in r0
    	ldr r1, =num1   	@load input into variable num1
    	bl scanf

    	ldr r0,  =message2 	
    	bl printf           @print message2
    	ldr r0, =format	@load format in r0
    	ldr r1, =num2	@load input into variable num2
    	bl scanf
    
    	ldr r5, =num1
    	ldr r4, [r5]
    	ldr r5, =num2
    	ldr r5, [r5]

    	cmp r4, r5
    	beq equal
    	blt small
    	bne large
    	b end

equal:
    	ldr r0, =eq
        ldr r3, =num2
        ldr r1, [r3]
        ldr r3, =num1
        ldr r2, [r3]
    	bl printf
	b end
small:
    	ldr r0, =notEq
        ldr r3, =num2
        ldr r1, [r3]
        ldr r3, =num1
        ldr r2, [r3]
    	sub r3, r1, r2
    	bl printf
    	b end

large:
    	ldr r0, =notEq
        ldr r3, =num1
        ldr r1, [r3]
        ldr r3, =num2
        ldr r2, [r3]
    	sub r3, r1, r2
    	bl printf
    	b end

end: 
	mov r0, $0
    	bl fflush
    	mov r7, $1	
    	svc $0
    	.end

