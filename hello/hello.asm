.MODEL SMALL                    ; код и данные — по одному сегменту до 64K
.STACK 100h                     ; 256 байт под стек

.DATA
    msg     DB 'Hello, World!', 0Dh, 0Ah, '$'
    ;                            ^^^  ^^^   ^
    ;                            CR   LF    признак конца строки для DOS

.CODE
start:
    mov  ax, @DATA              ; @DATA — адрес сегмента данных,
    mov  ds, ax                 ; напрямую в DS его не записать, только через AX

    mov  ah, 09h                ; функция DOS 09h — вывести строку
    lea  dx, msg                ; DS:DX должны указывать на строку
    int  21h                    ; вызвать DOS

    mov  ax, 4C00h              ; функция 4Ch — выход, AL = код возврата (0)
    int  21h

END start                       ; точка входа в программу
