
.section .data
.section .text
    .global printx
    .global printd

@ void printx()
printx:

    @ only need one register as counter
    push {r4-r7, lr}   @ r4 is counter
    mov r4, #0      @ initialize
    mov r1, #0


    @stacking
    push_stack_x:
        lsl r1, r0, #28         @shift bits
        lsr r1, r1, #28
        push {r1}
        add r4, r4, #1      @increment counter
        lsr r0, r0, #4      @shift 4 bits

        cmp r0, #0
        beq pop_stack_x            @if reached end, pop

        @otherwise keep pushing to the stack
        b push_stack_x


    pop_stack_x:
        cmp r4, #0              @ isEmpty()
        beq end_x                 @ if empty, nothing to pop

        pop {r1}                @pop from stack
        sub r4, r4, #1          @decrement

        cmp r1, #9              @compare if less than or more than 9 to see if character or number
        ble less
        bgt more

    less:
        add r1, r1, #48         @ add 48 to convert into character digits

        @putchar(r0)
        mov r0, r1
        bl putchar

        b pop_stack_x             @ keep popping from stack one by one
    more:
        add r1, r1, #87         @convert to lowercase characters

        @putchar(r0)
        mov r0, r1
        bl putchar

        b pop_stack_x             @ keep popping from stack one by one


    end_x:
        pop {r4-r7, pc}            @safe exit


@ void printd()
printd:

    @ using three stable registers 4-6
    push {r4-r6, lr}

    mov r6, r0     @store into r6
    mov r4, #0     @initialize counter

    lsr r0, r0, #31         @shift 31 bits to get sign
    cmp r0, #0              @check if sign bit is 0 or 1
    bne negative            @if it is 1 then it will go into negative
    beq unsigned_longdiv    @otherwise go into unsigned_div

    @Division by a constant integer
    unsigned_longdiv:
        mov r0, r6       @contains number
        mov r1, #10      @r1 is divisor
        mov r2, #0       @initialize quotient
        mov r3, #0       @initialize remainder
        mov r5, #32
        b .Lloop_check1

        .Lloop1:
            movs r0, r0, LSL #1     /* r0 ← r0 << 1 updating cpsr (sets C if 31st bit of r0 was 1) */
            adc r3, r3, r3          /* r3 ← r3 + r3 + C. This is equivalent to r3 ← (r3 << 1) + C */
            cmp r3, r1              /* compute r3 - r1 and update cpsr */
            subhs r3, r3, r1        /* if r3 >= r1 (C=1) then r3 ← r3 - r1 */
            adc r2, r2, r2          /* r2 ← r2 + r2 + C. This is equivalent to r2 ← (r2 << 1) + C */

        .Lloop_check1:
            subs r5, r5, #1         /* r4 ← r4 - 1 */
            bpl .Lloop1             /* if r4 >= 0 (N=0) then branch to .Lloop1 */


    push {r3}

    mov r6, r2              @saving quotient into r6
    add r4, r4, #1          @increment
    cmp r6, #0              @check if q is 0
    beq pop_stack_d           @pop if it is 0
    bne unsigned_longdiv    @otherwise divide

    pop_stack_d:
    cmp r4, #0          @isEmpty()
    beq end_d           @end if empty
    pop {r0}            @pop from stack
    add r0, r0, #48     @make integer
    bl putchar          @putchar(r0)
    sub r4, r4, #1      @decrement
    b pop_stack_d       @loop

    negative:
        mov r0, #45          @ 45 is '-' in ASCII
        bl putchar           @putchar(r0)
        mvn r6, r6           @flip all binary bits
        add r6, r6, #1       @add to complete 2's complement
        b unsigned_longdiv   @divide

    end_d:
        pop {r6}
        pop {r5}
        pop {r4}
        pop {pc}











