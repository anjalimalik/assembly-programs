.data 
index: .word 0
format: .asciz "%d"
sum: .word 0
num: .word 0
p: .asciz "%d\n"

.text 
.global main

main:
	push {r4-r9, fp, lr}
	/* initialise registers for sum and num */
	mov r4, #0
	mov r5, #0
	b loop1

loop1:
	/* compare if index is 5, if 5, exit into print */
	cmp r4, #5
	beq print
	
	/* get number each time and load into r1 */
	ldr r0, =format
	ldr r1, =num
	bl scanf
	
	/* add r1 to the sum which is in register 5 */
	ldr r1, =num
	ldr r1, [r1]
	add r5, r1, r5
	add r4, r4, #1
	b loop1
	
print:
	/* move sum to r1 and print using format loaded into r0 */
	ldr r0, =p
	mov r1, r5
	bl printf
	b end

end:	
	/* exit */
	pop {r4-r9, fp, pc}
