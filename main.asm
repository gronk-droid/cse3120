INCLUDE Irvine32.inc

.data
random_string BYTE 41 DUP(?), 0

string_size DWORD ?

intro_slide BYTE "Written by Tyler Zars and Grant Butler", 10,
                 "For CSE3210 Contest #1", 10 ,0

size_selection_string BYTE "Choose the difficulty (1-40 letters): ", 0


get_input_string BYTE "Enter the above characters: ", 0

game_title BYTE "The Ultimate Typing Test",0

user_input_string BYTE 41 DUP(?)

start_tick DWORD ?
elapsed_time DWORD ?
seconds REAL4 ?
timer_string BYTE ?

ms_conversion REAL4 0.001

.code
    main PROC        
        ; Print Start Info
        mov edx, offset intro_slide
        call WriteString

        ; wait (seconds x 1000) and clear everything
        INVOKE Sleep, 1000
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

        ; Print the random word out
        mov edx, OFFSET random_string
        call WriteString

        ; Put user input prompt on screen
        mov edx, OFFSET get_input_string
        call WriteString

        ; get user input
        mov  edx, OFFSET user_input_string
        mov  ecx, string_size
        call ReadString

        mov ebx, 0 ; our looping value
        check_if_correct_loop:
            
            ; move for comparison and do the comparison between words
            mov al, user_input_string[ebx]
            cmp al, random_string[ebx]

            jne wrong_letter
            je correct_letter
            
            ; If wrong do something
            wrong_letter:
               ; Line up to the correct character
                mov  dl, bl  ; column

                mov al, LENGTHOF get_input_string
                sub al, 1
                
                add dl, al
                mov dh, 2  ; row
                call Gotoxy

                ; set our new text color
                mov  eax, white + (red * 16)
                call SetTextColor

                ; write the corresponding char in the new color
                mov  al, user_input_string[ebx]
                call WriteChar

                ; reset the color
                mov  eax, white + (black * 16)
                call SetTextColor
                
                jmp end_loop

            ; If right do something
            correct_letter:
                ; Line up to the correct character
                mov  dl, bl  ; column

                mov al, LENGTHOF get_input_string
                sub al, 1
                
                add dl, al
                mov dh, 2  ;row
                call Gotoxy

                ; set our new text color
                mov  eax, yellow + (green *16)
                call SetTextColor

                ; write the corresponding char in the new color
                mov  al, user_input_string[ebx]
                call WriteChar

                ; reset the color
                mov  eax, white + (black*16)
                call SetTextColor
                
                jmp end_loop

            end_loop:
                ; Loop if needed
                inc ebx
                cmp ebx, string_size
                jb check_if_correct_loop
        
        call Crlf

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

    ; records the starting tick of the typing test and sets timer to 0
    startTimer PROC
        ; set starting tick
        call GetTickCount
        mov start_tick, eax
        ret
    startTimer ENDP

    ; record end tick and set timer to time
    endTimer PROC
        ; get ending time of program
        call GetTickCount

        ; (end - start) = elapsed time in ms
        sub eax, start_tick
        mov elapsed_time, eax

        ; ms →  s = (t ms)*0.001
        finit                           ; initialize floating point processor
        fld DWORD PTR [elapsed_time]    ; push elapsed_time onto stack
        fld DWORD PTR [ms_conversion]   ; push conversion onto stack
        fmul                            ; multiply
        fstp DWORD PTR [seconds]        ; store as REAL4 in seconds
        ret
    endTimer ENDP

END main
