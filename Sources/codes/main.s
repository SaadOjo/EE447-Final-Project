STORAGE_STATING_ADDRESS  EQU	0x2000000;

				AREA  main,CODE,READONLY
				THUMB
					
				EXTERN initialize
				EXTERN getVoltage
				EXTERN pwmInit	

				EXPORT	__main
				ENTRY	
__main			
				;Set PLL to 20 MHZ and also set the PIOSC as the oscillator source
				;In the initiallisations use the PIOSC as the clock source?
				
				;Do the initialisations
				
;				BL pwmInit;
				BL initialize; Innitialise ADC and GPIOS
				
				MOV R4, #24000	;Contains the number of samples to be recorded
				LDR R5, =STORAGE_STATING_ADDRESS;
				
colNextSamp		BL getVoltage ; Loop Until Count is less that 24000 (Also stores it)
				CMP R4, #0	  ; R4 is substracted inside the subroutine
				BNE colNextSamp;
				
				;Check if count is less that 24000 then stop the data recording
Done			B		Done
				
				ALIGN	
				END