format PE console   ; Формат выхода

entry Start         ; Точка входа

include 'win32a.inc'

section '.data' data readable writable          ; Секция со всеми нужными переменными и символами

        strA db 'Enter A: ', 0
        strB db 'Enter B: ', 0
        strOp db 'Enter operation: ', 0

        resStr db 'Result: %d', 0
        resMod db '\%d', 0

        spaceStr db ' %d', 0
        emptyStr db '%d', 0

        infinity db 'infinity', 0
        point db ',', 0

        A dd ?
        B dd ?
        C dd ?

        NULL = 0

section '.code' code readable executable     ; Описание работы самой программы

        Start:
                push strA        ; Считывание первого числа
                call [printf]

                push A
                push spaceStr
                call [scanf]

                push strB        ; Считывание второго числа
                call [printf]

                push B
                push spaceStr
                call [scanf]

                push strOp       ; Считывание операции +, -, *, / или %
                call [printf]

                call [getch]

                cmp eax, 43  ; сумма
                jne notAdd
                    mov ecx, [A]
                    add ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                notAdd:

                cmp eax, 45  ; разность
                jne notSub
                    mov ecx, [A]
                    sub ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                notSub:

                cmp eax, 42  ; Умножение
                jne notMul
                    mov ecx, [A]
                    imul ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                notMul:
                cmp eax, 37  ; Деление mod
                jne notMod
                    mov eax, [A]
                    mov ecx, [B]
                    mov edx, 0

                    cmp [B], 0
                    jne notNullDiv

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                    notNullDiv: ; Деление не на ноль

                    div ecx
                    mov [C], edx

                    push eax
                    push resStr
                    call [printf]

                    push [C]
                    push spaceStr
                    call [printf]

                    push [B]
                    push resMod
                    call [printf]

                    jmp finish
                notMod:

                cmp eax, 47         ; Деление div
                jne finish
                    mov eax, [A]
                    mov ecx, [B]
                    mov edx, 0

                    cmp [B], 0
                    jne notNullDiv1

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                    notNullDiv1:   ; Деление не на ноль

                    div ecx
                    mov [C], edx

                    push eax
                    push resStr
                    call [printf]

                    push point
                    call [printf]

                    mov ebx, 0
                    lp:

                         mov edx, 0
                         div ecx
                         mov [C], edx

                          push eax
                          push emptyStr
                          call [printf]

                         add ebx, 1
                         cmp ebx, 3
                     jne lp

                     jmp finish

                finish:

                call [getch]

                push NULL
                call [ExitProcess]


section '.idata' import data readable        ; Секция с импортом библиотек

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'
