.data
format: .asciz "%s"
print: .asciz "%d\n"
len: .word 0
string: .space 100

.text 
.global main

main:
push {r4-r9, fp, lr}
/* Get string */
ldr r0, =format
ldr r1, =string
bl scanf

/* load string into r1 and initialize r0 for index */
ldr r1, =string
mov r0, #0
/* will go into loop1 as it is just below */

loop1:
/* compare if character is null */ 
ldr r2, [r1]
cmp r2, #0
beq equal

/* increment index and string pointer */
add r0, r0, #1
add r1, r1, #1
/* run loop again if reached here */
b loop1


equal:
/* print index after storing it into r1 */
mov r1, r0
ldr r0, =print
bl printf
/* exit */
pop {r4-r9, fp, pc}
