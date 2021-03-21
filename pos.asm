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

;------LOGIN 
  	LOGIN_M1 DB 10, 13, "------PLASHSPEED POS------"
  			 DB 10, 13, "ENTER USERNAME: $"
	LOGIN_M2 DB 10, 13, "ENTER PASSWORD: $"
	LOGIN_M3 DB 13, 10, "-----ACCESS GRANTED-----$"
	LOGIN_M4 DB 13, 10, "-----ACCESS DENIED-----"
			 DB 13, 10, "PLEASE LOGIN AGAIN!!!$"
	;DATABASE FOR ACCOUNT
	UNAME	DB "QWE"
	UPWD	DB "1234"	;STORE AS STRING
	
	;USER INPUT
	INAME	DB 3 DUP (0)	;INAME = 0,0,0
	IPWD	DB 4 DUP (0)	;IPWD = 0,0,0,0

;---CONSTANTS
	TEN DB 10
	HUN DB 100
	CC  DB 0			;CHOICE FOR MAIN MENU
	TAX DB 106
	POINTS DB 10
	DISCOUNT DB 95


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
	SHIRT_NUMD DB 0, 0, 0
	SHORTS_NUMD DB 0, 0, 0
	HATS_NUMD DB 0, 0, 0
	SOCKS_NUMD DB 0, 0, 0

;---main menu
	MAIN_MENU DB 10, 13, 10, 13, "-----PLASHSPEED POS----- "
			  DB 10, 13, " 1. CHECKOUT "
			  DB 10, 13, " 2. INVENTORY MANAGEMENT "
			  DB 10, 13, " 3. CUSTOMER MANAGEMENT "
			  DB 10, 13, " 4. SALES REPORTING "
			  DB 10, 13, " 5. RETURN AND REFUND "
			  DB 10, 13, " 6. STAFF MANAGEMNT "
			  DB 10, 13, " 9. EXIT "
			  DB 10, 13, "  "
			  DB 10, 13, "CHOICE: $"

;---product menu
	PRO_MENU DB 10, 13, "-------PRODUCT MENU------- "
			 DB 10, 13, " 1. SHIRT"
			 DB 10, 13, " 2. SHORTS"
			 DB 10, 13, " 3. HATS"
			 DB 10, 13, " 4. SOCKS"
			 DB 10, 13, " 9. EXIT"
			 DB 10, 13, " "
			 DB 10, 13, "CHOICE: $"


;---inventory menu
	INV_MENU DB 10, 13, 10, 13, "---------INVENTORY MANAGEMENT---------"
			 DB 10, 13, " 1. DISPLAY STOCK REPORT"
			 DB 10, 13, " 2. UPDATE STOCK"
			 DB 10, 13, " 3. SET ORDER REMINDER"
			 DB 10, 13, " 4. SEND ORDER REMINDER"
			 DB 10, 13, " 9. EXIT"
			 DB 10, 13, " "
			 DB 10, 13, "CHOICE: $"
	;----SET REMINDER
	INV_M1 DB 10, 13, "MIN NUMBER OF PRODUCT IN STORE: $"
	INV_M2 DB 10, 13, "SEND REMINDER WHEN LIMIT REACH $"
	INV_M3 DB "IS LOW IN STOCK. PLEASE ORDER NOW!!!$"
	INV_M4 DB 10, 13, "SHIRT $"
	INV_M5 DB 10, 13, "SHORTS $"
	INV_M6 DB 10, 13, "HATS $"
	INV_M7 DB 10, 13, "SOCKS $"
	INV_V1 DB 0
	INV_V2 DB 0
	INV_V3 DB 0
	INV_V4 DB 0
	RMD DB 0, 0
	RRMD DB 0
	;---STOCK REPORT
	INV_M8 DB 10, 13, "-------STOCK REPORT-------"
		   DB 10, 13, "ITEM      QUANTITY "
		   DB 10, 13, " SHIRT      $"
	INV_M9 DB 10, 13, " SHORTS     $"
	INV_M10 DB 10, 13, " HATS       $"
	INV_M11 DB 10, 13, " SOCKS      $"
	;---UPDATE STOCK
	INV_M12 DB 10, 13, "ENTER QUANTITY: $"
	INV_M13 DB 10, 13, "TOTAL QUANTITY: $"
	SHIRT_NUM_UP DB 0, 0
	SHORTS_NUM_UP DB 0, 0
	HATS_NUM_UP DB 0, 0
	SOCKS_NUM_UP DB 0, 0
	;----PRICE STOCK
	INV_M14 DB 10, 13, "ENTER PERCENTAGE OF INCREASE: $"
	SHIRT_NP DB 0
	INV_M DB 10, 13, " $"


;---staff menu 1
	STF_MENU1 DB 10, 13, 10, 13, "-----------STAFF MANAGEMENT----------- "
			  DB 10, 13, " 1. NEW STAFF REGISTER "
			  DB 10, 13, " 2. CHANGE PASSWORD"
			  DB 10, 13, " 3. REMOVE STAFF "
			  DB 10, 13, " 9. LOG OUT "
			  DB 10, 13, "   "
			  DB 10, 13, "CHOICE: $" 
;---staff change password
	STF_M1 DB 10, 13, 10, 13, "------CHANGE PASSWORD------ "
		   DB 10, 13, "   *** 4 CHARACTERS *** "
		   DB 10, 13, "ENTER NEW PASSWORD  : $"
	STF_M2 DB 10, 13, "CONFIRM NEW PASSWORD: $"
	STF_M3 DB 10, 13, "2 PASSWORS MUST BE SAME!!! $"
	STF_M4 DB 10, 13, 10, 13, "PASSWORD RESET SUCCEED!!!$"
	STF_M14 DB 10, 13, "TRY AGAIN??"
			DB 10, 13, " 1. YES"
			DB 10, 13, " 2. NO"
			DB 10, 13, 10, 13, "CHOICE: $"
	NEW_PSW DB 8 DUP(0)
	CON_PSW DB 8 DUP(0)
;---REMOVE STAFF
	STF_M5 DB 10, 13, 10, 13, "ENTER NAME: $"
	STF_M6 DB 10, 13, "CONFIRM TO REMOVE STAFF: $"
	STF_M7 DB " ???"
		   DB 10, 13, " 1. YES"
		   DB 10, 13, " 2. NO "
		   DB 10, 13, 10, 13, "CHOICE: $"
	STF_M8 DB 10, 13, "STAFF REMOVAL SUCCEED $"
	STF_M9 DB 10, 13, "STAFF REMOVAL FAIL $"
	STF_ID_RMV DB 16, ?, 16 DUP('$')
;---ADD STAFF
	STF_M10 DB 10, 13, "CONFIRM TO ADD STAFF: $"
	STF_M11 DB " ???"
		    DB 10, 13, " 1. YES"
		    DB 10, 13, " 2. NO "
		    DB 10, 13, 10, 13, "CHOICE: $"
	STF_M12 DB 10, 13, "STAFF REGISTER SUCCEED $"
	STF_M13 DB 10, 13, "STAFF REGISTER FAIL $"
	STF_M15 DB 10, 13, "ENTER PASSWORD FOR $"
	STF_M16 DB " (8 CHAR): $"
	STF_ID_ADD DB 16, ?, 16 DUP('$')
	STF_NEW_PSW DB 4 DUP(0)
	STF_CON_PSW DB 4 DUP(0)
;---ADMIN STAFF
	STF_M17 DB 10, 13, "ENTER ADMIN PASSOWRD: $"
	STF_M18 DB 10, 13, " ADMIN ONLY!!!!!!!! $"
	ADM_PWD DB "1","2","3","4"
	ADM_IPWD DB 4 DUP (0)	


;---return and refund
	RTN_M1 DB 10, 13, "REFUND REQUEST DENIED $"
	RTN_M2 DB 10, 13, "TOTAL REFUND AMOUNT IS RM $"
	RTN_M3 DB 10, 13, "RETURN SUCCEED, PROCEED TO REFUND.... $"
	RTN_M4 DB 10, 13, "ENTER RECEIPT ID: $"
	RTN_M5 DB 10, 13, "INCORRECT RECEIPT ID!!! $"
	RTN_M6 DB 10, 13, "RECEIPT ID: $"
	RTN_M7 DB 10, 13, "APPROVE REFUND??? "
		   DB 10, 13, "1. YES "
		   DB 10, 13, "2. NO "
		   DB 10, 13, 10, 13, "CHOICE: $"
	RTN_M DB 10, 13, " $"
	RECEIPT_NO DB "A0001$"
	RECEIPT_ID DB 6 
       		   DB ?      
       		   DB 6 DUP(0)  
	RTN_QTY DB 0, 0, 0
	RTN_TOT DB 0, 0, 0

;---checkout
	checkOut_M1 DB 10, 13, "ENTER PRODUCT CHOICE: $"
	checkOut_M2 DB 10, 13, "ENTER PRODUCT QUANTITY: $"
	checkOut_M3 DB 10, 13, "MEMBERSHIP?"
				DB 10, 13, " 1. YES"
				DB 10, 13, " 2. NO"
				DB 10, 13, "ENTER CHOICE. $"

	checkOut_M4 DB 10, 13, "-------RECEIPT-----"
				DB 10, 13, "RECEIPT NO: A0001$"

	checkOut_M5 DB 10, 13, "PRICE BEFORE TAX: RM $"
	checkOut_M6 DB 10, 13, "TAX: 6% $"
	checkOut_M7 DB 10, 13, "PRICE AFTER TAX: RM $"
	
	CHECKOUT_QTY DB 0
	CHECKOUT_QTY2 DB 0
	CHECKOUT_QTY3 DB 0
	CHECKOUT_QTY4 DB 0
	CHECKOUT_PRICEATAX DB 0	  ;PRICE AFTER TAX
	CHECKOUT_PRICEATAXD DB 0		  ;PRICE AFTER TAX
	CHECKOUT_PRICEATAX1 DB 0	  ;PRICE AFTER TAX
	CHECKOUT_PRICEATAXD1 DB 0		  ;PRICE AFTER TAX
	CHECKOUT_PRICEBTAX DB 0, 0, 0 ;PRICE BEFORE TAX
	CHECKOUT_PRICEBTAX_SHIRT DB 0 ;PRICE BEFORE TAX
	CHECKOUT_PRICEBTAX_SHORTS DB 0 ;PRICE BEFORE TAX
	CHECKOUT_PRICEBTAX_HATS DB 0 ;PRICE BEFORE TAX
	CHECKOUT_PRICEBTAX_SOCKS DB 0 ;PRICE BEFORE TAX
	CHECKOUT_TOT DB 0, 0, 0
	CHECKOUT_TOTD DB 0, 0


;------CustomerMenu
	CUSTOMER_MENU1 	DB 10, 13, 10, 13, "-----------MEMBERSHIP MANAGEMENT----------- "
			 	   	DB 10, 13, " 1. NEW MEMBER REGISTER "
			  		DB 10, 13, " 2. REMOVE MEMBER "
			  		DB 10, 13, " 3. EXIT "
			  		DB 10, 13, "  "
			  		DB 10, 13, "CHOICE: $" 

;---REGISTER NEW MEMBER
	MEMBER_M1  DB 10, 13, "PLEASE ENTER CUSTOMER'S IC NUMBER: $"
	MEMBER_M2  DB 10, 13, "PLEASE ENTER CUSTOMER'S PHONE NUMBER: $"
	MEMBER_M3  DB 10, 13, "CONFIRM TO REGISTER THIS CUSTOMER?: $"
	MEMBER_M4  DB " ???"
		       DB 10, 13, " 1. YES"
		       DB 10, 13, " 2. NO "
			   DB 10, 13, 10, 13, "CHOICE: $"
	MEMBER_M5  DB 10, 13, "NEW MEMBER REGISTER SUCCEED $"
	MEMBER_M6  DB 10, 13, "MEMBER REGISTER FAILED $"
	MEMBER_M7  DB 10, 13, " $"
	MEMBER_M8  DB 10, 13, "MEMBER REMOVE SUCCEED"
	MEMBER_IC_ADD DB 16, ?, 16 DUP('$')
	MEMBER_PHONE_ADD DB 16, ?, 16 DUP('$')
	MEMBER_IC_REMOVE DB 16, ?, 16 DUP('$')
	MEMBER_PHONE_REMOVE DB 16, ?, 16 DUP('$')
;---REGISTER NEW MEMBER END

;---REMOVE MEMBER
	MEMBER_REMV_M1 DB 10, 13, "CONFIRM TO REMOVE MEMBER: $"
	MEMBER_REMV_M2 DB " ???"
		   		   DB 10, 13, "1. YES"
		   		   DB 10, 13, "2. NO "
		   		   DB 10, 13, 10, 13, "CHOICE: $"
	MEMBER_REMV_M3 DB 10, 13, "MEMBER REMOVAL SUCCEED $"
	MEMBER_REMV_M4 DB 10, 13, "MEMBER REMOVAL FAIL $"
;---REMOVE MEMBER END

;---SYSTEM MESSAGE
	MSG0 DB 10, 13, " $"
	MSG1 DB 10, 13, "EXITING PLASHSPEED..... $"
	MSG2 DB 10, 13, "INVALID CHOICE, PLEASE TRY AGAIN!!! $"
	MSG3 DB 10, 13, "REDIRECTING TO PLASHSPEED..... $"
	MSG4 DB 10, 13, "ANYTHING ELSE: "
		 DB 10, 13, " 1. YES "
		 DB 10, 13, " 2. NO "
		 DB 10, 13, 10, 13, "CHOICE: $"

	

;---------------Code Segment----------------
.CODE

MAIN PROC
	MOV AX,@DATA  ; Define data segment
	MOV DS,AX


;-----LOGIN
LOGIN:
	PRINT LOGIN_M1

	;READ USER INPUT
	MOV CX, 3	;SET COUNTER TO 3BYTES
	MOV SI, 0	;POINTER TO SAVE DATA INTO INAME
	
	INPUTN:
		MOV AH, 01H	;READ 1BYTE WHILE DISPLAY
		INT 21H

		MOV INAME[SI], AL	;SAVE INTO INAME

		INC SI
		LOOP INPUTN

	;---2. PROMPT FOR PASSWORD
	;ASK INPUT
	PRINT LOGIN_M2

	 ;READ USER INPUT
	MOV CX, 4	;SET COUNTER TO 3BYTES
	MOV SI, 0	;POINTER TO SAVE DATA INTO INAME
	
	INPUTP:
		MOV AH, 07H	;READ 1BYTE WITHOUT DISPLAY
		INT 21H

		MOV IPWD[SI], AL	;SAVE INTO IPWD

		INC SI
		LOOP INPUTP
		
	;---3. CHECK USERNAME`
	 ;CHECK USERNAME
	MOV SI, 0
	XOR AX, AX

	CHECKNAME:
		CMP SI, 3
		JE PASSWORD

		MOV AL, UPWD[SI]
		CMP AL, IPWD[SI]
		JE NEXT
		JNE ERROR

	NEXT:
		INC SI
		JMP CHECKNAME

    	;---4. CHECK PASSWORD
	PASSWORD:
	MOV SI, 0
	XOR AX, AX

	CHECKPWD:
		CMP SI, 4
		JE SUCCESS

		MOV AL, UNAME[SI]
		CMP AL, INAME[SI]
		JE NEXT2
		JNE ERROR

	NEXT2:
		INC SI
		JMP CHECKPWD
	
	;---5. LOGIN SUCCESFUL
	SUCCESS:
		JMP CLR_SCN

	;---6. LOGIN FAIL
	ERROR:
		PRINT LOGIN_M4

		JMP LOGIN

CLR_SCN:
	MOV AX, 03H
	INT 10H
	PRINT LOGIN_M3

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
		JMP INVENTORY

	STK_UPDATE:
		CMP BL, 2
		JNE STK_SET_RMD

		CALL INV_UPDATE
		PRINT MSG3
		JMP INVENTORY

	STK_SET_RMD:
		CMP BL, 3
		JNE STK_RMD

		CALL INV_SETRMD

		PRINT MSG3
		JMP INVENTORY
	STK_RMD:
		CMP BL, 4
		JNE EXIT_STK
		
		CALL INV_RMD
		PRINT MSG3
		JMP INVENTORY

	EXIT_STK:
		CMP BL, 9			; EXIT
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
	CMP CC, 3		; GO TO SALES IF CHOICE != 3	JNE SALES
	JNE SALES

	PRINT CUSTOMER_MENU1		
	CALL ACCEPT		; USER ENTER CHOICE
	MOV BL, AL
	SUB BL, 48

	CUSTOMER_NEW:			; NEW CUSTOMER BEGIN
		CMP BL, 1
		JNE REMOVE_MEMBER

		CALL ADD_CUSTOMER
		PRINT MSG3
		JMP CUSTOMER			; NEW CUSTOMER END

	REMOVE_MEMBER:
		CMP BL, 2
		JNE EXIT_MEMBER

		CALL MEMBER_REMOVE
		PRINT MSG3
		JMP CUSTOMER

	EXIT_MEMBER:
		CMP BL, 9			; EXIT
		JNE MEMBER_INVALID
		PRINT MSG3
		JMP TOP

	MEMBER_INVALID:
		PRINT MSG2
		JMP CUSTOMER



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

	CALL RTN_RCPT

	PRINT MSG3
	JMP TOP
;----------STAFF MANAGEMENT---------------
STAFF:
	CMP CC, 6		; EXIT IF CHOICE != 6
	JNE EXIT

	CALL STF_ADMIN
	STAFF_MENU:
	PRINT STF_MENU1	
	XOR AX, AX	
	XOR BX, BX
	CALL ACCEPT		; USER ENTER CHOICE
	MOV BL, AL
	SUB BL, 48

	STF_NEW:			; NEW STAFF START
		CMP BL, 1
		JNE CHANGE_PASS

		CALL STF_ADD
		PRINT MSG3
		JMP STAFF_MENU			; NEW STAFF END

	CHANGE_PASS:
		CMP BL, 2
		JNE STF_REMOVE

		CALL STF_PASS
		PRINT STF_M4
		PRINT MSG3
		JMP STAFF_MENU

	STF_REMOVE:
		CMP BL, 3
		JNE EXIT_STAFF

		CALL STF_RMV

		PRINT MSG3
		JMP STAFF_MENU

	EXIT_STAFF:
		CMP BL, 9			; EXIT
		JNE STF_INVALID
		PRINT MSG3
		JMP TOP

	STF_INVALID:
		PRINT MSG2
		JMP STAFF_MENU

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

;------------STOCK REPORT---DONE
INV_REPORT PROC NEAR
	PRINT INV_M8			;shirt quantity
	XOR AX, AX
	XOR BX, BX
	MOV AL, SHIRT_NUM_UP(0)
	MUL TEN
	ADD AL, SHIRT_NUM_UP(1)
	MOV BL, AL

	XOR AX, AX
	XOR DX, DX
	MOV AL, SHIRT_NUM
	ADD AL, BL
	DIV HUN
	MOV SHIRT_NUMD(0), AL
	MOV DL, AH
	XOR AX,AX
	MOV AL, DL	
	DIV Ten
	MOV SHIRT_NUMD(1), AL
	MOV SHIRT_NUMD(2), AH
	ADD SHIRT_NUMD(0), 30H
	ADD SHIRT_NUMD(1), 30H
	ADD SHIRT_NUMD(2), 30H
	MOV AH, 02H
	MOV DL, SHIRT_NUMD(0)
	INT 21H
	MOV AH, 02H
	MOV DL, SHIRT_NUMD(1)
	INT 21H
	MOV AH, 02H
	MOV DL, SHIRT_NUMD(2)
	INT 21H

	PRINT INV_M9			;shorts quantity
	XOR AX, AX
	XOR BX, BX
	MOV AL, SHORTS_NUM_UP(0)
	MUL TEN
	ADD AL, SHORTS_NUM_UP(1)
	MOV BL, AL

	XOR AX, AX
	XOR DX, DX
	MOV AL, SHORTS_NUM
	ADD AL, BL
	DIV HUN
	MOV SHORTS_NUMD(0), AL
	MOV DL, AH
	XOR AX,AX
	MOV AL, DL	
	DIV Ten
	MOV SHORTS_NUMD(1), AL
	MOV SHORTS_NUMD(2), AH
	ADD SHORTS_NUMD(0), 30H
	ADD SHORTS_NUMD(1), 30H
	ADD SHORTS_NUMD(2), 30H
	MOV AH, 02H
	MOV DL, SHORTS_NUMD(0)
	INT 21H
	MOV AH, 02H
	MOV DL, SHORTS_NUMD(1)
	INT 21H
	MOV AH, 02H
	MOV DL, SHORTS_NUMD(2)
	INT 21H

	PRINT INV_M10			;hats quantity
	XOR AX, AX
	XOR BX, BX
	MOV AL, HATS_NUM_UP(0)
	MUL TEN
	ADD AL, HATS_NUM_UP(1)
	MOV BL, AL

	XOR AX, AX
	XOR DX, DX
	MOV AL, HATS_NUM
	ADD AL, BL
	DIV HUN
	MOV HATS_NUMD(0), AL
	MOV DL, AH
	XOR AX,AX
	MOV AL, DL	
	DIV Ten
	MOV HATS_NUMD(1), AL
	MOV HATS_NUMD(2), AH
	ADD HATS_NUMD(0), 30H
	ADD HATS_NUMD(1), 30H
	ADD HATS_NUMD(2), 30H
	MOV AH, 02H
	MOV DL, HATS_NUMD(0)
	INT 21H
	MOV AH, 02H
	MOV DL, HATS_NUMD(1)
	INT 21H
	MOV AH, 02H
	MOV DL, HATS_NUMD(2)
	INT 21H

	PRINT INV_M11		;socks quantity
	XOR AX, AX
	XOR BX, BX
	MOV AL, SOCKS_NUM_UP(0)
	MUL TEN
	ADD AL, SOCKS_NUM_UP(1)
	MOV BL, AL

	XOR AX, AX
	XOR DX, DX
	MOV AL, SOCKS_NUM
	ADD AL, BL
	DIV HUN
	MOV SOCKS_NUMD(0), AL
	MOV DL, AH
	XOR AX,AX
	MOV AL, DL	
	DIV Ten
	MOV SOCKS_NUMD(1), AL
	MOV SOCKS_NUMD(2), AH
	ADD SOCKS_NUMD(0), 30H
	ADD SOCKS_NUMD(1), 30H
	ADD SOCKS_NUMD(2), 30H
	MOV AH, 02H
	MOV DL, SOCKS_NUMD(0)
	INT 21H
	MOV AH, 02H
	MOV DL, SOCKS_NUMD(1)
	INT 21H
	MOV AH, 02H
	MOV DL, SOCKS_NUMD(2)
	INT 21H

	RET
INV_REPORT ENDP

;------------UPDATE STOCK----DONE
INV_UPDATE PROC NEAR
	UP_INV:
	PRINT PRO_MENU
	CALL ACCEPT
	MOV BL, AL
	SUB BL, 30H
	UP_SHIRT:
		CMP BL, 1
		JNE UP_SHORTS

		PRINT INV_M12
		CALL ACCEPT
		MOV SHIRT_NUM_UP(0), AL
		SUB SHIRT_NUM_UP(0), 30H
		CALL ACCEPT
		MOV SHIRT_NUM_UP(1), AL
		SUB SHIRT_NUM_UP(1), 30H
		XOR BX, BX
		MOV AL, SHIRT_NUM_UP(0)
		MUL TEN
		ADD AL, SHIRT_NUM_UP(1)
		MOV BL, AL

		XOR AX, AX
		XOR DX, DX
		MOV AL, SHIRT_NUM
		ADD AL, BL
		DIV HUN
		MOV SHIRT_NUMD(0), AL
		MOV DL, AH
		XOR AX,AX
		MOV AL, DL	
		DIV Ten
		MOV SHIRT_NUMD(1), AL
		MOV SHIRT_NUMD(2), AH
		ADD SHIRT_NUMD(0), 30H
		ADD SHIRT_NUMD(1), 30H
		ADD SHIRT_NUMD(2), 30H
		PRINT INV_M13
		MOV AH, 02H
		MOV DL, SHIRT_NUMD(0)
		INT 21H
		MOV AH, 02H
		MOV DL, SHIRT_NUMD(1)
		INT 21H
		MOV AH, 02H
		MOV DL, SHIRT_NUMD(2)
		INT 21H
		
		JMP UP_MULTIPLE
	UP_SHORTS:
		CMP BL, 2
		JNE UP_HATS

		PRINT INV_M12
		CALL ACCEPT
		MOV SHORTS_NUM_UP(0), AL
		SUB SHORTS_NUM_UP(0), 30H
		CALL ACCEPT
		MOV SHORTS_NUM_UP(1), AL
		SUB SHORTS_NUM_UP(1), 30H
		XOR BX, BX
		MOV AL, SHORTS_NUM_UP(0)
		MUL TEN
		ADD AL, SHORTS_NUM_UP(1)
		MOV BL, AL

		XOR AX, AX
		XOR DX, DX
		MOV AL, SHORTS_NUM
		ADD AL, BL
		DIV HUN
		MOV SHORTS_NUMD(0), AL
		MOV DL, AH
		XOR AX,AX
		MOV AL, DL	
		DIV Ten
		MOV SHORTS_NUMD(1), AL
		MOV SHORTS_NUMD(2), AH
		ADD SHORTS_NUMD(0), 30H
		ADD SHORTS_NUMD(1), 30H
		ADD SHORTS_NUMD(2), 30H
		PRINT INV_M13
		MOV AH, 02H
		MOV DL, SHORTS_NUMD(0)
		INT 21H
		MOV AH, 02H
		MOV DL, SHORTS_NUMD(1)
		INT 21H
		MOV AH, 02H
		MOV DL, SHORTS_NUMD(2)
		INT 21H
		
		JMP UP_MULTIPLE
	UP_HATS:
		CMP BL, 3
		JNE UP_SOCKS

		PRINT INV_M12
		CALL ACCEPT
		MOV HATS_NUM_UP(0), AL
		SUB HATS_NUM_UP(0), 30H
		CALL ACCEPT
		MOV HATS_NUM_UP(1), AL
		SUB HATS_NUM_UP(1), 30H
		XOR BX, BX
		MOV AL, HATS_NUM_UP(0)
		MUL TEN
		ADD AL, HATS_NUM_UP(1)
		MOV BL, AL

		XOR AX, AX
		XOR DX, DX
		MOV AL, HATS_NUM
		ADD AL, BL
		DIV HUN
		MOV HATS_NUMD(0), AL
		MOV DL, AH
		XOR AX,AX
		MOV AL, DL	
		DIV Ten
		MOV HATS_NUMD(1), AL
		MOV HATS_NUMD(2), AH
		ADD HATS_NUMD(0), 30H
		ADD HATS_NUMD(1), 30H
		ADD HATS_NUMD(2), 30H
		PRINT INV_M13
		MOV AH, 02H
		MOV DL, HATS_NUMD(0)
		INT 21H
		MOV AH, 02H
		MOV DL, HATS_NUMD(1)
		INT 21H
		MOV AH, 02H
		MOV DL, HATS_NUMD(2)
		INT 21H
		
		JMP UP_MULTIPLE
	UP_SOCKS:
		CMP BL, 4
		JNE UP_EXIT

		PRINT INV_M12
		CALL ACCEPT
		MOV SOCKS_NUM_UP(0), AL
		SUB SOCKS_NUM_UP(0), 30H
		CALL ACCEPT
		MOV SOCKS_NUM_UP(1), AL
		SUB SOCKS_NUM_UP(1), 30H
		XOR BX, BX
		MOV AL, SOCKS_NUM_UP(0)
		MUL TEN
		ADD AL, SOCKS_NUM_UP(1)
		MOV BL, AL

		XOR AX, AX
		XOR DX, DX
		MOV AL, SOCKS_NUM
		ADD AL, BL
		DIV HUN
		MOV SOCKS_NUMD(0), AL
		MOV DL, AH
		XOR AX,AX
		MOV AL, DL	
		DIV Ten
		MOV SOCKS_NUMD(1), AL
		MOV SOCKS_NUMD(2), AH
		ADD SOCKS_NUMD(0), 30H
		ADD SOCKS_NUMD(1), 30H
		ADD SOCKS_NUMD(2), 30H
		PRINT INV_M13
		MOV AH, 02H
		MOV DL, SOCKS_NUMD(0)
		INT 21H
		MOV AH, 02H
		MOV DL, SOCKS_NUMD(1)
		INT 21H
		MOV AH, 02H
		MOV DL, SOCKS_NUMD(2)
		INT 21H
		
		JMP UP_MULTIPLE

	UP_EXIT:
		CMP BL, 9
		JNE UP_INVALID
		PRINT MSG3
		JMP TOP

	UP_INVALID:
		PRINT MSG2
		JMP INV_UPDATE
	
	UP_MULTIPLE:
		PRINT MSG4
		XOR AX, AX
		CALL ACCEPT
		MOV DL, AL
		SUB DL, 30H
	UP_MULTIPLE_YES:
		CMP DL, 1
		JNE UP_MULTIPLE_NO
		JMP UP_INV
	UP_MULTIPLE_NO:
		CMP DL, 2
		JNE UP_MULTIPLE_INVALID
		RET
	UP_MULTIPLE_INVALID:
		PRINT MSG2
		JMP UP_MULTIPLE

INV_UPDATE ENDP

;------------SET REMAINDER TO BUY STOCK---DONE
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
	
	XOR AX, AX
	SUB RMD(0), 30H
	SUB RMD(1), 30H
	MOV AL, RMD(0)
	MUL Ten
	ADD AL, RMD(1)
	MOV RRMD, AL

	RET
INV_SETRMD ENDP

;-------------SEND STOCK REMINDER
INV_RMD PROC NEAR
	INV_RMD_SHIRT:
		XOR AX, AX
		XOR BX, BX
		XOR DX, DX
		MOV AL, SHIRT_NUM_UP(0)
		MUL TEN
		ADD AL, SHIRT_NUM_UP(1)
		MOV INV_V1, AL
		XOR AX, AX
		MOV AL, SHIRT_NUM
		ADD AL, INV_V1
		SUB AL, RRMD
		MOV BL, AL

		CMP BL, 0
		JGE INV_RMD_SHIRT_N

		PRINT INV_M4
		PRINT INV_M3
		JMP INV_RMD_SHORTS

		INV_RMD_SHIRT_N:
			JMP INV_RMD_SHORTS

	INV_RMD_SHORTS:
		XOR AX, AX
		XOR DX, DX
		MOV AL, SHORTS_NUM_UP(0)
		MUL TEN
		ADD AL, SHORTS_NUM_UP(1)
		MOV INV_V2, AL
		XOR AX, AX
		MOV AL, SHORTS_NUM
		ADD AL, INV_V2
		SUB AL, RRMD
		MOV BL, AL

		CMP BL, 0
		JGE INV_RMD_SHORTS_N

		PRINT INV_M5
		PRINT INV_M3
		JMP INV_RMD_HATS

		INV_RMD_SHORTS_N:
			JMP INV_RMD_HATS
		
	INV_RMD_HATS:
		XOR AX, AX
		XOR DX, DX
		MOV AL, HATS_NUM_UP(0)
		MUL TEN
		ADD AL, HATS_NUM_UP(1)
		MOV INV_V3, AL
		XOR AX, AX
		MOV AL, HATS_NUM
		ADD AL, INV_V3
		SUB AL, RRMD
		MOV BL, AL

		CMP BL, 0
		JGE INV_RMD_HATS_N

		PRINT INV_M6
		PRINT INV_M3
		JMP INV_RMD_SOCKS

		INV_RMD_HATS_N:
			JMP INV_RMD_SOCKS
	
	INV_RMD_SOCKS:
		XOR AX, AX
		XOR DX, DX
		MOV AL, SOCKS_NUM_UP(0)
		MUL TEN
		ADD AL, SOCKS_NUM_UP(1)
		MOV INV_V4, AL
		XOR AX, AX
		MOV AL, SOCKS_NUM
		SUB AL, RRMD
		MOV BL, AL

		CMP BL, 0
		JGE INV_RMD_SOCKS_N

		PRINT INV_M7
		PRINT INV_M3
		RET

		INV_RMD_SOCKS_N:
			RET

INV_RMD ENDP

;------------STAFF NEW-----------------DONE
STF_ADD PROC NEAR
	PRINT STF_M5                                 
    MOV AH, 0AH 			;CAPTURE STRING FROM KEYBOARD.
    MOV DX, OFFSET STF_ID_ADD
    INT 21H

	;CHANGE CHR(13) BY '$'.
    MOV SI, OFFSET STF_ID_ADD + 1 ;NUMBER OF CHARACTERS ENTERED.
    MOV CL, [SI] ;MOVE LENGTH TO CL.
    MOV CH, 00      ;CLEAR CH TO USE CX. 
    INC CX ;TO REACH CHR(13).
    ADD SI, CX ;NOW SI POINTS TO CHR(13).
    MOV AL, '$'
    MOV [SI], AL ;REPLACE CHR(13) BY '$'. 

	STF_PSW_START:
	PRINT STF_M15
    MOV AH, 9 					;DISPLAY STRING.
    MOV DX, OFFSET STF_ID_ADD + 2	;MUST END WITH '$'.
	INT 21H
	PRINT STF_M16
	
	MOV CX, 8
	MOV SI,0
	STF_GETNEWPSW:
 		MOV AH,07H
		INT 21H
		MOV STF_NEW_PSW[SI], AL
		INC SI
		LOOP STF_GETNEWPSW
	PRINT STF_M2
	MOV CX, 8
	MOV SI,0
	STF_GETCONPSW:
		MOV AH,07H
		INT 21H
		MOV STF_CON_PSW[SI],AL
		INC SI
		LOOP STF_GETCONPSW

	MOV SI,0
	STF_CHK:
		CMP SI,8
		JE STF_PSW_SAME
		MOV BL, STF_NEW_PSW[SI]
		CMP BL, STF_CON_PSW[SI]
		JE STF_CHKNEXT
		JNE STF_PSW_DIFF

	STF_CHKNEXT:
		INC SI
		JMP STF_CHK

	STF_PSW_SAME:
		JMP STF_ADD_Q
	STF_PSW_DIFF:
		PRINT STF_M3
		JMP STF_PSW_START

	STF_ADD_Q:
		PRINT STF_M10               
    	MOV AH, 9 					;DISPLAY STRING.
    	MOV DX, OFFSET STF_ID_ADD + 2	;MUST END WITH '$'.
   		INT 21H

		PRINT STF_M11
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 30H
		STF_ADD_CON:				;CONFIRM
			CMP BL, 1
			JNE STF_ADD_CAN
			PRINT STF_M12
			RET
		STF_ADD_CAN:				;CANCEL
			CMP BL, 2
			JNE STF_ADD_INVALID
			PRINT STF_M13
			RET
		STF_ADD_INVALID:
			PRINT MSG2
			JMP STF_ADD_Q
STF_ADD ENDP

;------------STAFF REMOVE-------------DONE
STF_RMV PROC NEAR
	PRINT STF_M5                                 
    MOV AH, 0AH 			;CAPTURE STRING FROM KEYBOARD.
    MOV DX, OFFSET STF_ID_RMV
    INT 21H

	;CHANGE CHR(13) BY '$'.
    MOV SI, OFFSET STF_ID_RMV + 1 ;NUMBER OF CHARACTERS ENTERED.
    MOV CL, [SI] ;MOVE LENGTH TO CL.
    MOV CH, 00      ;CLEAR CH TO USE CX. 
    INC CX ;TO REACH CHR(13).
    ADD SI, CX ;NOW SI POINTS TO CHR(13).
    MOV AL, '$'
    MOV [SI], AL ;REPLACE CHR(13) BY '$'.            

	STF_RMV_Q:
		PRINT STF_M6                 
    	MOV AH, 9 					;DISPLAY STRING.
    	MOV DX, OFFSET STF_ID_RMV + 2	;MUST END WITH '$'.
   		INT 21H

		PRINT STF_M7
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 30H
		STF_RMV_CON:
			CMP BL, 1
			JNE STF_RMV_CAN
			PRINT STF_M8
			RET
		STF_RMV_CAN:
			CMP BL, 2
			JNE STF_RMV_INVALID
			PRINT STF_M9
			RET
		STF_RMV_INVALID:
			PRINT MSG2
			JMP STF_RMV_Q
STF_RMV ENDP

;------------STAFF CHANGE PASSWORD-----CLEAR STRING IN VARIABLE
STF_PASS PROC NEAR
	PSW_START:
	PRINT STF_M1
	MOV CX, 4
	MOV SI,0
	GETNEWPSW:
 		MOV AH,07H
		INT 21H
		MOV NEW_PSW[SI],AL
		INC SI
		LOOP GETNEWPSW
	PRINT STF_M2
	MOV CX, 4
	MOV SI,0
	GETCONPSW:
		MOV AH,07H
		INT 21H
		MOV CON_PSW[SI],AL
		INC SI
		LOOP GETCONPSW

	MOV SI,0
	CHK:
		CMP SI,4
		JE PSW_SAME
		MOV BL,NEW_PSW[SI]
		CMP BL,CON_PSW[SI]
		JE CHKNEXT
		JNE PSW_DIFF

	CHKNEXT:
		INC SI
		JMP CHK

	PSW_SAME:
		PRINT STF_M4
		MOV CX, 4
		MOV SI, 0
		MOV AX, 0

		ADMP_CGE:
			CMP SI, 4
			JE ADMP_CGE_YES

			MOV ADM_PWD[SI], 0
			MOV AL, NEW_PSW[SI]
			MOV ADM_PWD[SI], AL
			INC SI
			LOOP ADMP_CGE

		ADMP_CGE_YES:
			JMP STAFF_MENU

	PSW_DIFF:
		PRINT STF_M3
		PRINT STF_M14
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 30H
		PSW_Y:
			CMP BL, 1
			JNE PSW_N
			JMP PSW_START
		PSW_N:
			CMP BL, 2
			JNE PSW_IN
			PRINT MSG3
			JMP STAFF
		PSW_IN:
			PRINT MSG2
			JMP PSW_DIFF

STF_PASS ENDP

STF_ADMIN PROC NEAR

	PRINT STF_M17

	;READ USER INPUT
	MOV CX, 4	;SET COUNTER TO 3BYTES
	MOV SI, 0	;POINTER TO SAVE DATA INTO INAME
	
	ADM_INPUTP:
		MOV AH, 07H	;READ 1BYTE WITHOUT DISPLAY
		INT 21H

		MOV ADM_IPWD[SI], AL	;SAVE INTO IPWD

		INC SI
		LOOP ADM_INPUTP
		
	MOV SI, 0
	XOR AX, AX
	ADM_CHECKPWD:
		CMP SI, 4
		JE ADM_SUCCESS

		MOV AL, ADM_PWD[SI]
		CMP AL, ADM_IPWD[SI]
		JE NEXT3
		JNE ADM_FAIL

	NEXT3:
		INC SI
		JMP ADM_CHECKPWD
	
	;---5. LOGIN SUCCESFUL
	ADM_SUCCESS:
		RET

	;---6. LOGIN FAIL
	ADM_FAIL:
		PRINT STF_M18
		JMP TOP
STF_ADMIN ENDP

;------RETURN RECEIPT
RTN_RCPT PROC NEAR
	PRINT RTN_M4

	mov ah, 0ah
	MOV DX, OFFSET RECEIPT_ID
	int 21h

	MOV SI, OFFSET RECEIPT_ID + 2
	MOV DI, OFFSET RECEIPT_NO      ;<=== POINT TO THE USER.
	
	RECEIPT_CMP: 
		;CHECK END OF USER.  
		  MOV DH, [DI]
		  CMP DH, '$'
		  JE  RECEIPT_CMP_SUC

		;CHECK END OF INPUT.  
		  MOV DL, [SI]          ;<=== CURRENT ENTERED CHAR.
		  CMP DL, 13
		  JE  RECEIPT_CMP_FAIL             ;<=== END REACHED. INPUT IS SHORTER.

		;COMPARE CURRENT ENTERED CHAR TO CURRENT USER CHAR.  
		  CMP DL, DH
		  JNE RECEIPT_CMP_FAIL             ;<=== CURRENT CHARS ARE DIFFERENT.
		  INC SI                ;<== NEXT ENTERED CHAR.
		  INC DI                ;<== NEXT USER CHAR.
		  JMP RECEIPT_CMP                ;<== REPEAT.
	
	RECEIPT_CMP_SUC:
		PRINT RTN_M6
		PRINT RECEIPT_NO
		REFUND_YN:
			PRINT RTN_M7
			CALL ACCEPT
			MOV BX, BX
			MOV BL, AL
			SUB BL, 30H
			REFUND_Y:
				CMP BL, 1
				JNE REFUND_N

				PRINT RTN_M3
				PRINT RTN_M2
				MOV AH, 02H
				MOV DL, CHECKOUT_TOT(0)
				INT 21H
				MOV AH, 02H
				MOV DL, CHECKOUT_TOT(1)
				INT 21H
				MOV AH, 02H
				MOV DL, CHECKOUT_TOT(2)
				INT 21H
				MOV AH, 02H
				MOV DL, 2EH
				INT 21H
				MOV AH, 02H
				MOV DL, CHECKOUT_TOTD(0)
				INT 21H
				MOV AH, 02H
				MOV DL, CHECKOUT_TOTD(1)
				INT 21H
				
				RET 
			REFUND_N:
				CMP BL, 2
				JNE REFUND_INVAL

				PRINT RTN_M1
				RET
			REFUND_INVAL:
				PRINT MSG2
				JMP REFUND_YN
		
	RECEIPT_CMP_FAIL:
		PRINT RTN_M5
		JMP TOP

RTN_RCPT ENDP


PRINT_RECEIPT PROC NEAR

	;---------display
			XOR AX,AX

			MOV AL, CHECKOUT_PRICEBTAX_SHIRT
			ADD AL, CHECKOUT_PRICEBTAX_SHORTS
			ADD AL, CHECKOUT_PRICEBTAX_HATS
			ADD AL, CHECKOUT_PRICEBTAX_SOCKS
			DIV HUN
			MOV CHECKOUT_PRICEBTAX(0), AL
			MOV DL, AH
			XOR AX, AX
			MOV AL, DL
			DIV TEN
			MOV CHECKOUT_PRICEBTAX(1), AL
			MOV CHECKOUT_PRICEBTAX(2), AH
			
			ADD CHECKOUT_PRICEBTAX(0), 30H
			ADD CHECKOUT_PRICEBTAX(1), 30H
			ADD CHECKOUT_PRICEBTAX(2), 30H

			PRINT checkOut_M4
			PRINT checkOut_M5

			MOV AH, 02H
			MOV DL, CHECKOUT_PRICEBTAX(0)
			INT 21H
			MOV AH, 02H
			MOV DL, CHECKOUT_PRICEBTAX(1)
			INT 21H
			MOV AH, 02H
			MOV DL, CHECKOUT_PRICEBTAX(2)
			INT 21H
			PRINT checkOut_M6
			PRINT checkOut_M7
			XOR AX,AX
			XOR DX,DX
			ADD CHECKOUT_TOT(0), 30H
			ADD CHECKOUT_TOT(1), 30H
			ADD CHECKOUT_TOT(2), 30H
			ADD CHECKOUT_TOTD(0), 30H
			ADD CHECKOUT_TOTD(1), 30H
			MOV AH, 02H
			MOV DL, CHECKOUT_TOT(0)
			INT 21H
			MOV AH, 02H
			MOV DL, CHECKOUT_TOT(1)
			INT 21H
			MOV AH, 02H
			MOV DL, CHECKOUT_TOT(2)
			INT 21H
			MOV AH, 02H
			MOV DL, 2EH
			INT 21H
			MOV AH, 02H
			MOV DL, CHECKOUT_TOTD(0)
			INT 21H

			MOV AH, 02H
			MOV DL, CHECKOUT_TOTD(1)
			INT 21H
	RET
PRINT_RECEIPT ENDP

CAL_TAX PROC NEAR
			XOR AX, AX
			MOV AL, CHECKOUT_PRICEBTAX_SHIRT
			ADD AL, CHECKOUT_PRICEBTAX_SHORTS
			ADD AL, CHECKOUT_PRICEBTAX_HATS
			ADD AL, CHECKOUT_PRICEBTAX_SOCKS

			MUL TAX				; 106
			DIV	HUN				; /100
			MOV CHECKOUT_PRICEATAX,AL 
			MOV CHECKOUT_PRICEATAXD,AH

			XOR AX, AX
			XOR DX, DX
			MOV AL, CHECKOUT_PRICEATAX
			DIV HUN 
			MOV CHECKOUT_TOT(0),AL 
			MOV DL, AH
			XOR AX,AX
			MOV AL, DL
			DIV TEN
			MOV CHECKOUT_TOT(1),AL
			MOV CHECKOUT_TOT(2),AH
			XOR DX, DX
			XOR AX, AX
			MOV AL,CHECKOUT_PRICEATAXD
			DIV TEN
			MOV CHECKOUT_TOTD(0),AL
			MOV CHECKOUT_TOTD(1),AH
			RET
CAL_TAX ENDP


CAL_TAX_DIS PROC NEAR
			XOR AX, AX
			MOV AL, CHECKOUT_PRICEBTAX_SHIRT
			ADD AL, CHECKOUT_PRICEBTAX_SHORTS
			ADD AL, CHECKOUT_PRICEBTAX_HATS
			ADD AL, CHECKOUT_PRICEBTAX_SOCKS
			
			MUL DISCOUNT
			DIV HUN
			MUL TAX			; 106
			DIV	HUN			; /100
			MOV CHECKOUT_PRICEATAX,AL 	;11
			MOV CHECKOUT_PRICEATAXD,AH 	;11
			
				

			XOR AX, AX
			XOR DX, DX
			MOV AL, CHECKOUT_PRICEATAX
			DIV HUN 
			MOV CHECKOUT_TOT(0),AL 
			MOV DL, AH
			XOR AX,AX
			MOV AL, DL
			DIV TEN
			MOV CHECKOUT_TOT(1),AL
			MOV CHECKOUT_TOT(2),AH
			XOR DX, DX
			XOR AX, AX
			MOV AL,CHECKOUT_PRICEATAXD
			DIV TEN
			MOV CHECKOUT_TOTD(0),AL
			MOV CHECKOUT_TOTD(1),AH
			RET
CAL_TAX_DIS ENDP

CHECK_MEMBERSHIP PROC NEAR
CHECK_MEMBER:
				PRINT checkOut_M3 
				XOR AX, AX
				XOR DX, DX
				MOV AH, 01H
				INT 21H
				MOV DL, AL
				SUB DL, 30H
				YES_MEMBER:
					CMP DL, 1
					JNE NO_MEMBER
					CALL CAL_TAX_DIS
					CALL PRINT_RECEIPT
					RET

				NO_MEMBER:
					CMP DL, 2
					JNE INVALID_MEMBER
					CALL CAL_TAX
			 		CALL PRINT_RECEIPT
					RET	
				INVALID_MEMBER:
					PRINT MSG2
					JMP CHECK_MEMBER

CHECK_MEMBERSHIP ENDP
;CHECKOUT 
CHECKOUT_CAL PROC NEAR
	MOV CHECKOUT_PRICEBTAX_SHIRT,0
	MOV CHECKOUT_PRICEBTAX_SHORTS,0
	MOV CHECKOUT_PRICEBTAX_HATS,0
	MOV CHECKOUT_PRICEBTAX_SOCKS,0
	CHECKOUT_START:
		PRINT checkOut_M1
		XOR AX, AX
		XOR DX, DX
		MOV AH, 01H
		INT 21H
		MOV DL, AL
		SUB DL, 30H
 
		CHECKOUT_SHIRT:
			CMP DL, 1
			JNE CHECKOUT_SHORTS

			PRINT checkOut_M2
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV CHECKOUT_QTY, AL
			SUB CHECKOUT_QTY, 30H

			XOR DX, DX
			XOR BX, BX
			MOV AL, CHECKOUT_QTY
			MUL SHIRT				; PRICE OF PRODUCT
			
			MOV CHECKOUT_PRICEBTAX_SHIRT, AL


			CK_CHECK_MULTIPLE:
				PRINT MSG4
				XOR BX, BX
				MOV AH, 01H
				INT 21H
				MOV BL, AL
				SUB BL, 30H
				CK_CHECK_MULTIPLE_YES:
					CMP BL, 1
					JNE CK_CHECK_MULTIPLE_NO

					JMP CHECKOUT_START
				CK_CHECK_MULTIPLE_NO:
					CMP BL, 2
					JNE CK_CHECK_MULTIPLE_INVALID

					CALL CHECK_MEMBERSHIP
					RET
				CK_CHECK_MULTIPLE_INVALID:
					PRINT MSG2
					JMP CK_CHECK_MULTIPLE
		
		CHECKOUT_SHORTS:
			CMP DL, 2
			JNE CHECKOUT_HATS

			PRINT checkOut_M2
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV CHECKOUT_QTY2, AL
			SUB CHECKOUT_QTY2, 30H

			XOR DX, DX
			XOR BX, BX
			MOV AL, CHECKOUT_QTY2
			MUL SHORTS				; PRICE OF PRODUCT

			MOV CHECKOUT_PRICEBTAX_SHORTS, AL


			CK_CHECK_MULTIPLE1:
				PRINT MSG4
				XOR BX, BX
				MOV AH, 01H
				INT 21H
				MOV BL, AL
				SUB BL, 30H
				CK_CHECK_MULTIPLE_YES1:
					CMP BL, 1
					JNE CK_CHECK_MULTIPLE_NO1

					JMP CHECKOUT_START
				CK_CHECK_MULTIPLE_NO1:
					CMP BL, 2
					JNE CK_CHECK_MULTIPLE_INVALID1

					CALL CHECK_MEMBERSHIP
					RET
				CK_CHECK_MULTIPLE_INVALID1:
					PRINT MSG2
					JMP CK_CHECK_MULTIPLE
			RET
		CHECKOUT_HATS:
			CMP DL, 3
			JNE CHECKOUT_SOCKS

			PRINT checkOut_M2
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV CHECKOUT_QTY3, AL
			SUB CHECKOUT_QTY3, 30H


			XOR DX, DX
			XOR BX, BX
			MOV AL, CHECKOUT_QTY3
			MUL HATS				; PRICE OF PRODUCT

			MOV CHECKOUT_PRICEBTAX_HATS, AL


			
			CK_CHECK_MULTIPLE2:
				PRINT MSG4
				XOR BX, BX
				MOV AH, 01H
				INT 21H
				MOV BL, AL
				SUB BL, 30H
				CK_CHECK_MULTIPLE_YES2:
					CMP BL, 1
					JNE CK_CHECK_MULTIPLE_NO2

					JMP CHECKOUT_START
				CK_CHECK_MULTIPLE_NO2:
					CMP BL, 2
					JNE CK_CHECK_MULTIPLE_INVALID2

					CALL CHECK_MEMBERSHIP
					RET
				CK_CHECK_MULTIPLE_INVALID2:
					PRINT MSG2
					JMP CK_CHECK_MULTIPLE
			RET
		CHECKOUT_SOCKS:
			CMP DL, 4
			JNE CHECKOUT_EXIT

			PRINT checkOut_M2
			MOV AH, 01H		; DIGIT 1
			INT 21H			
			MOV CHECKOUT_QTY4, AL
			SUB CHECKOUT_QTY4, 30H

			XOR DX, DX
			XOR BX, BX
			MOV AL, CHECKOUT_QTY4
			MUL SOCKS				; PRICE OF PRODUCT

			MOV CHECKOUT_PRICEBTAX_SOCKS, AL


			
			CK_CHECK_MULTIPLE3:
				PRINT MSG4
				XOR BX, BX
				MOV AH, 01H
				INT 21H
				MOV BL, AL
				SUB BL, 30H
				CK_CHECK_MULTIPLE_YES3:
					CMP BL, 1
					JNE CK_CHECK_MULTIPLE_NO3

					JMP CHECKOUT_START
				CK_CHECK_MULTIPLE_NO3:
					CMP BL, 2
					JNE CK_CHECK_MULTIPLE_INVALID3

					CALL CHECK_MEMBERSHIP
					RET
				CK_CHECK_MULTIPLE_INVALID3:
					PRINT MSG2
					JMP CK_CHECK_MULTIPLE
			RET
		CHECKOUT_EXIT:
			CMP DL, 9			; EXIT
			JNE CHECKOUT_INVALID
			PRINT MSG3
			JMP TOP

		CHECKOUT_INVALID:
			PRINT MSG2
			JMP CHECKOUT

			RET
CHECKOUT_CAL ENDP

ADD_CUSTOMER PROC NEAR
	PRINT MEMBER_M1                                
    MOV AH, 0AH 			;CAPTURE CUSTOMER IC NUM.
    MOV DX, OFFSET MEMBER_IC_ADD
    INT 21H
	

	PRINT MEMBER_M2
	MOV AH, 0AH 			;CAPTURE MEMBER PHONE NUM.
    MOV DX, OFFSET MEMBER_PHONE_ADD
    INT 21H

	MEMBER_ADD:
		PRINT MEMBER_M3              
    	MOV AH, 9 					;DISPLAY STRING.
    	MOV DX, OFFSET STF_ID_ADD + 2	;MUST END WITH '$'.
   		INT 21H

		PRINT MEMBER_M4
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 30H
		MEMBER_YES:				;CONFIRM
			CMP BL, 1
			JNE MEMBER_NO
			PRINT MEMBER_M5
			RET
		MEMBER_NO:				;CANCEL
			CMP BL, 2
			JNE MEMBER_FAILED
			PRINT MEMBER_M6
			RET
		MEMBER_FAILED:
			PRINT MSG2
			JMP MEMBER_ADD
ADD_CUSTOMER ENDP

MEMBER_REMOVE PROC NEAR
	PRINT MEMBER_M1                                 
    MOV AH, 0AH 			;CAPTURE STRING FROM KEYBOARD.
    MOV DX, OFFSET MEMBER_IC_REMOVE
    INT 21H

	;CHANGE CHR(13) BY '$'.
    MOV SI, OFFSET MEMBER_IC_REMOVE+ 1 ;NUMBER OF CHARACTERS ENTERED.
    MOV CL, [SI] ;MOVE LENGTH TO CL.
    MOV CH, 00      ;CLEAR CH TO USE CX. 
    INC CX ;TO REACH CHR(13).
    ADD SI, CX ;NOW SI POINTS TO CHR(13).
    MOV AL, '$'
    MOV [SI], AL ;REPLACE CHR(13) BY '$'. 

	PRINT MEMBER_M2                               
    MOV AH, 0AH 			;CAPTURE STRING FROM KEYBOARD.
    MOV DX, OFFSET MEMBER_PHONE_REMOVE
    INT 21H  

	;CHANGE CHR(13) BY '$'.
    MOV SI, OFFSET MEMBER_PHONE_REMOVE+ 1 ;NUMBER OF CHARACTERS ENTERED.
    MOV CL, [SI] ;MOVE LENGTH TO CL.
    MOV CH, 00      ;CLEAR CH TO USE CX. 
    INC CX ;TO REACH CHR(13).
    ADD SI, CX ;NOW SI POINTS TO CHR(13).
    MOV AL, '$'
    MOV [SI], AL ;REPLACE CHR(13) BY '$'. 

	MEMBER_REMOVE1:
		PRINT MEMBER_REMV_M1
		PRINT MEMBER_REMV_M2
		CALL ACCEPT
		MOV BL, AL
		SUB BL, 30H

		MEM_RMV_YES:
			CMP BL, 1
			JNE MEM_RMV_NO
			PRINT MEMBER_REMV_M3
			RET
		MEM_RMV_NO:
			CMP BL, 2
			JNE MEM_RMV_INVALID
			PRINT MEMBER_REMV_M4
			RET
			
		MEM_RMV_INVALID:
			PRINT MSG2
			JMP MEMBER_REMOVE1    
MEMBER_REMOVE ENDP
;--------------EXIT PROGRAM
QUIT:				; EXIT PROGRAM
	MOV AH, 4CH
	INT 21H

	MAIN ENDP
END MAIN