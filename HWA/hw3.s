/* DATA section */
/*              */
/*				*/
	.data

/*aR1 aR2 aR3 aR4 means row1,2,3,4 of matrix A */

/* variable aR1 */
	.type aR1, %object
	.size aR1, 12
aR1:
	.word 1
	.word 2
	.word 3

/* variable aR2 */
	.type aR2, %object
	.size aR2, 12
aR2:
	.word 4
	.word 3
	.word 2

/* variable aR3 */
	.type aR3, %object
	.size aR3, 12
aR3:
	.word 1
	.word 3
	.word 4

/* variable aR4 */
	.type aR4, %object
	.size aR4, 12
aR4:
	.word 2
	.word 5
	.word 1


/*bR1 bR2 bR3 bR4 means row1,2,3,4 of matrix B */

/* variable bR1 */
	.type bR1 %object
	.size bR1, 12
bR1:
	.word 1
	.word 3
	.word 2

/* variable bR2 */
	.type bR2 %object
	.size bR2, 12
bR2:
	.word 6
	.word 1
	.word 3

/* variable bR3 */
	.type bR3 %object
	.size bR3, 12
bR3:
	.word 4
	.word 2
	.word 1

/* variable bR4 */
	.type bR4 %object
	.size bR4, 12
bR4:
	.word 3
	.word 4
	.word 5

/* 4 x 3 matrix C */ 
/* variable c */
c:
	.space 48 , 0

/* TEXT section */
/*  			*/

/* Program Target: compute a 4x3 matrix A + 4x3 matirx B */

	.section .text
	.global main
	.type main,%function

main:
	/* getting aR1 */
	ldr r0, = aR1 /* r0 = aR1 */
	ldr r1, [r0], #4 /* r1 = aR1-1, r0 = r0 + 4 */	
	ldr r2, [r0], #4 /* r2 = aR1-2, r0 = r0 + 4 */
	ldr r3, [r0] /* r3 = aR1-3 */
	/* finish getting aR1 */
	
	
	ldr r0, = bR1  /* r0 = bR1 */
	ldr r4, [r0], #4 /* r4 = bR1-1, r0 = r0 + 4 */
	ldr r5, [r0], #4 /* r5 = bR1-2 , r0 = r0 + 4 */
	ldr r6, [r0] /* r6 = bR1-3
	/* finish getting aR1 */

	/* compute aR1 + bR1 */
	add r4, r4, r1 @ r4 = r4 + r1 
	add r5, r5, r2 @ r5 = r5 + r2
	add r6, r6, r3 @ r6 = r6 + r3

	/* store value into ROW1 OF C */
	ldr r0, = c /* r0 = c */
	str r4, [r0], #4 /* mem[r0] = r4, r0 = r0 + 4 */ @r0	C1-1
	str r5, [r0], #4 /* mem[r0] = r5, r0 = r0 + 4 */ @r0+4  C1-2 
	str r6, [r0] /* mem[r0] = r6 */                  @ro+8  C1-3
	/* finish putting */

	////////////////////////////////////////

	/* getting aR2 */
	ldr r0, = aR2 /* r0 = aR2 */
	ldr r1, [r0], #4 /* r1 = aR2-1, r0 = r0 + 4 */	
	ldr r2, [r0], #4 /* r2 = aR2-2, r0 = r0 + 4 */
	ldr r3, [r0] /* r3 = aR2-3 */
	/* finish getting aR2 */
	
	
	ldr r0, = bR2  /* r0 = bR2 */
	ldr r4, [r0], #4 /* r4 = bR2-1, r0 = r0 + 4 */
	ldr r5, [r0], #4 /* r5 = bR2-2 , r0 = r0 + 4 */
	ldr r6, [r0] /* r6 = bR2-3
	/* finish getting bR2 */

	/* compute aR2 + bR2 */
	add r4, r4, r1 @ r4 = r4 + r1 
	add r5, r5, r2 @ r5 = r5 + r2
	add r6, r6, r3 @ r6 = r6 + r3

	/* store value into ROW2 OF C */
	ldr r0, = c /* r0 = c */
	str r4, [r0 , #12]!  /* mem[r0+12] = r4, r0 = r0 + 12 */	@r0+12 C2-1
	str r5, [r0 , #4 ]!  /* mem[r0+4] = r5, r0 = r0 + 4 */ @r0+16 C2-2
	str r6, [r0 , #4 ]!  /* mem[r0+4] = r6 */ @r0+20 C2-3
	/* finish putting */

    ////////////////////////////////////////

	/* getting aR3 */
	ldr r0, = aR3 /* r0 = aR3 */
	ldr r1, [r0], #4 /* r1 = aR3-1, r0 = r0 + 4 */	
	ldr r2, [r0], #4 /* r2 = aR3-2, r0 = r0 + 4 */
	ldr r3, [r0] /* r3 = aR3-3 */
	/* finish getting aR3 */
	
	
	ldr r0, = bR3  /* r0 = bR3 */
	ldr r4, [r0], #4 /* r4 = bR3-1, r0 = r0 + 4 */
	ldr r5, [r0], #4 /* r5 = bR3-2 , r0 = r0 + 4 */
	ldr r6, [r0] /* r6 = bR3-3
	/* finish getting bR3 */

	/* compute aR3 + bR3 */
	add r4, r4, r1 @ r4 = r4 + r1 
	add r5, r5, r2 @ r5 = r5 + r2
	add r6, r6, r3 @ r6 = r6 + r3

	/* store value into ROW3 OF C */
	ldr r0, = c /* r0 = c */
	str r4, [r0 , #24]!  /* mem[r0+24] = r4, r0 = r0 + 24 */	@r0+24 C3-1
	str r5, [r0 , #4 ]!  /* mem[r0+4] = r5, r0 = r0 + 4 */ @r0+28 C3-2
	str r6, [r0 , #4 ]!  /* mem[r0+4] = r6 */ @r0+32 C3-3
	/* finish putting */

	////////////////////////////////////////

	/* getting aR4 */
	ldr r0, = aR4 /* r0 = aR4 */
	ldr r1, [r0], #4 /* r1 = aR4-1, r0 = r0 + 4 */	
	ldr r2, [r0], #4 /* r2 = aR4-2, r0 = r0 + 4 */
	ldr r3, [r0] /* r3 = aR4-3 */
	/* finish getting aR4 */
	
	
	ldr r0, = bR4  /* r0 = bR4 */
	ldr r4, [r0], #4 /* r4 = bR4-1, r0 = r0 + 4 */
	ldr r5, [r0], #4 /* r5 = bR4-2 , r0 = r0 + 4 */
	ldr r6, [r0] /* r6 = bR4-3
	/* finish getting bR4 */

	/* compute aR4 + bR4 */
	add r4, r4, r1 @ r4 = r4 + r1 
	add r5, r5, r2 @ r5 = r5 + r2
	add r6, r6, r3 @ r6 = r6 + r3

	/* store value into ROW4 OF C */
	ldr r0, = c /* r0 = c */
	str r4, [r0 , #36]!  /* mem[r0+36] = r4, r0 = r0 + 36 */	@r0+36 C4-1
	str r5, [r0 , #4 ]!  /* mem[r0+4] = r5, r0 = r0 + 4 */ @r0+40 C4-2
	str r6, [r0 , #4 ]!  /* mem[r0+4] = r6 */ @r0+44 C4-3
	ldr r0, = c /* r0 = c */ @put r0 in top of c 
	/* finish putting */
	nop

