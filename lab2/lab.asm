.model small
.stack 100h

.data
  arr dw -1, 7, -100, 2, 4 ,-5, 8, 3
  ;       0  1     2  3  4   5  6  7
  ; arr dw -3, -6, -2, -8
  ; ;       0   1   2   3

  nb dw ($-arr)

  bufdec    db '@@@@@'
  bufdecend db '$'

.code
start:
  mov ax, @data
  mov ds, ax

  mov si, 0
  mov di, 0
  mov dx, arr

  for_loop:
    mov ax, word ptr arr[si]
    cmp ax, dx
    jle skip
      mov di, si
      mov dx, ax
    skip:

    add si, 2
    cmp si, nb
    jne for_loop
  ;; for_loop

  ;; вывод индекса
  mov ax, di
  shr ax, 1
  mov cx, dx

  mov bx, 10
  mov si, 4

  dec_loop1:
    mov dx, 0
    div bx
    add dl, '0'
    mov bufdec[si], dl
    sub si, 1

    or ax, ax
    jnz dec_loop1
  ;; dec_loop1

  mov ah, 09h
  lea dx, bufdec[si+1]
  int 21h

  ;; newline
  mov ah, 02h
  mov dl, 0Dh
  int 21h
  mov dl, 0Ah
  int 21h
  ;; newline

  ;; вывод элемента
  mov ax, cx

  ;; отрицательные
  mov si, 4
  cmp ax, 0
  jge dec_loop2
  mov dl, '-'
  mov ah, 02h
  int 21h
  mov ax, cx
  neg ax

  dec_loop2:
    mov dx, 0
    div bx
    add dl, '0'
    mov bufdec[si], dl
    sub si, 1

    or ax, ax
    jnz dec_loop2
  ;; dec_loop2

  mov ah, 09h
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
