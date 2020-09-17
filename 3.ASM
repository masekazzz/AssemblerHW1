format PE console

entry start

include 'win32a.inc'


section '.data' data readable writable    ; Секция с нужными метками

        formatStr db '%s', 0
        formatNum db '%d', 0

        name rd 2
        age rd 1

        wn db 'What is your name? ', 0
        ho db 'How old are you? ', 0
        hello db 'Hello %s, ', 0
        by db 'you were born in %d', 0

        NULL = 0
        A dd ?

section '.code' code readable executable ; Секция с самим выполнением программы

        start:
                push wn            ; Вызов надписи с вопросом об имени
                call [printf]

                push name          ; Считывание имени
                push formatStr
                call [scanf]

                push ho            ; Вызов надписи с вопросом о возрасте
                call [printf]

                push age           ; Считывание возраста
                push formatNum
                call [scanf]

                push name          ; Вызов надписи с приветствием
                push hello
                call [printf]

                mov [A], 2020      ; Вычисление года рождения

                        mov ecx, [A]
                        sub ecx, [age]

                push ecx           ; Вызов надписи с информацией о годе рождения
                push by
                call [printf]

                call [getch]       ; Вызов функции, чтобы консоль закрылась не сразу

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