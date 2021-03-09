.MODEL SMALL
.STACK 64

;----------------------Data Segment----------------
.DATA	;data definition 
	MSG1 DB 13, 10, "Enter the Quantity (unit): $"

;----------------------Code Segment---------------- to unmount mount -u D (mount Char)
.CODE	
MAIN PROC FAR
 	MOV AX,@DATA  ; Define data segment
	MOV DS,AX		

 	;codes
	mov ah, 3d
  mov al, 00
  mov dx, read
  int 21
  mov si, ax
  mov ah, 3f
  mov bx, si
  mov cx, 5
  mov dx, 200
  int 21
  mov ah, 09
  mov dx,200
  int 21
  int 20

a 150
  db 'ww.txt', 00

  a 200
  db 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 24
	

	
	;----- EXIT PROGRAM
 	MOV AX,4C00H
 	INT 21H

	MAIN ENDP
	END MAIN