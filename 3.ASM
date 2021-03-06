format PE console

entry start

include 'win32a.inc'


section '.data' data readable writable    ; ������ � ������� �������

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

section '.code' code readable executable ; ������ � ����� ����������� ���������

        start:
                push wn            ; ����� ������� � �������� �� �����
                call [printf]

                push name          ; ���������� �����
                push formatStr
                call [scanf]

                push ho            ; ����� ������� � �������� � ��������
                call [printf]

                push age           ; ���������� ��������
                push formatNum
                call [scanf]

                push name          ; ����� ������� � ������������
                push hello
                call [printf]

                mov [A], 2020      ; ���������� ���� ��������

                        mov ecx, [A]
                        sub ecx, [age]

                push ecx           ; ����� ������� � ����������� � ���� ��������
                push by
                call [printf]

                call [getch]       ; ����� �������, ����� ������� ��������� �� �����

                push NULL
                call [ExitProcess]



section '.idata' import data readable  ; ������, � ������� �� ����������� ������ ����������

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'