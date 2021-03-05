;macro for printing a string
print macro M
mov ah,09h
mov dx,offset M
int 21h
endm

.MODEL SMALL
.STACK 64

;---------------Data Segment----------------
.DATA	;data definition 
	MAIN_MENU DB 10, 13, "-----PLASHSPEED POS-----"
		  DB 10, 13, "1. CHECKOUT"
		  DB 10, 13, "2. INVENTOTY MANAGEMENT"
		  DB 10, 13, "3. CUSTOMER MANAGEMENT"
		  DB 10, 13, "4. SALES REPORTING"
		  DB 10, 13, "5. RETURN AND REFUND"
		  DB 10, 13, "6. STAFF MANAGEMNT"
		  DB 10, 13, "7. EXIT"
		  DB 10, 13, " "
		  DB 10, 13, "CHOICE: $"
	
	STAFF_MENU_1 DB 10, 13, "--STAFF MANAGEMENT--"
		     DB 10, 13, "1. STAFF REPORT"
		     DB 10, 13, "2. STAFF INFO"
		     DB 10, 13, "3. EXIT"
		     DB 10, 13, " "
		     DB 10, 13, "CHOICE $"

	STAFF_MENU_2 DB 10, 13, "----STAFF INFO----"
		     DB 10, 13, "1. CURRENT STAFF"
		     DB 10, 13, "2. NEW STAFF"
		     DB 10, 13, "3. EXIT"
		     DB 10, 13, " "
		     DB 10, 13, "CHOICE $"

	STAFF_MENU_3 DB 10, 13, "--CURRENT STAFF--"
		     DB 10, 13, "1. CHANGE PASSWORD"
		     DB 10, 13, "2. REMOVE STAFF"
		     DB 10, 13, "3. EXIT"
		     DB 10, 13, " "
		     DB 10, 13, "CHOICE $"


;---------------Code Segment----------------
.CODE

START:
	MOV AX,@DATA  ; Define data segment
	MOV DS,AX

;--------------codes
AGAIN:
	PRINT MENU
	CALL ACCEPT
	MOV DS, AX



;---------------end--------------------
	MOV AX,4C00H
	INT 21H




;--------------procedures---------------
;---accept
ACCEPT PROC NEAR 
	MOV AH, 01H
	INT 21H
	RET
ACCEPT ENDP



END START
END
