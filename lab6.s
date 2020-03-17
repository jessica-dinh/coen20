//Jessica Dinh
//February 20, 2020
//lab6.s
//this is the functions code needed for lab 6        
		
		.syntax      unified
        .cpu        cortex-m4
        .text

        .global GetBit
        .thumb_func
        //.set BITBANDING,1               //COMMMENT OUT IF NOT USING BITBANDING
        .ifdef BITBANDING
GetBit:     //R0=*bits, R1=row, R2=col
        SUB R3,R0,0x20000000        //compute bit band offset
        LSL R3,R3,5                 //insert into alias address
        ADD R1,R2,R1,LSL 2                //R1=(R1*4)+R2
        ADD R3,R3,R1,LSL 2          //add 4 times bit number
        ADD R3,R3,0x22000000        //add base address of alias region
        LDRH R0,[R3]    
        BX LR


        .else
GetBit:     //R0=*bits, R1=row, R2=col
        LDRH R0,[R0]
        LDR R3,=4
        MUL R1,R1,R3        //R1=row*4
        ADD R1,R1,R2        //R1=(row*4) + col
        LDR R12,=1
        LSL R12,R12,R1
        AND R0,R0,R12       //bit = bit + 1
        LSR R0,R0,R1
        BX LR               //return

        .endif

        .global PutBit
        .thumb_func 
		.ifdef BITBANDING
PutBit: //R0=value, R1=*bits, R2=row, R3=col
        LSL R2,R2,2
        ADD R2,R2,R3			//row = row + col
		SUB R1,R1,0x20000000	//compute bit band offset
		LSL R1,R1,5				//insert offset into alias address
		ADD R1,R1,R2,LSL 2		//add 4 times bit number
		ADD R1,R1,0x22000000	//add base adrs of alias region
		STR R0,[R1]
		BX LR
        .else

PutBit:			//R0=bits, R1=row, R2=col
        PUSH {R4,R5}
        LDRH R5,[R1]
        LDR R12,=4
        MUL R2,R2,R12			//R2 = R2 *12
        ADD R2,R2,R3			//R2 = R2  
        LDR R4,=1
        LSL R4,R4,R2
        CMP R0,0                //compare bit to 0
        ITE EQ                  //use it blocks to compare
        BICEQ R5,R5,R4			//R5 <- R5 & ~R4
        ORRNE R5,R5,R4			//R5 <- R5 | ~R4
        STRH R5,[R1]			//R5 -> R1
        POP {R4,R5}
		BX LR
.endif
.end