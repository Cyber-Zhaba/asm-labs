.model small
.stack 100h

.data
  a   dw 169
  b   dw 125
  c   dw 5
  d   dw 14
  res dw ?

  digits db '0123456789ABCDEF'

  hexcom db 'HEX: $'
  bufhex db '####'
  bufhexend db '$'

  deccom db 'DEC: $'
  bufdec db '@@@@@'
  bufdecend db '$'

.code
start:
  mov ax, @data
  mov ds, ax

  ; b / c
  mov ax, b
  mov dx, 0
  div c

  add ax, a
  mul d
  sub ax, 4

  mov res, ax

  ; 1 HEX
  ; 1.1 подготовим буфер

  ;; чтобы работали сдвиги на 4
  mov cl, 4
  
  ;; подгружаем цифры
  mov bx, offset digits

  ;; первый раз подгружаем слово
  mov dx, res

  ;; Первая цифра
  and dl, 0Fh
  mov al, dl
  xlatb
  mov bufhex[3], al

  ;; Третья цифра
  and dh, 0Fh
  mov al, dh
  xlatb
  mov bufhex[1], al

  ;; второй раз подгружаем слово
  mov dx, res

  ;; Вторая цифра
  shr dl, cl
  mov al, dl
  xlatb
  mov bufhex[2], al

  ;; Четвёртая цифра
  shr dh, cl
  mov al, dh
  xlatb
  mov bufhex[0], al

  ;; 1.2 выводрим буфер
  mov ah, 09h
  lea dx, hexcom
  int 21h
  lea dx, bufhex
  int 21h

  ;; newline
  mov ah, 02h
  mov dl, 0Dh
  int 21h
  mov dl, 0Ah
  int 21h
  ;; newline

  ;; 2. DEC
  ;; 2.1 подготовим буфер
  mov ax, res
  mov bx, 10

  mov si, 4

dec_loop:
  mov dx, 0
  div bx
  add dl, '0'
  mov bufdec[si], dl
  sub si, 1

  or ax, ax
  jnz dec_loop
;; dec_loop

  mov ah, 09h
  lea dx, deccom
  int 21h
  lea dx, bufdec[si+1]
  int 21h

  ;; newline
  mov ah, 02h
  mov dl, 0Dh
  int 21h
  mov dl, 0Ah
  int 21h
  ;; newline

  mov ax, 4C00h
  int 21h

end start
