STORAGE_STATING_ADDRESS  EQU	0x2000000;

				AREA  main,CODE,READONLY
				THUMB
					
				EXTERN initialize
				EXTERN getVoltage
				EXTERN outVolt

				EXPORT	__main
				ENTRY	
__main			
				;DISABLE INT
				
				;Do the initialisations
				
				MOV R4, #24000	;Contains the number of samples to be recorded
				LDR R5, #STORAGE_STATING_ADDRESS;
				
				;Check if count is less that 24000 then stop the data recording
				
				
				
				;Enable Interrupts
				
				
Done			B		Done
				
				ALIGN	
				END