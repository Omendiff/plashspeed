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

;---CONSTANTS
	TEN DB 10
	HUN DB 100
	CC  DB 0			;CHOICE FOR MAIN MENU
	TAX DB 6
	POINTS DB 10
	DISCOUNT DB 5
	

;---PRICE OF PRODUCTS
	SHIRT DB 10
	SHORTS DB 15
	HATS DB 6
	SOCKS DB 5
;---AMOUNT OF PRODUCTS IN STOCK
	SHIRT_NUM DB 50
	SHORTS_NUM DB 60
	HATS_NUM DB 70
	SOCKS_NUM DB 30
	SHIRT_NUMD DB 0, 0
	SHORTS_NUMD DB 0, 0
	HATS_NUMD DB 0, 0
	SOCKS_NUMD DB 0, 0

;---main menu
	MAIN_MENU DB 10, 13, 10, 13, "-----PLASHSPEED POS----- "
			  DB 10, 13, "1. CHECKOUT "
			  DB 10, 13, "2. INVENTORY MANAGEMENT "
			  DB 10, 13, "3. CUSTOMER MANAGEMENT "
			  DB 10, 13, "4. SALES REPORTING "
			  DB 10, 13, "5. RETURN AND REFUND "
			  DB 10, 13, "6. STAFF MANAGEMNT "
			  DB 10, 13, "9. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE: $"

;---product menu
	PRO_MENU DB 10, 13, "-------PRODUCT MENU------- "
			 DB 10, 13, "1. SHIRT"
			 DB 10, 13, "2. SHORTS"
			 DB 10, 13, "3. HATS"
			 DB 10, 13, "4. SOCKS"
			 DB 10, 13, "9. EXIT"
			 DB 10, 13, " "
			 DB 10, 13, "CHOICE: $"




;---inventory menu
	INV_MENU DB 10, 13, 10, 13, "---------INVENTORY MANAGEMENT---------"
			 DB 10, 13, "1. DISPLAY STOCK REPORT"
			 DB 10, 13, "2. UPDATE STOCK"
			 DB 10, 13, "3. SET ORDER REMINDER"
			 DB 10, 13, "4. SEND ORDER REMINDER"
			 DB 10, 13, "5. EXIT"
			 DB 10, 13, " "
			 DB 10, 13, "CHOICE: $"
	INV_M1 DB 10, 13, "MIN NUMBER OF PRODUCT IN STORE: $"
	INV_M2 DB 10, 13, "SEND REMINDER WHEN LIMIT REACH $"
	INV_M3 DB "IS LOW IN STOCK. STOCK AMOUNT: $"
	INV_M4 DB 10, 13, "SHIRT $"
	INV_M5 DB 10, 13, "SHORTS $"
	INV_M6 DB 10, 13, "HATS $"
	INV_M7 DB 10, 13, "SOCKS $"
	INV_M DB 10, 13, " $"
	RMD DB 0, 0
	RMDD DB 40

;---staff menu 1
	STF_MENU1 DB 10, 13, 10, 13, "-----------STAFF MANAGEMENT----------- "
			  DB 10, 13, "1. STAFF REPORT "
			  DB 10, 13, "2. NEW STAFF REGISTER "
			  DB 10, 13, "3. CHANGE PASSWORD OF CURRENT STAFF"
			  DB 10, 13, "4. REMOVE STAFF "
			  DB 10, 13, "5. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE: $" 
;---staff change password
	STF_M1 DB 10, 13, 10, 13, "------CHANGE PASSWORD------ "
		   DB 10, 13, "ENTER CURRENT PASSWORD: $"
	STF_M2 DB 10, 13, "ENTER NEW PASSWORD: $"
	STF_M3 DB 10, 13, "CONFIRM NEW PASSWORD: $"
	STF_M4 DB 10, 13, "INVALID PASSWORD!!! $"
	
	OLD_PSW DB 26, ?, 26 DUP('$')
	NEW_PSW DB 26, ?, 26 DUP('$')
	CON_PSW DB 26, ?, 26 DUP('$')

;---checkout message
	checkOut_M1 DB 13,10, "PLEASE ENTER CHOICE: $"
	checkOut_M2 DB 13,10, "PLEASE ENTER QUANTITY: $"
	checkOut_M3 DB 13,10, "ANYTHING TO ADD ON? $"
	checkOut_M4 DB 13,10, "Membership? 1.Yes 2.No $"
	checkOut_M5 DB 13,10, "THE TOTAL PRICE: RM $"
	CHECKOUT_QTY DB 0,0,0
	CHECKOUT_TOTAL DB 0,0,0

;---return and refund
	RTN_M1 DB 10, 13, "ENTER QUANTITY TO RETURN: $"
	RTN_M2 DB 10, 13, 10, 13, "TOTAL REFUND AMOUNT IS RM $"
	RTN_M3 DB 10, 13, "RETURN SUCCEED, PROCEED TO REFUND.... $"
	RTN_QTY DB 0, 0, 0
	RTN_TOT DB 0, 0, 0

;---SYSTEM MESSAGE
	MSG1 DB 10, 13, "EXITING PLASHSPEED..... $"
	MSG2 DB 10, 13, "INVALID CHOICE, PLEASE TRY AGAIN!!! $"
	MSG3 DB 10, 13, "REDIRECTING TO PLASHSPEED..... $"
	

	

;---------------Code Segment----------------
.CODE

MAIN PROC
	MOV AX,@DATA  ; Define data segment
	MOV DS,AX

	MOV AX, 03H
	INT 10H
;--------------codes
TOP:
	PRINT MAIN_MENU
	CALL ACCEPT		; USER ENTER CHOICE
	MOV CC, AL
	SUB CC, 30H
	

;---------CHECKOUT------------
CHECKOUT:
	CMP CC, 1		; GO TO INVENTORY IF CHOICE != 1
	JNE INVENTORY

	PRINT PRO_MENU
	CALL CHECKOUT_CAL	;CALCULATE TOTAL PRICE OF PRODUCTS


	
	PRINT MSG3
	JMP TOP

;---------INVENTORY------------------
INVENTORY:
	CMP CC, 2		; GO TO CUSTOMER IF CHOICE != 2
	JNE CUSTOMER

	PRINT INV_MENU
	CALL ACCEPT
	MOV BL, AL
	SUB BL, 30H

	STK_REPORT:
		CMP BL, 1
		JNE STK_UPDATE

		CALL INV_REPORT

		PRINT MSG3
		JMP TOP

	STK_UPDATE:
		CMP BL, 2
		JNE STK_SET_RMD


		PRINT MSG3
		JMP TOP

	STK_SET_RMD:
		CMP BL, 3
		JNE STK_RMD

		CALL INV_SETRMD

		PRINT MSG3
		JMP TOP
	STK_RMD:
		CMP BL, 4
		JNE EXIT_STK

		CALL INV_SHIRT
		CALL INV_SHORTS
		CALL INV_HATS
		CALL INV_SOCKS
		

		PRINT MSG3
		JMP TOP

	EXIT_STK:
		CMP BL, 5			; EXIT
		JNE STK_INVALID
		PRINT MSG3
		JMP TOP

	STK_INVALID:
		PRINT MSG2
		JMP INVENTORY

	PRINT MSG3
	JMP TOP

;--------CUSTOMER MANAGEMENT--------------
CUSTOMER:
	CMP CC, 3		; GO TO SALES IF CHOICE != 3
	JNE SALES


	PRINT MSG3
	JMP TOP

;---------SALES REPORTING-------------------
SALES:
	CMP CC, 4		; GO TO RETURN IF CHOICE != 4
	JNE RETURN


	PRINT MSG3
	JMP TOP

;---------RETURN AND REFUND----------------
RETURN:
	CMP CC, 5		; GO TO STAFF IF CHOICE != 5
	JNE STAFF

	PRINT PRO_MENU
	CALL RTN_CAL	; CAL TOTAL
	PRINT RTN_M3

	PRINT MSG3
	JMP TOP
;----------STAFF MANAGEMENT---------------
STAFF:
	CMP CC, 6		; EXIT IF CHOICE != 6
	JNE EXIT

	PRINT STF_MENU1		
	CALL ACCEPT		; USER ENTER CHOICE
	MOV BL, AL
	SUB BL, 48

	STF_REPORT:
		CMP BL, 1			; REPORT
		JNE STF_NEW


		PRINT MSG3
		JMP TOP

	STF_NEW:			; NEW STAFF START
		CMP BL, 2
		JNE CHANGE_PASS


		PRINT MSG3
		JMP TOP			; NEW STAFF END

	CHANGE_PASS:
		CMP BL, 3
		JNE STF_REMOVE

		PRINT STF_M1
		MOV  AH, 0AH
		MOV DX, OFFSET OLD_PSW
		INT 21H




		PRINT MSG3
		JMP TOP

	STF_REMOVE:
		CMP BL, 4
		JNE EXIT_STAFF


		PRINT MSG3
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
	CMP CC, 9
	JNE INVALID
		PRINT MSG1
		JMP QUIT 

;------INVALID CHOICE----------------
INVALID:
	PRINT MSG2
	JMP TOP

;--------ACCEPT CHOICE PROCEDURE
ACCEPT PROC NEAR
	MOV AH, 01H
	INT 21H
	RET
ACCEPT ENDP

;------------STOCK REPORT
INV_REPORT PROC NEAR
	XOR AX, AX
	MOV AL, SHIRT_NUM
	DIV TEN
	MOV SHIRT_NUM(0), AL
	MOV SHIRT_NUM(1), AH
	ADD SHIRT_NUM(0), AL
	ADD SHIRT_NUM(1), AH
	MOV AH, 02H
	MOV DL, SHIRT_NUM(0)
	INT 21H
	MOV AH, 02H
	MOV DL, SHIRT_NUM(1)
	INT 21H	

	RET
INV_REPORT ENDP

;------------SET REMAINDER TO BUY STOCK
INV_SETRMD PROC NEAR
	PRINT INV_M1
	MOV AH, 01H		; DIGIT 1
	INT 21H
	MOV RMD(0), AL
	MOV AH, 01H		; DIGIT 2
	INT 21H
	MOV RMD(1), AL
	PRINT INV_M2	
	MOV AH, 02H		; PRINT DIGIT 1
	MOV DL, RMD(0)
	INT 21H
	MOV AH, 02H		; PRINT DIGIT 2
	MOV DL, RMD(1)
	INT 21H

	SUB RMD(0), 30H
	SUB RMD(1), 30H
	XOR AX, AX
	MOV AL, RMD(0)
	MUL TEN
	ADD AL, RMD(1)
	ADD RMD(0), 30H
	ADD RMD(1), 30H
	
	RET
INV_SETRMD ENDP

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

;-------------CALCULATE TOTAL REFUND AMOUNT
RTN_CAL PROC NEAR
		MOV AH, 01H
		INT 21H
		MOV DL, AL
		SUB DL, 30H
		RTN_SHIRT:
			CMP DL, 1
			JNE RTN_SHORTS

			PRINT RTN_M1
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV RTN_QTY(0), AL
			SUB RTN_QTY(0), 30H
			MOV AH, 01H		; DIGIT 2
			INT 21H				
			MOV RTN_QTY(1), AL
			SUB RTN_QTY(1), 30H
			XOR AX, AX				; COMBINE DIGIT1 & DIGIT 2
			MOV AL, RTN_QTY(0)
			MUL TEN
			ADD AL, RTN_QTY(1)
			
			XOR DX, DX
			XOR BX, BX
			MUL SHIRT				; PRICE OF PRODUCT
			DIV HUN
			MOV RTN_TOT(0), AL
			MOV DL, AH
			XOR AX,AX
			MOV AL, DL	
			DIV Ten		
			MOV RTN_TOT(1), AL
			MOV RTN_TOT(2), AH
			ADD RTN_TOT(0), 30H
			ADD RTN_TOT(1), 30H
			ADD RTN_TOT(2), 30H
			PRINT RTN_M2
			MOV AH, 02H
			MOV DL, RTN_TOT(0)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(1)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(2)
			INT 21H
		
			RET
		RTN_SHORTS:
			CMP DL, 2
			JNE RTN_HATS

			PRINT RTN_M1
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV RTN_QTY(0), AL
			SUB RTN_QTY(0), 30H
			MOV AH, 01H		; DIGIT 2
			INT 21H				
			MOV RTN_QTY(1), AL
			SUB RTN_QTY(1), 30H
			XOR AX, AX				; COMBINE DIGIT1 & DIGIT 2
			MOV AL, RTN_QTY(0)
			MUL TEN
			ADD AL, RTN_QTY(1)
			XOR DX, DX
			XOR BX, BX

			MUL SHORTS				; PRICE OF PRODUCT
			DIV HUN
			MOV RTN_TOT(0), AL
			MOV DL, AH
			XOR AX,AX
			MOV AL, DL	
			DIV Ten		
			MOV RTN_TOT(1), AL
			MOV RTN_TOT(2), AH
			ADD RTN_TOT(0), 30H
			ADD RTN_TOT(1), 30H
			ADD RTN_TOT(2), 30H
			PRINT RTN_M2
			MOV AH, 02H
			MOV DL, RTN_TOT(0)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(1)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(2)
			INT 21H

			RET
		RTN_HATS:
			CMP DL, 3
			JNE RTN_SOCKS

			PRINT RTN_M1
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV RTN_QTY(0), AL
			SUB RTN_QTY(0), 30H
			MOV AH, 01H		; DIGIT 2
			INT 21H				
			MOV RTN_QTY(1), AL
			SUB RTN_QTY(1), 30H
			XOR AX, AX				; COMBINE DIGIT1 & DIGIT 2
			MOV AL, RTN_QTY(0)
			MUL TEN
			ADD AL, RTN_QTY(1)
			XOR DX, DX
			XOR BX, BX

			MUL HATS				; PRICE OF PRODUCT
			DIV HUN
			MOV RTN_TOT(0), AL
			MOV DL, AH
			XOR AX,AX
			MOV AL, DL	
			DIV Ten		
			MOV RTN_TOT(1), AL
			MOV RTN_TOT(2), AH
			ADD RTN_TOT(0), 30H
			ADD RTN_TOT(1), 30H
			ADD RTN_TOT(2), 30H
			PRINT RTN_M2
			MOV AH, 02H
			MOV DL, RTN_TOT(0)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(1)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(2)
			INT 21H

			RET
		RTN_SOCKS:
			CMP DL, 4
			JNE RTN_EXIT

			PRINT RTN_M1
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV RTN_QTY(0), AL
			SUB RTN_QTY(0), 30H
			MOV AH, 01H		; DIGIT 2
			INT 21H				
			MOV RTN_QTY(1), AL
			SUB RTN_QTY(1), 30H
			XOR AX, AX				; COMBINE DIGIT1 & DIGIT 2
			MOV AL, RTN_QTY(0)
			MUL TEN
			ADD AL, RTN_QTY(1)
			XOR DX, DX
			XOR BX, BX

			MUL SOCKS				; PRICE OF PRODUCT
			DIV HUN
			MOV RTN_TOT(0), AL
			MOV DL, AH
			XOR AX,AX
			MOV AL, DL	
			DIV Ten		
			MOV RTN_TOT(1), AL
			MOV RTN_TOT(2), AH
			ADD RTN_TOT(0), 30H
			ADD RTN_TOT(1), 30H
			ADD RTN_TOT(2), 30H
			PRINT RTN_M2
			MOV AH, 02H
			MOV DL, RTN_TOT(0)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(1)
			INT 21H
			MOV AH, 02H
			MOV DL, RTN_TOT(2)
			INT 21H

			RET
		RTN_EXIT:
			CMP DL, 9			; EXIT
			JNE RTN_INVALID
			PRINT MSG3
			JMP TOP

		RTN_INVALID:
			PRINT MSG2
			JMP RETURN

			RET
RTN_CAL ENDP


;--------------EXIT PROGRAM
QUIT:				; EXIT PROGRAM
	MOV AH, 4CH
	INT 21H

	MAIN ENDP
END MAIN