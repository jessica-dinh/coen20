//Jessica Dinh
//January 23, 2020
//functions.s
//this is the functions code needed for lab 2

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Add
		.thumb_func

Add:								//ADD A AND B
		ADD 	R0,R0,R1
		BX		LR

		.global		Less1
		.thumb_func
		
Less1:								//SUBTRACT A-1
		SUB		R0,1
		BX 		LR
		
		.global 	Square2x
		.thumb_func
		
Square2x:
		PUSH {LR}
		ADD R0,R0,R0 				//X+X
		BL Square					//CALL SQUARE FUNCTION
		POP {PC}
		
		.global 	Last
		.thumb_func
		
Last:
		PUSH {R4,LR}				//save data into R4
		MOV R4,R0					//copy data from R0 to R4
		BL SquareRoot				//call SquareRoot function
		ADD R0,R0,R4
		POP {R4,PC}
	
		.end