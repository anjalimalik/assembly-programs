 .data 
        string: .asciz "%d\n"
        num1: .word 0
        num2: .word 0
        format: .asciz "%d"

.text 
        .global main

main:
        push {r4-r9, fp, lr}

        /* Get number 1 */
        ldr r0, =format
        ldr r1, =num1
        bl scanf

        /* Get number 2 */
        ldr r0, =format
        ldr r1, =num2
        bl scanf

        /* load r2 and r3 with num1 and num2 */
        ldr r3, =num1
        ldr r2, [r3, #0]
        ldr r3, =num2
        ldr r3, [r3, #0]

        /* compare r2 and r3, enter equal if the numbers are equal or enter largeorsmall to determine if large or small*/
        cmp r2, r3
        bne largeorsmall
        bl equal
        b end

largeorsmall:
        /* load r2 and r3 with num1 and num2 */
        ldr r3, =num1
        ldr r2, [r3, #0]
        ldr r3, =num2
        ldr r3, [r3, #0]

        /* compare, if larger, go to larger, and if, smaller go to smaller */
        cmp r2, r3
        bge larger
        bl smaller
        b end

equal:
        /* load num1 into r3 */
        ldr r3, =num1
        ldr r3, [r3, #0]

        /* print number stored in num1 in string format */
        ldr r0, =string
        mov r1, r3
        bl printf
        b end

smaller:
        /* load num2 into r3 */
        ldr r3, =num2
        ldr r3, [r3, #0]
        /* print number stored in num2 in string format */
        ldr r0, =string
        mov r1, r3
        bl printf
        /* end */
        b end

larger: 
        /* load num1 into r3 */
        ldr r3, =num1
        ldr r3, [r3, #0]
        /* print number stored in num1 in string format */
        ldr r0, =string
        mov r1, r3
        bl printf
        b end
end: 
        /* pop to exit */
        pop {r4-r9, fp, pc}

