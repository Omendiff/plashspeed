;macro for printing a string
PRINT MACRO M
	MOV AH, 09H
	MOV DX, OFFSET M
	INT 21H
ENDM

.MODEL SMALL
.STACK 64

;---------------Data Segment----------------
.DATA	;data definition 
;---main menu
	MAIN_MENU DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "-----PLASHSPEED POS----- "
			  DB 10, 13, "1. CHECKOUT "
			  DB 10, 13, "2. INVENTORY MANAGEMENT "
			  DB 10, 13, "3. CUSTOMER MANAGEMENT "
			  DB 10, 13, "4. SALES REPORTING "
			  DB 10, 13, "5. RETURN AND REFUND "
			  DB 10, 13, "6. STAFF MANAGEMNT "
			  DB 10, 13, "9. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE: $"
	
;---inventory menu
	INV_MENU DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			 DB 10, 13, "---------INVENTORY MANAGEMENT---------"
			 DB 10, 13, "1. DISPLAY STOCK REPORT"
			 DB 10, 13, "2. UPDATE STOCK"
			 DB 10, 13, "3. SET ORDER REMINDER"
			 DB 10, 13, "4. SEND ORDER REMINDER"
			 DB 10, 13, "5. EXIT"
			 DB 10, 13, " "
			 DB 10, 13, "CHOICE: $"

;---staff menu 1
	STF_MENU1 DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "-----------STAFF MANAGEMENT----------- "
			  DB 10, 13, "1. STAFF REPORT "
			  DB 10, 13, "2. NEW STAFF REGISTER "
			  DB 10, 13, "3. CHANGE PASSWORD OF CURRENT STAFF"
			  DB 10, 13, "4. REMOVE STAFF "
			  DB 10, 13, "5. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE: $" 
;---staff change password
	STF_MENU4 DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "------CHANGE PASSWORD------ "
			  DB 10, 13, "ENTER CURRENT PASSWORD:  "
			  DB 10, 13, "ENTER NEW PASSWORD:  "
			  DB 10, 13, "CONFIRM NEW PASSWORD:  "
	
	OLD_PASS DB 25, ?, 25 DUP('$')


;---return and refund
	RTN_M1 DB 10, 13, "ENTER PRODUCT ID: $"
	RTN_M2 DB 10, 13, "APPROVAL FOR PRODUCT ID: $"
	RTN_M3 DB 10, 13, "1. YES"
		   DB 10, 13, "2. NO "
		   DB 10, 13, " "
		   DB 10, 13, "CHOICE:  $"
	RTN_M4 DB 10, 13, "RETURN SUCCED, PROCEED TO REFUND $"
	RTN_M5 DB 10, 13, "REFUND REQUEST FAIL $"
	buff    db  26        ;MAX NUMBER OF CHARACTERS ALLOWED (25).
            db  ?         ;NUMBER OF CHARACTERS ENTERED BY USER.
            db  26 dup(0) ;CHARACTERS ENTERED BY USER.



;---SYSTEM MESSAGE
	MSG1 DB 10, 13, "EXITING PLASHSPEED..... $"
	MSG2 DB 10, 13, "INVALID CHOICE, PLEASE TRY AGAIN!!! $"
	MSG3 DB 10, 13, "REDIRECTING TO PLASHSPEED..... $"


;---------------Code Segment----------------
.CODE

MAIN PROC
	MOV AX,@DATA  ; Define data segment
	MOV DS,AX

;--------------codes
TOP:
	PRINT MAIN_MENU
	CALL ACCEPT		; USER ENTER CHOICE
	MOV BL, AL
	SUB BL, 30H
	

;---------CHECKOUT------------
CHECKOUT:
	CMP BL, 1		; GO TO INVENTORY IF CHOICE != 1
	JNE INVENTORY

	
	JMP TOP

;---------INVENTORY------------------
INVENTORY:
	CMP BL, 2		; GO TO CUSTOMER IF CHOICE != 2
	JNE CUSTOMER

	PRINT INV_MENU
	CALL ACCEPT
	MOV BL, AL
	SUB BL, 30H

	STK_REPORT:
		CMP BL, 1
		JNE STK_UPDATE

		JMP TOP

	STK_UPDATE:
		CMP BL, 2
		JNE STK_SET_RMD

		JMP TOP

	STK_SET_RMD:
		CMP BL, 3
		JNE STK_RMD

		JMP TOP

	STK_RMD:
		CMP BL, 4
		JNE EXIT_INV

		JMP TOP

	EXIT_INV:
		CMP BL, 5			; EXIT
		JNE STK_INVALID
		PRINT MSG3
		JMP TOP

	STK_INVALID:
		PRINT MSG2
		JMP INVENTORY

	JMP TOP

;--------CUSTOMER MANAGEMENT--------------
CUSTOMER:
	CMP BL, 3		; GO TO SALES IF CHOICE != 3
	JNE SALES


	JMP TOP

;---------SALES REPORTING-------------------
SALES:
	CMP BL, 4		; GO TO RETURN IF CHOICE != 4
	JNE RETURN


	JMP TOP

;---------RETURN AND REFUND----------------
RETURN:
	CMP BL, 5		; GO TO STAFF IF CHOICE != 5
	JNE STAFF

	PRINT RTN_M1
;CAPTURE STRING FROM KEYBOARD.                                    
            mov ah, 0Ah ;SERVICE TO CAPTURE STRING FROM KEYBOARD.
            mov dx, offset buff
            int 21h                 

;CHANGE CHR(13) BY '$'.
            mov si, offset buff + 1 ;NUMBER OF CHARACTERS ENTERED.
            mov cl, [ si ] ;MOVE LENGTH TO CL.
            mov ch, 0      ;CLEAR CH TO USE CX. 
            inc cx ;TO REACH CHR(13).
            add si, cx ;NOW SI POINTS TO CHR(13).
            mov al, '$'
            mov [ si ], al ;REPLACE CHR(13) BY '$'.            

	PRINT RTN_M2
;DISPLAY STRING.                   
            mov ah, 9 ;SERVICE TO DISPLAY STRING.
            mov dx, offset buff + 2 ;MUST END WITH '$'.
            int 21h
	
	RTN_RESULT:
		PRINT RTN_M3
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 30H
			RTN_YES:
				CMP BL, 1
				JNE RTN_NO
				PRINT RTN_M4
				JMP TOP

			RTN_NO:
				CMP BL, 2
				JNE RTN_INVALID
				PRINT RTN_M5
				JMP TOP

			RTN_INVALID:
				PRINT MSG2
				JMP RTN_RESULT

	JMP TOP

;----------STAFF MANAGEMENT---------------
STAFF:
	CMP BL, 6		; EXIT IF CHOICE != 6
	JNE EXIT

	PRINT STF_MENU1		
	CALL ACCEPT		; USER ENTER CHOICE
	MOV BL, AL
	SUB BL, 48

	STF_REPORT:
		CMP BL, 1			; REPORT
		JNE STF_NEW



		JMP TOP

	STF_NEW:			; NEW STAFF START
		CMP BL, 2
		JNE CHANGE_PASS


		JMP TOP			; NEW STAFF END

	CHANGE_PASS:
		CMP BL, 3
		JNE STF_REMOVE


		JMP TOP

	STF_REMOVE:
		CMP BL, 4
		JNE EXIT_STAFF


		JMP TOP

	EXIT_STAFF:
		CMP BL, 5			; EXIT
		JNE STF_INVALID
			PRINT MSG3
			JMP TOP

	STF_INVALID:
		PRINT MSG2
		JMP STAFF

;-------EXIT----------------------
EXIT:
	CMP BL, 9
	JNE INVALID
		PRINT MSG1
		JMP QUIT 

;------INVALID CHOICE----------------
INVALID:
	PRINT MSG2
	JMP TOP







;;---CHANGE PASSWORD------------------------------------------
;CHANGE_PASS:
;	MOV AH, 09H
;	LEA DX, STF_M19
;	INT 21H
;
;	MOV AH, 09H
;	LEA DX, STF_M20
;	INT 21H
;
;	MOV AH, 01H
;	LEA DX, OFFSET OLD_PASS
;	INT 21H








;--------ACCEPT CHOICE PROCEDURE
ACCEPT PROC NEAR
	MOV AH, 01H
	INT 21H


	RET
ACCEPT ENDP
;--------------EXIT PROGRAM
QUIT:				; EXIT PROGRAM
	MOV AH, 4CH
	INT 21H

	MAIN ENDP
END MAIN