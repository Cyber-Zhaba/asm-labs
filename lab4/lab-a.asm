.model small
.stack 100h

.data
  A db 3
  B db 3
  C dw 2
  D db 3
  E db 3
  F dw 2

.code
start:
  mov ax, @data
  mov ds, ax

  irp v, <A, B, C, D, E, F>
    ifndef v
      %out /!\ variable v not defined
      .err
    else
      if type v eq 1
        add v, 1
      elseif type v eq 2
        add v, 2
      else
        %out /!\ variable v is not word or byte
        .err
      endif
    endif
  endm

  mov ax, 4C00h
  int 21h

end start
