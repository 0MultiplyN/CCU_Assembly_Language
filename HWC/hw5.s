        .section .text 
        .global main  @ tell linker 
        .type main , %function @ main is a function 
main:   
	
		@ IF NOT STORE R4 , IT WILL CRASH
		MOV ip, sp
		STMFD sp!, {fp, ip, lr, pc}
		SUB fp, ip, #4


		@ if you want to change the input
		@ you can change the value of the r1
        LDR r1 , =#231 @ assign input in r1 
		@===================================

		@ GET INPUT


        @ let r3 , r4 , r5 be hundred , ten , unit digits
		@=================================================
		@ initialization
		LDR r2 , =#0
		LDR r0 , =#0 @  hundred digit
        LDR r3 , =#0 @  hundred digit
        LDR r4 , =#0 @  ten digit
        LDR r5 , =#0 @  unit digit
        MOV r7 , r1 @ save r1 
		@ if r1 less than 100 CASE
        CMP r1 , #100 
		MOVGE r0 , r1
		MOVGE r1 , #100
		MOVGE r4 , #1 

		
		
		@ go to idiv do the fountion of division
		BLGE IDIV
	

		CMP r4 , #1
		ADDEQ r2 , r2 , r0 , LSL #8
		@ get bit and add it into r2 register
		MOVEQ r0 , r1 
		MOVEQ r1 , #10
		@ get bit and add it into r2 register
		@ go to idiv do the fountion of division
		BLEQ IDIV
		
		CMP r4 , #1
		ADDEQ r2 , r2 , r0 , LSL #4
		@ get bit and add it into r2 register
	    ADDEQ r2 , r2 , r1 
		@ get bit and add it into r2 register
		
		@ ABOVE IS UP 100 CASE 
		@==============================================================
		CMP r1 , #10 
		MOVGE r0 , r1
		MOVGE r1 , #10
		MOVGE r4 , #2 

		@ IF NOT STORE R4 , IT WILL CRASH
		@MOV ip, sp
		@STMFD sp!, {fp, ip, lr, pc}
		@SUB fp, ip, #4

		@ go to idiv do the fountion of division
		BLGE IDIV

		CMP r4 , #2 
		ADDEQ r2 , r2 , r0 , LSL #4
		@ get bit and add it into r2 register
	    ADDEQ r2 , r2 , r1 
		@ get bit and add it into r2 register

		@ ABOVE IS UP 10 CASE 
		@==============================================================
		CMP r4 , #0
		ADDEQ r2 , r2 , r1
		@ don't do any division

		NOP
		ldmea fp, {fp, sp, pc} 
		.end
		
		
        
