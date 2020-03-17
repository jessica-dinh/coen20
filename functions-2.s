//Jessica Dinh
//February 6, 2020
//lab4.s
//this is the functions code needed for lab 4
 
        .syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Discriminant
		.thumb_func
Discriminant:
		MUL R1,R1,R1			//R1=b*b
		LSL R0,R0,2				//R0=4*a
		MLS R0,R0,R2,R1			//R0=b*b - 4*a*c
		BX LR
		
		.global		Root1
		.thumb_func
Root1:							//find positive root
		PUSH {R4,R5,LR}
		NEG R5,R1				//store -b in R1
		LSL R4,R0,1
		BL Discriminant			//call Discriminant function
		BL SquareRoot			//call SquareRoot function
		ADD R0,R5,R0			//-b + SquareRoot(Discriminant(a,b,c))
		SDIV R0,R0,R4
		POP {R4,R5,PC}
		
		.global		Root2
		.thumb_func
Root2:							//find negative root
		PUSH {R4,R5,LR}
		NEG R5,R1
		LSL R4,R0,1
		BL Discriminant			//call Discriminant function
		BL SquareRoot			//call SquareRoot function
		SUB R0,R5,R0			//-b - SquareRoot(Discriminant(a,b,c))
		SDIV R0,R0,R4
		POP {R4,R5,PC}
		
		.global 	Quadratic
		.thumb_func	
Quadratic:						// ax^2 + bx +c
		PUSH {R4}
		MOV R4,R0
		MUL R0,R4,R4			//x^2
		MLA R0,R1,R0,R3			//ax^2 + c
		MLA R0,R4,R2,R0			//ax^2 + bx + c
		POP {R4}
		BX LR
.end