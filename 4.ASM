format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable  ; Секция с нужными метками

        en db 'Enter number: ', 0
        lor db 'Enter l or r: ', 0
        formatNum db '%d', 0

        resStr db 'Result: %d', 0
        resMod db '\%d', 0

        A dd ?

        NULL = 0


section '.code' code readable executable ; Секция с самим выполнением программы

        start:

                push en                ; Вывод запроса числа
                call [printf]

                push A                 ; Считывание числа
                push formatNum
                call [scanf]

                push lor               ; Вывод запроса о том влево или вправо надо сдвигать
                call [printf]

                call [getch]           ; Чтобы консоль не закрылась

                cmp eax, 108           ; Если надо свигать влево
                jne notL

                mov ecx, [A]
                shl ecx, 2

                push ecx
                push resStr
                call [printf]

                jmp finish

        notL:
                cmp eax, 114           ; Если надо сдвигать вправо
                jne finish

                mov ecx, [A]
                shr ecx, 2

                push ecx
                push resStr
                call [printf]

                jmp finish

        finish:

                call [getch]           ; Чтобы консоль не закрылась сразу

                push NULL
                call [ExitProcess]

section '.idata' import data readable  ; Секция, в которой мы импортируем нужные библиотеки

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'
