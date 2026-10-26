.model small
.stack 100h

;; https://en.cppreference.com/c/src/byte/strncpy
;; char* strncpy( char* dest, const char* src, size_t count );

.data
  dummy1 db 8 dup (0)
  src    db 12, 11 dup (0)
  dummy2 db 6 dup (0)
  dest   db 12 dup ('#'), '$'
  n      dw 9

.code
input proc
  mov dx, offset src
  xor ax, ax
  mov ah, 0Ah
  int 21h

  mov bl, src[1]
  xor bh, bh
  mov byte ptr src[bx+2], '$'
  ret
input endp

strncpy proc
	push bp
	mov bp, sp
  push ax
  push cx
  push si
  push di

  ;; | [bp]    | bp
  ;; | [bp+2]  | адрес возврата
  ;; | [bp+4]  | dest
  ;; | [bp+6]  | src
  ;; | [bp+8]  | n
  ;; | [bp+10] | слот возврата

  mov cx, [bp+8] ; cx = n
  jcxz return
  mov si, [bp+6] ; si = src
  mov di, [bp+4] ; di = dest
  
  cpy:
    mov al, [si]
    mov [di], al
    inc di
    cmp al, '$'
    je skip_inc
    inc si
    skip_inc:
    loop cpy

  return:
    mov ax, [bp+4]
    mov [bp+10], ax
    pop di
    pop si
    pop cx
    pop ax
    pop bp
    ret 6
strncpy endp

start:
  mov ax, @data
  mov ds, ax

  call input

  sub sp, 2
  push n
  lea ax, src + 2
  push ax
  lea ax, dest
  push ax
  call strncpy

  pop dx
  mov ah, 09h
  int 21h

  mov ax, 4C00h
  int 21h
end start
