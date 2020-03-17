//Jessica Dinh
//February 13, 2020
//lab5.s
//this is the functions code needed for lab 5
 
        .syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		CopyCell
		.thumb_func
//dst in R0, scr in R1
CopyCell:
		PUSH {R4}		//dont need LR cuz not calling another function
		LDR R2,=0		//row variable
for_1:
		LDR R3,=0		//col variable
		CMP R2,60
		BHS done		//when row >= 60 then go to done
for_2:
		CMP R3,60
		BHS loop_1
		LDR R4,[R1,R3,LSL 2]	//R4=scr[col]
		STR R4,[R0,R3,LSL 2]	//R4 -> dst[col]
		ADD R3,R3,1				//col++
		B for_2
loop_1:
		ADD R0,R0,960
		ADD R1,R1,960
		ADD R2,R2,1
		B for_1		
done:
		POP {R4}
		BX LR
		
		.global 	FillCell
		.thumb_func
//dst in R0, pixel in R1
FillCell:
		LDR R2,=0 		//row variable
for1_1:
		LDR R3,=0		//col variable
		CMP R2,60		//when row >= 60 then go to done1
		BHS done1
for1_2:
		
		CMP R3,60
		BHS loop1_1
		STR R1,[R0,R3,LSL 2]	//pixel -> dst[col]
		ADD R3,R3,1
		B for1_2
loop1_1:
		ADD R0,R0,960
		ADD R2,R2,1			//row++
		B for1_1
done1:
		BX LR

.end