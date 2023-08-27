        .section .text 
        .global BCDSUB  @ tell linker 
        .type BCDSUB, %function @ main is a function 
BCDSUB:   
	
		
	@ IF NOT STORE R4 , IT WILL CRASH
	MOV ip, sp
	stmfd sp!,{r4-r10,fp,ip,lr,pc}
	SUB fp, ip, #4

        @ IF NOT STORE R4 , IT WILL CRASH

        MOV r2 , r0
        AND r2 , r2 , #0xF // one digit

        MOV r3 , r0 
        LSR r3 , #4 
        AND r3 , r3 , #0xF // ten digit

        MOV r4 , r0 
        LSR r4 , #8 // hundred digit
        AND r4 , r4 , #0xF 

        ////////////////////////////////////
        // above is for the decoding every digit
        // following is for the decoding every digit

        MOV r5 , r1 
        AND r5 , r5 , #0xF // one digit

        MOV r6 , r1 
        LSR r6 , #4 
        AND r6 , r6 , #0xF // ten digit

        MOV r7 , r1 
        LSR r7 , #8 // hundred digit
        AND r7 , r7 , #0xF 
        

        @ one digit subtract
        CMP r2 , r5 
        SUBGE r2 , r2 , r5 
        BGE CASE0
        ADDLT r2 , r2 , #10
        SUBLT r2 , r2 , r5
        BLT CASE1
        
	@ ==== ten digit subtract ======
CASE0 :
        CMP r3 , r6
        SUBGE r3 , r3 , r6
        BGE FINISH @ do not borrow bit 
        ADDLT r3 , r3 , #10
        SUBLT r3 , r3 , r6
        SUBLT r4 , r4 , #1
        BLT FINISH @ borrow bit from the hundred bits
        
	@ ==== ten digit subtract =====

CASE1 :
        @ if r3 less than 0 , it need borrow bit from hundred bits
        CMP r3 , #0
        ADDEQ r3 , r3 , #9
        SUBEQ r4 , r4 , #1
        SUBNE r3 , r3 , #1
        
        
        @ if r3 less than r6 , it need borrow bit hundred bits
        @ remembr th borrow bit if from where
        
        CMP r3 , r6
        SUBGE r3 , r3 , r6 
        ADDLT r3 , r3 , #10
        SUBLT r3 , r3 , r6
        SUBLT r4 , r4 , #1 
        
        
FINISH : 
        @ hundred digit addition
        SUB r4 , r4 , r7 

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
		
		
        
