format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable  ; ������ � ������� �������

        en db 'Enter number: ', 0
        lor db 'Enter l or r: ', 0
        formatNum db '%d', 0

        resStr db 'Result: %d', 0
        resMod db '\%d', 0

        A dd ?

        NULL = 0


section '.code' code readable executable ; ������ � ����� ����������� ���������

        start:

                push en                ; ����� ������� �����
                call [printf]

                push A                 ; ���������� �����
                push formatNum
                call [scanf]

                push lor               ; ����� ������� � ��� ����� ��� ������ ���� ��������
                call [printf]

                call [getch]           ; ����� ������� �� ���������

                cmp eax, 108           ; ���� ���� ������� �����
                jne notL

                mov ecx, [A]
                shl ecx, 2

                push ecx
                push resStr
                call [printf]

                jmp finish

        notL:
                cmp eax, 114           ; ���� ���� �������� ������
                jne finish

                mov ecx, [A]
                shr ecx, 2

                push ecx
                push resStr
                call [printf]

                jmp finish

        finish:

                call [getch]           ; ����� ������� �� ��������� �����

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
