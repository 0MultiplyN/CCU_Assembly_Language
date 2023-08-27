        .section .text 
        .global main  @ tell linker 
        .type main , %function @ main is a function 
main:   
        LDR r1 , =#687 @ assign input in r1 
        @ let r3 , r4 , r5 be hundred , ten , unit digits

        LDR r3 , =#0 @  hundred digit
        LDR r4 , =#0 @  ten digit
        LDR r5 , =#0 @  unit digit
        MOV r7 , r1 @ save r1 
        CMP r1 , #100 @ if r1 less than 100
	BGE LOOPH @ go divide hundred digit
	BLE TESTE @ go ten branch test
@ hundred loop 
LOOPH: 
	SUB r1 , r1 , #100 @ do divide hundred digit
	ADD r3 , r3 , #1 @ the BCD hundred digit plus one
	B TESTH  @ do branch test of hundred digit
TESTH:
	CMP r1 , #100 @ if r1 less than 100
	BGE LOOPH @ go divide hundred digit
	BLE TESTE @ go ten branch test
@ ten digit loop
LOOPT:
	SUB r1 , r1 , #10 @ do divide TEN digit
	ADD r4 , r4 , #1 @ the BCD TEN digit plus one
	B TESTE @ do branch test of ten digit

TESTE:
	CMP r1 , #10 @ if r1 less than 100
	BGE LOOPT @ go divide hundred digit
	BLE FINISH @ go ten branch test
@ put answer in r2
FINISH:
	MOV r5 , r1 @ the r5 digit is unit digit
        @finally put answer in r2 
	ADD r2 , r2 , r5 @ unit digit of BCD code
        ADD r2 , r2 , r4  , LSL #4 @ ten digit of BCD code
        ADD r2 , r2 , r3  , LSL #8 @ hundred  digit of BCD code
        MOV r1 , r7 @ keep r1 origin value
	nop
         .end
        
