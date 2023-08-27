        .section .text
        .global IDIV
        .type IDIV,%function
IDIV:
    /* function start */
        mov ip,sp
        stmfd sp!,{r4-r10,fp,ip,lr,pc}
        sub fp,ip,#4 
        /* --- begin your function --- */
        /* Do IDIV */
        MOV r8 , r0 
        LDR r9 , =#0 @  ten digit
        CMP r8 , r1 
        BGE LOOP @ NORMAL DIV
        BLE TEST @ DONE
LOOP:
        SUB r8 , r8 , r1  @ DO DIVISOR 
        ADD r9 , r9 , #1  @ COUNT QUOTIENT
        B TEST 

TEST:
        CMP r8 , r1 @ IF GRATER THAN DIVISOR , DONE
        BGE LOOP @ NORMAL DIV
        BLE FINISH

FINISH: 

        MOV r0 , r9
        MOV r1 , r8 
        ldmea fp,{r4-r10,fp,sp,pc}

        
        /* --- end of your function --- */
        /* function exit */
        
.end
