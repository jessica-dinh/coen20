//Jessica Dinh
//February 28, 2020
//lab7.s
//this is the functions code needed for lab 7

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Bills
		.thumb_func
Bills:
		LDR R2,=214748365		//(2^32)/20
		SMMUL R2,R0,R2
		STR R2,[R1],4
		LSL R12,R2,4			//R12=(R2*16)
		ADD R2,R12,R2,LSL 2		//R2=(R2*20)
		SUB R0,R0,R2			//find remaining dollars
 
Others:
		LDR R3,=429496730		//(2^32)/10
		SMMUL R3,R0,R3
		STR R3,[R1],4
		LSL R12,R3,3			//R12=(R3*8)
		ADD R3,R12,R3,LSL 1		//R3=(R3*10)
		SUB R0,R0,R3			//remainder for 5
		
		LDR R3,=858993460		//(2^32)/5
		SMMUL R3,R0,R3
		STR R3,[R1],4
		LSL R12,R3,2			//R12=(4*R3)
		ADD R3,R12,R3			//R3=(5*R3)
		SUB R0,R0,R3			//remainder for 1
		STR R0,[R1]
		BX LR

		.global 	Coins
		.thumb_func
Coins:
		LDR R2,=171798692		//(2^32)/25
		SMMUL R2,R0,R2
		STR R2,[R1],4
		ADD R12,R2,R2,LSL 4		//R2=(R2*17)
		ADD R2,R12,R2,LSL 3		//R2=(R2*25)
		SUB R0,R0,R2
		B Others				//call others funtion
.end