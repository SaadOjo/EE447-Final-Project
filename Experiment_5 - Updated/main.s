DELTA_VOLT_HEX  EQU	0x3E

				AREA  main,CODE,READONLY
				THUMB
					
				EXTERN initialize
				EXTERN getVoltage
				EXTERN outVolt

				EXPORT	__main
				ENTRY	
__main			
				BL 		initialize	
				MOV		R6,#0; OLD VAL
				MOV		R7,#0; NEV VAL
				MOV		R8,#0;
				NOP
				
nextSample	    BL		getVoltage
				
				MOV 	R7,R1;
				SUB 	R8,R7,R6;
				CMP 	R8,#DELTA_VOLT_HEX;
				BGE		outVoltLinker
				
				SUB 	R8,R6,R7;
				CMP 	R8,#DELTA_VOLT_HEX;
				BGE		outVoltLinker
				
				MOV		R6,R7			  ;R6 = R7
				B		nextSample

				
outVoltLinker	BL 		outVolt
				MOV		R6,R7			  ;R6 = R7	
				B		nextSample
				
Done			B		Done
				
				ALIGN	
				END