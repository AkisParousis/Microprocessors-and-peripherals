		  AREA		myData, DATA, READWRITE
map		DCD 		18, 11, 10, 21, 7, 5, 9, 22, 17, 2, 12, 3, 19, 1, 14, 16, 20, 8, 23, 4, 26, 15, 6, 24, 13, 25 ; Defines 26 words containing decimal values
		
		  AREA		myCode, CODE
		  EXPORT		hash
		  ALIGN
hash	PROC
		  PUSH {r4-r7,lr}
		  MOV r2,r0		;copies the value of R0 into R2 (address)
		  LDR r3, =map	;storing map array of integers to register3
		  MOV r4,#0		;initialize r4=0
loop 	LDRB r1, [r2, r4] ;calculating length(str)
		  CBZ r1, exit	;Compare and Branch on Zero
		  ADD r4, r4, #1 	; r4 = r4 + 1
		  B loop
exit	SUB r1, r4, #1 ;setting r1 equal to length(str)-1 for the loop
		  MOV r0, #0	   ;set output = 0
		  MOV r4, #0	   ;set i = 0
startl	CMP r4, r1	   ;for i=0;i<9
		  BGT endl	   ;if i greater than 8 end loop
		  LDRB r5,[r2],#1	;loading value of mem[r2] and then increases r2 = r2 + 1
		  CMP r5, #0x41	; if r5 < 'A' branch to check if it is between 0-9
		  BLT j
		  CMP r5, #0x5A	; if r5 > 'Z' branch to new loop because it is bigger than 0-9 too
		  BGT j2
		  SUB r7, r5, #0x41 ; calculate distance from 'A' so we know which element of map we want
		  LDR r6, [r3 , r7, LSL #2]	; r6 = map[r7]
		  ADD r0, r0, r6		; output = output + r6
j		  CMP r5, #0x31		;if r5 < '1' branch to new loop
		  BLT j2
		  CMP r5, #0x39		;if r5 > '9' branch to new loop
		  BGT j2
		  SUB r7, r5, #0x30	;r7 = r5 - 0
		  SUB r0, r0, r7		;output = output - r7
j2		ADD r4, r4, #1		;r4 = r4 + 1
		  B startl
endl	POP {r4-r7,pc}
		  ENDP
		  END
