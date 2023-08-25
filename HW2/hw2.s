        .section .text 
        .global main  @ tell linker 
        .type main , %function @ main is a function 
main:
        LDR r1 , =#6
        LDR r5 , =#4
        LDR r6 , =#3  @ load to register 
        ADD r1 , r1 , r1 @ r1 = r1 + r1
        ADD r5 , r5 , r5 , LSL #1 @ r5 = r5 + 2r5
        ADD r0 , r1 , r5 @ r0 = r1 + r5
        SUB r0 , r0 , r6 , LSL #1 @ r0 = r0 -2r6
        nop @ MOV r0 , r0 
         .end

