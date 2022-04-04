INCLUDE Irvine32.inc

.data
random_string DWORD 20 DUP(?)

.code
    main PROC
        call Clrscr ; clear everything


        mov esi, offset random_string ; prep var
        call GenerateRandomString ; call random make method


        ; printing for testing
        mov edx, offset random_string
        call WriteString


        ; wait before exit
        call WaitMsg
        exit
    main ENDP

    GenerateRandomString PROC
        mov ecx, lengthOf random_string ; length
        L2:
            ; start in lowercase
            mov eax, 26
            call RandomRange

            ; make it uppercase
            add eax, 65

            ; write to the screen (can be removed once working)
            mov [esi], eax
            call WriteChar ; write character

            ; save the string
            mov random_string[ecx], eax
        loop L2


        call Crlf
        ret
    GenerateRandomString ENDP

END main
