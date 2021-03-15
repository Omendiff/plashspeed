;----------SEND REMINDER TO BUY INVENTORY
INV_SHIRT PROC NEAR
		XOR AX, AX
		MOV AL, SHIRT_NUM
		CMP AL, RMD
		JGE INV_RET
		
		PRINT INV_M4
		PRINT INV_M3

		INV_RET:
			RET
INV_SHIRT ENDP

INV_SHORTS PROC NEAR
		XOR AX, AX
		MOV AL, SHORTS_NUM
		CMP AL, RMD
		JGE INV_RET2
		
		PRINT INV_M5
		PRINT INV_M3

		INV_RET2:
			RET
INV_SHORTS ENDP
INV_HATS PROC NEAR
		XOR AX, AX
		MOV AL, HATS_NUM
		CMP AL, RMD
		JGE INV_RET3
		
		PRINT INV_M6
		PRINT INV_M3
	
		INV_RET3:
			RET
INV_HATS ENDP

INV_SOCKS PROC NEAR
		XOR AX, AX
		MOV AL, SOCKS_NUM
		CMP AL, RMD
		JGE INV_RET4
		
		PRINT INV_M7
		PRINT INV_M3

		INV_RET4:
			RET
INV_SOCKS ENDP

;-----------------------------------
	


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
