.model small
.stack 100h

.data
  a   dw 2
  b   dw 2
  c   dw 2
  d   dw 3
  res dw ?

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

  mov ax, 4C00h
  int 21h

end start
