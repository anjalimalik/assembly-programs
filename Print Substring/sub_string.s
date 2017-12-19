
.section .data

.section .text
    	.global sub_string

sub_string:
	@ start index - 1 
	sub r1, r1, $1

	add r0, r0, r1 	@move onto the start index
  
	sub r1, r2, r1  @calculate how many bytes needed by end-start 

	add r0, r0, r1	@this cleaves string at the end index 

	@ store string bytes into r3  
	mov r3, $0
	strb r3, [r0]	
	sub r0, r0, r1  @ extract r1 (end-start) number of characters from end of the cleaved string
    	
	@ exit safely using branch exchange for return
	bx lr
  	svc $0
	.end
