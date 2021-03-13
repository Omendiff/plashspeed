;----------SEND REMINDER TO BUY INVENTORY
INV_RMD PROC NEAR
	INV_SHIRT:
		CMP RMD, SHIRT_NUM
		JC INV_SHORTS

		PRINT INV_M4
		PRINT INV_M3
		PRINT SHIRT_NUM

	INV_SHORTS:
		CMP RMD, SHORTS_NUM
		JC INV_HATS

		PRINT INV_M5
		PRINT INV_M3
		PRINT SHORTS_NUM

	INV_HATS:
		CMP RMD, HATS_NUM
		JC INV_SOCKS

		PRINT INV_M6
		PRINT INV_M3
		PRINT HATS_NUM

	INV_SOCKS:
		CMP RMD, SOCKS_NUM
		JC INV_RET

		PRINT INV_M7
		PRINT INV_M3
		PRINT SOCKS_NUM

	INV_RET:
		RET
INV_RMD ENDP


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
