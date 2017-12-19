
.section .data
    @ Data Declarations as necessary
    inputString: .asciz "Enter a string: "
    inputStart: .asciz "Enter the start index: "
    inputEnd: .asciz "Enter the end index: "
    output: .asciz "The substring of the given string is '%s'\n"
    formatInteger: .asciz "%d"
    formatString: .asciz "%s"
    in_string: .space 1000
    start_index: .word 0
    end_index: .word 0


.section .text
    .global main

main:

    @ get input string
    ldr r0, =inputString
    bl printf
    ldr r0, =formatString
    ldr r1, =in_string
    bl scanf


    @ get input indexes 
    ldr r0, =inputStart
    bl printf
    ldr r0, =formatInteger
    ldr r1, =start_index
    bl scanf

    ldr r0, =inputEnd
    bl printf
    ldr r0, =formatInteger
    ldr r1, =end_index
    bl scanf

    
    @ call sub_string and send arguments
    ldr r0, =in_string
    ldr r1, = start_index
    ldr r1, [r1]
    ldr r2, =end_index
    ldr r2, [r2]
    bl sub_string

    @allocate memory and print output
    push {r4}
    mov r1, r0
    mov r4, r0
    ldr r0, =output
    bl printf
    mov r0, r4
    bl free
    pop {r4}

    @ exit safely
    mov r0, $0
    bl fflush
    mov r7, $1
    svc $0
    .end
