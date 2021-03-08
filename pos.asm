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
			  DB 10, 13, "7. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE: $"
	


;---staff menu 1
	STF_MENU1 DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "--STAFF MANAGEMENT-- "
			  DB 10, 13, "1. STAFF REPORT "
			  DB 10, 13, "2. STAFF INFO "
			  DB 10, 13, "3. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE $" 
;---staff menu 2
	STF_MENU2 DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "----STAFF INFO---- "
			  DB 10, 13, "1. CURRENT STAFF "
			  DB 10, 13, "2. NEW STAFF "
			  DB 10, 13, "3. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE $"
;---staff menu 3
	STF_MEBU3 DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "----CURRENT STAFF---- "
			  DB 10, 13, "1. CHANGE PASSWORD "
			  DB 10, 13, "2. REMOVE STAFF "
			  DB 10, 13, "3. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE $"
;---staff change password
	STF_MENU4 DB 10, 13, "XXXXXXXXXXXXXXXXXXXXXXXXXXX "
			  DB 10, 13, "------CHANGE PASSWORD------ "
			  DB 10, 13, "ENTER CURRENT PASSWORD:  "
			  DB 10, 13, "ENTER NEW PASSWORD:  "
			  DB 10, 13, "CONFIRM NEW PASSWORD:  "
	
	OLD_PASS DB 25, ?, 25 DUP('$')




;---SYSTEM MESSAGE
	MSG1 DB 10, 13, "EXITING PLASHSPEED..... $"
	MSG2 DB 10, 13, "INVALID CHOICE, PLEASE TRY AGAIN!!! $"

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
	SUB BL, 48
	

;---------CHECKOUT------------
CHECKOUT:
	CMP BL, 1		; GO TO INVENTORY IF CHOICE != 1
	JNE INVENTORY

	
	JMP TOP

;---------INVENTORY------------------
INVENTORY:
	CMP BL, 2		; GO TO CUSTOMER IF CHOICE != 2
	JNE CUSTOMER


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
		JNE STF_INFO


		JMP TOP

	STF_INFO:
		CMP BL, 2			; INFO
		JNE EXIT_MAIN

		PRINT STF_MENU2		; USER ENTER CHOICE
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 48

		STF_CURRENT:
			CMP BL, 1
			JNE STF_NEW


			JMP TOP

		STF_NEW:
			CMP BL, 2
			JNE EXIT_STF_INFO


			JMP TOP

		EXIT_STF_INFO:
			CMP BL, 3
			JNE STF_INVALID2
			
			PRINT MSG1
			JMP TOP

		STF_INVALID2:
			PRINT MSG2
			JMP STF_INFO


		JMP TOP			;STAFF END





	EXIT_MAIN:
		CMP BL, 3			; EXIT
		JNE STF_INVALID1
			PRINT MSG1
			JMP TOP

	STF_INVALID1:
		PRINT MSG2
		JMP STAFF

;-------EXIT----------------------
EXIT:
	CMP BL, 7
	JNE INVALID
		PRINT MSG1
		JMP QUIT 

;------INVALID CHOICE----------------
INVALID:
	PRINT MSG2
	JMP TOP





;STF_CURRENT:
;	PRINT STF_MENU3
;
;	MOV AH, 01H			; USER ENTER CHOICE
;	INT 21H
;	MOV DL, AL
;	SUB DL, 48
;
;	CMP DL, 1			; CHANGE PASSWORD
;	JE CHANGE_PASS
;
;;	CMP DL, 2			; REMOVE STAFF
;;	JE STF_REMOVE
;
;;	CMP DL, 3			; EXIT
;;	JE STF_INFO
;
;	JMP STF_INVALID3	; INVALID
;
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
;
;
;
;;---INVALID CHOICE STAFF

;STF_INVALID3:
;	MOV AH, 09H
;	LEA DX, MSG2
;	INT 21H
;	JMP STF_CURRENT







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