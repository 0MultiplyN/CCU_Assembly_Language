        .section .text 
        .global BCDADD  @ tell linker 
        .type BCDADD , %function @ main is a function 
        
BCDADD:   
	
		
	@ IF NOT STORE R4 , IT WILL CRASH
	MOV ip, sp
	stmfd sp!,{r4-r10,fp,ip,lr,pc}
	SUB fp, ip, #4

        MOV r2 , r0
        AND r2 , r2 , #0xF // one digit

        MOV r3 , r0 
        LSR r3 , #4 
        AND r3 , r3 , #0xF // ten digit

        MOV r4 , r0 
        LSR r4 , #8 // hundred digit
        AND r4 , r4 , #0xF 
        

        MOV r5 , r1 
        AND r5 , r5 , #0xF // one digit

        MOV r6 , r1 
        LSR r6 , #4 
        AND r6 , r6 , #0xF // ten digit

        MOV r7 , r1 
        LSR r7 , #8 // hundred digit
        AND r7 , r7 , #0xF 
        

        @ one digit addition 
        ADD r2 , r2 , r5 
        CMP r2 , #10 
        SUBGE r2 , r2 , #10 
        ADDGE r3 , r3 , #1 
        @ ten digit addition
        ADD r3 , r3 , r6
        CMP r3 , #10 
        SUBGE r3 , r3 , #10 
        ADDGE r4 , r4 , #1 
        @ hundred digit addition
        ADD r4 , r4 , r7
        CMP r4 , #10 
        SUBGE r4 , r4 , #10 

        @ ====================================
        @ accumulating return value
        MOV r0 , #0 
        ADD r0 , r0 , r2 
        ADD r0 , r0 , r3 , LSL #4
        ADD r0 , r0 , r4 , LSL #8
        @=======================================
	NOP
	ldmea fp,{r4-r10,fp,sp,pc}
		
	.end
		
		
        
