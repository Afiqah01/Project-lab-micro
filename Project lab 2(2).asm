;The first voter
#include<p18F4550.inc>

loop_cnt1	set	0x00
loop_cnt2	set 0x01

			org	0x00
			goto start
			org	0x08
			retfie
			org	0x18
			retfie
		

dup_nop		macro kk
			variable i
i = 0
			while i < kk
			nop
i += 1
			endw
			endm
			

start		SETF	PORTB, A
			CLRF	TRISD, A
			CLRF	TRISB, A	
			CLRF	PORTD, A
		

CHECK		BTFSS	PORTB,0, A
			BRA		LED1
			BRA		CHECK1
CHECK1		BTFSS	PORTB,1, A
			BRA		LED2
			BRA		CHECK


LED1		BSF		PORTD,0, A
			CALL	DELAY
			BCF		PORTD,0, A
			CALL	DELAY
			BRA		CHECK
			
			

LED2		BSF		PORTD,1, A
			CALL	DELAY
			BCF		PORTD,1, A
			CALL	DELAY
			BRA		CHECK1		

			
DELAY		MOVLW D'80'		;1sec delay subroutine for (external loop)
			MOVWF loop_cnt2,A
AGAIN1		MOVLW D'250'		;internal loop
			MOVWF loop_cnt1, A
AGAIN2		dup_nop	   D'247'
			DECFSZ	   loop_cnt1,F,A
			BRA	       AGAIN2
			DECFSZ	   loop_cnt2,F,A
			BRA		   AGAIN1
			NOP
			RETURN
			
			END