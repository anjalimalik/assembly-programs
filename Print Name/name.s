
.section    .data
    message1: .asciz "Enter your first name: "
    fName: .space 100
    message2: .asciz "Enter your last name: "
    lName: .space 100
    print: .asciz "Hello, %s %s.\n"
    format: .asciz "%s"
.section    .text
    .global    main

main:
	ldr r0,  =message1 	@load message1 into r0
	bl printf           	@print message1
    	ldr r0, =format     	@loading format
    	ldr r1, =fName  	@loading address of variable used to store
    	bl scanf
    	ldr r0,  =message2 	@load message2 into r0
    	bl printf           	@print message2
    	ldr r0, =format		@loading format
    	ldr r1, =lName		@loading address of variable used to store
    	bl scanf

    	ldr r0, =print 		@print the required output
    	ldr r1, =fName
    	ldr r2, =lName
    	bl printf
	
	mov r0, $0
	bl fflush
    	mov r7, $1	@exit syscall
    	svc $0		@wake kernel	
    	.end
