assume cs: code, ds: data

data segment
dummy db 0Dh, 0Ah, '$'
string db 100, 99 dup (0)
data ends

code segment ; считываем со стандартного потока строку и печатаем её обратно
start:	mov ax, data
		mov ds, ax
		mov dx, offset string
		xor ax, ax
		mov ah, 0Ah
		int 21h
	
    mov bl, string[1]
    xor bh, bh
    mov byte ptr string[bx+2], '$'

		mov dx, offset dummy ; перевод строки
		mov ah, 09h
		int 21h
		
		mov dx, offset string
		add dx, 2 ; первые два байта всё ещё заняты макс. и фактической длиной
		
		mov ah, 09h
		int 21h

		mov ah, 4ch
		int 21h
		code ends
		end start

; варианты заданий		
; 1. strcpy
; 2. strncpy
; 3. strcmp
; 4. strncmp
; 5. strchr
; 6. strcspn
; 7. strpbrk
; 8. strrchr
; 9. strspn
; 10. strstr
; 11. strlen (использовать операторы length и size ассемблера запрещено)
; 12. strcat
; 13. strncat
