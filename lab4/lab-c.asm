
.model small
.stack 100h

nowarn pdc
DEF macro X, T, N, V
  ifb <X>
    %out /!\ name cannot be empty
    .err
    exitm
  endif

  ifb <T>
    %out /!\ type cannot be empty
    .err
    exitm
  endif

  ifb <N>
    %out /!\ size cannot be empty
    .err
    exitm
  endif

  if N le 0
    %out /!\ size must be positive
    .err
    exitm
  endif

  ifdef X
    %out X alredy defined
    .err
    exitm
  endif

  ifidni <T>,<B>
    ifb <V>
      X db N dup(?)
    else
      X db N dup(V)
    endif
  elseifidni <T>,<W>
    ifb <V>
      X dw N dup(?)
    else
      X dw N dup(V)
    endif
  else
    %out /!\ T is not W or B
    .err
  endif
endm

.data
  DEF Arr1, B, 15, 42
  ; DEF Arr1, B, 10, 42
  DEF Arr2, W, 8,
  DEF Arr3, B, 15, 67

  ; DEF Arr4, bibob, 15, 15
  ; DEF Arr5, W, 0, 1
  ; DEF Arr6, B, -1, 0

.code
start:
  mov ax, @data
  mov ds, ax

  mov ax, 4C00h
  int 21h

end start
