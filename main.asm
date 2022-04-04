INCLUDE Irvine32.inc

.data
random_string BYTE 40 DUP(?), 0

string_size DWORD ?

intro_slide BYTE "Written by Tyler Zars and Grant Butler", 10,
                 "For CSE3210 Contest #1", 10 ,0

size_selection_string BYTE "Choose the difficulty (1-40 letters): ", 0

game_title BYTE "The Ultimate Typing Test",0

.code
    main PROC

        
        ; Print Start Info
        mov edx, offset intro_slide
        call WriteString

        ; wait (seconds x 1000) and clear everything
        INVOKE Sleep, 5000
        call Clrscr 

        ; Set console title name
        INVOKE SetConsoleTitle, ADDR game_title 

        ; Get user input for number of chars
        mov edx, offset size_selection_string
        call WriteString
        call readInt
        mov string_size, eax


        mov edx, 0 ; our looping value
        make_random_string:
            ; get a random char
	        call GenerateReandomChar
	        ; add it to the string
            mov random_string[edx], al
	        ; move edx to the next location
            inc edx

            cmp edx, string_size ; THIS VALUE DECIDES WHAT HOW MANY CHARS WE GET
	        
            ; jump while we are below, this allows us to add one extra space at the end of the newline
            jb make_random_string
            
            ; add the newline to the end
            mov random_string[edx], 0Ah

        ; printing for testing
        mov edx, offset random_string
        call WriteString


        ; wait before exit
        call WaitMsg
        exit
    main ENDP

    GenerateReandomChar PROC
        ; This proc returns AL with a random uppercase letter

        ; start in lowercase and get a random in the range
        mov eax, 26
        call RandomRange
            
        ; make it uppercase
        add eax, 65
	    ret
    GenerateReandomChar ENDP

END main