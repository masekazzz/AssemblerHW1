format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable    ; Секция с нужными метками

        helloStr db 'Hello world!', 0

        NULL = 0                          ; Определять NULL нужно самим

section '.code' code readable executable ; Секция с самим выполнением программы

        start:
                push helloStr      ; Помещение в стек строки
                call [printf]      ; Вызов функции печати в консоль

                call [getch]       ; Вызов функции, чтобы консоль не закрылась сразу

                push NULL          ; Очищение стека
                call [ExitProcess] ; Окончание программы

section '.idata' import data readable  ; Секция, в которой мы импортируем нужные библиотеки

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch'