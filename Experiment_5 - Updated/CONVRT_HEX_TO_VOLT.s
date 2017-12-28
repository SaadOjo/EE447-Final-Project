;**************************************************************
; takes value from R1 and converts it onto voltage
; R5 contains address of where to store the data

REF_VOLT		EQU				0x14A
ADC_MAX_HEX		EQU				0xFFF		

;Label			Directive		Value					Comment
				AREA			routines,CODE,READONLY,ALIGN=2
				THUMB		
				EXPORT			CONVRT_HEX_TO_VOLT					
					
CONVRT_HEX_TO_VOLT	PUSH {R0-R7,LR}			    			;Save the current status to memory
				
				MOV R2, #0								; Keeps the converted BCD digit 

				LDR  R0, =REF_VOLT						; Convert to a number between 0 an 330 hex eq
				MUL  R1, R0								;
				LDR  R0, =ADC_MAX_HEX 					;
				UDIV R1, R0								;
				
				MOV  R0, #100							; Used to convert bases
FIR_AGAIN		SUBS R1,R0								;
				BLT	 STORE_FIR							;	
				ADD  R2,#1								;
				B	 FIR_AGAIN							;

STORE_FIR		ADD		R2, #48							;
				STRB	R2,[R5],#1						;Post index
				ADD		R1,R0							;
				
STR_DOT			MOV		R2,#46							;AASCII FOR DOT			
				STRB	R2,[R5],#1						;Post index
				
				MOV  R2,  #0								; Keeps the converted BCD digit
				MOV  R0, #10							; Used to convert bases
SEC_AGAIN		SUBS R1,R0								;
				BLT	 STORE_SEC							;	
				ADD  R2,#1								;
				B	 SEC_AGAIN							;

STORE_SEC		ADD		R2, #48							;Does not really need to be repeated
				STRB	R2,[R5],#1						;Post index
				ADD		R1,R0							;
				
				MOV R2,  #0								; Keeps the converted BCD digit
				MOV  R0, #1								; Used to convert bases
THD_AGAIN		SUBS R1,R0								;
				BLT	 STORE_THD							;	
				ADD  R2,#1								;
				B	 THD_AGAIN							;

STORE_THD		ADD		R2, #48							;Does not really need to be repeated
				STRB	R2,[R5],#1						;Post index

				MOV R2,#0x04							;
				STRB R2,[R5] 			    			; 
				POP {R0-R7,LR}							;Reset the registers to the original values
				BX LR
					
				ALIGN
				END
					