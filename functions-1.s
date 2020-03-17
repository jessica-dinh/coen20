//Jessica Dinh
//January 30, 2020
//lab3.s
//this is the functions code needed for lab 3
 
        .syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		UseLDRB
		.thumb_func

UseLDRB:           //void UseLDRB(void *dst, void *src)
                    //dst in R0, scr in R1
        .rept 512		// 512/1 = 512
        LDRB R2,[R1],1 //Read content and increment by 1 byte
        STRB R2,[R0],1 //Store content to R0 and increment 1
        .endr
        BX LR

        .global     UseLDRH
        .thumb_func
UseLDRH:
        .rept 256		// 512 / 2 = 256 
        LDRH R2,[R1],2 //Read content and increment by 2 bytes
        STRH R2,[R0],2 //Store content to dst and increment by 2
        .endr
        BX LR

        .global     UseLDR
        .thumb_func
UseLDR:
        .rept 128		// 512 / 4 = 128
        LDR R2,[R1],4 //Read content and increment by 4 bytes
        STR R2,[R0],4 //Store content to dst and increment by 4
        .endr
        BX LR

        .global     UseLDRD
        .thumb_func
UseLDRD:
        .rept 64			// 512 / 8 = 64
        LDRD R2,R3,[R1],8 //Load 64 bits to R2 and R3 and increment by 8 bytes
        STRD R2,R3,[R0],8 //Store 64 bits to dst and increment by 8
        .endr
        BX LR

        .global     UseLDM
        .thumb_func
UseLDM:
        PUSH {R4-R9} //use reg R4-R9 as placeholders
        .rept 16			// 512/32 = 16
        LDMIA R1!,{R2-R9} //load content from R1 to R2-R9
        STMIA R0!, {R2-R9} //store content of R2-R9 
        .endr
        POP {R4-R9}		//Reset original R4-R9 data
		BX LR

        .end