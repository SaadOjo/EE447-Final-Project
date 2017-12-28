RCGC0	 		EQU 0x400FE100 ;
RCC		 		EQU 0x400FE060 ;
PWM0CTL	 		EQU 0x40082000 ; 
PWM0LOAD 		EQU 0x40082050 ; 
PWMENABLE 		EQU 0x40082008 ; 
PWM0INTEN 		EQU 0x40082044 ; 

;label			directive			value			comment
				AREA  pwmInitializeRoutine,CODE,READONLY
				THUMB	
				EXPORT	pwmInit
				
pwmInit			PROC
	
				PUSH{LR,R1,R0}

				LDR R1, =RCGC0 			; Enable the PWM module
				LDR R0, [R1]
				ORR R0, R0, #0x00100000 ; set bit 0 to enable ADC0 clock
				STR R0, [R1]
				
				LDR R1, =RCC 		; Set the PWM Clock divider to 2
				LDR R0, [R1] 		;
				BIC R0,     #0x001E0000	;
				ORR R0, R0, #0x00100000	;
				STR R0, [R1] 		;
				
				LDR R1, =PWM0CTL 	; Set the PWM control
				MOV R0, #0
				STR R0, [R1]
				
				LDR R1, =PWM0LOAD 	; Set the PWM control (10MHZ CLOCK)
				MOV R0, #1250       ; Corresponds to 8Khz
				STR R0, [R1]
				
				LDR R1, =PWM0INTEN 	; Enable Trigger to ADC (INT NOT ENABLED)
				MOV R0, #0x0100     ;  
				STR R0, [R1]
				
				LDR R1, =PWM0CTL 	; Enable PWM Timers
				MOV R0, #0x01
				STR R0, [R1]
				
				LDR R1, =PWMENABLE 	; Enable PWM Outputs (Not sure if we need this)
				MOV R0, #0x03		;
				STR R0, [R1]
				
				;Set ADC Trigger
				
				POP{LR,R1,R0}
				BX LR
				ENDP
					
				ALIGN	
				END