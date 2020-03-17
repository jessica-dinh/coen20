#include <stdio.h>

int32_t     Bits2Signed(int8_t bits[8]);				
uint32_t    Bits2Unsigned(int8_t bits[8]);				
void        Increment(int8_t bits[8]);				
void        Unsigned2Bits(uint32_t n, int8_t bits[8]);

int32_t Bits2Signed(int8_t bits[8]) {
    int32_t val = Bits2Unsigned(bits);				//binary to unsigned integers
    if(val > 127) {						
		val -= 256;
	}
	return val;					
}

uint32_t Bits2Unsigned(int8_t bits[8]) {
    uint32_t val = 0;		
    int i;

    for(i=7; i>=0; i--) {				
        val = 2*val + bits[i];		//polynomial expansion
    }
    
    return val;						   
}

void Increment(int8_t bits[8]) {
    int i;
    for(i = 0; i < 8; i++) {						
        if(bits[i] == 0) {						
            bits[i] = 1;		//if 0, increment to 1
            break;				
        }
        if(bits[i] == 1) {			//if 1, then continue loop and change to 0
            bits[i] = 0;
        }
    }
	return;						
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]) {
    int i = 0;
    int r;
    while(i < 8) {			 //repeated division				
        r = n % 2;						
        n = n / 2;						
        bits[i] = r;					
        i++;			
    }
    return;			
}