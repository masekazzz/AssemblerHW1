format PE console   ; Ôîðìàò âûõîäà

entry Start         ; Òî÷êà âõîäà

include 'win32a.inc'

section '.data' data readable writable          ; Ñåêöèÿ ñî âñåìè íóæíûìè ïåðåìåííûìè è ñèìâîëàìè

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

section '.code' code readable executable     ; Îïèñàíèå ðàáîòû ñàìîé ïðîãðàììû

        Start:
                push strA        ; Ñ÷èòûâàíèå ïåðâîãî ÷èñëà
                call [printf]

                push A
                push spaceStr
                call [scanf]

                push strB        ; Ñ÷èòûâàíèå âòîðîãî ÷èñëà
                call [printf]

                push B
                push spaceStr
                call [scanf]

                push strOp       ; Ñ÷èòûâàíèå îïåðàöèè +, -, *, / èëè %
                call [printf]

                call [getch]

                cmp eax, 43  ; ñóììà
                jne notAdd
                    mov ecx, [A]
                    add ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                notAdd:

                cmp eax, 45  ; ðàçíîñòü
                jne notSub
                    mov ecx, [A]
                    sub ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                notSub:

                cmp eax, 42  ; Óìíîæåíèå
                jne notMul
                    mov ecx, [A]
                    imul ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish
                notMul:
                cmp eax, 37  ; Äåëåíèå mod
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
                    notNullDiv: ; Äåëåíèå íå íà íîëü

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

                cmp eax, 47         ; Äåëåíèå div
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
                    notNullDiv1:   ; Äåëåíèå íå íà íîëü

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


section '.idata' import data readable        ; Ñåêöèÿ ñ èìïîðòîì áèáëèîòåê

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'
