;----------SEND REMINDER TO BUY INVENTORY



;-------CAPTURE STRING
	PRINT RTN_M1
;CAPTURE STRING FROM KEYBOARD.                                    
        mov ah, 0Ah ;SERVICE TO CAPTURE STRING FROM KEYBOARD.
        mov dx, offset RTN_ID
        int 21h                 

;CHANGE CHR(13) BY '$'.
        mov si, offset RTN_ID + 1 ;NUMBER OF CHARACTERS ENTERED.
        mov cl, [ si ] ;MOVE LENGTH TO CL.
        mov ch, 0      ;CLEAR CH TO USE CX. 
        inc cx ;TO REACH CHR(13).
        add si, cx ;NOW SI POINTS TO CHR(13).
        mov al, '$'
        mov [ si ], al ;REPLACE CHR(13) BY '$'.            


	RTN_RESULT:
		PRINT RTN_M2
		;---DISPLAY STRING.                   
        mov ah, 9 ;SERVICE TO DISPLAY STRING.
        mov dx, offset RTN_ID + 2 ;MUST END WITH '$'.
        int 21h
