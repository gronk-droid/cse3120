; Written by Tyler Zars & Grant Butler
; CSE3210 Contest #1

INCLUDE Irvine32.inc

.data
random_string BYTE 41 DUP(?), 0

string_size DWORD ?

intro_slide BYTE "Written by Tyler Zars and Grant Butler", 10,
                 "For CSE3210 Contest #1", 10 ,0

instruction_string BYTE "Hi! Welcome to the Ultimate Typing Test!", 10,
                        "This test will give you a random string of letters,", \
                        "both upper and lowercase for you to type.", 10,
                        "You will be prompted for the number of letters to enter", \
                        "and then a countdown will begin.", 10, 0

instruction_string_2 BYTE "After 1, the screen will change to reveal the word",
                          "and you can begin typing it.", 10,
                          "Type the letters, wrong letters are fine",
                          "and will be shown after completion!", 10,
                          "Good luck and get those typing skills up!!!!", 10, 0

random_word_header BYTE "Random String: ", 0

size_selection_string BYTE "Choose the difficulty (1-40 letters): ", 0

get_input_string BYTE "Enter the above characters: ", 0

game_title BYTE "The Ultimate Typing Test",0

user_input_string BYTE 41 DUP(?), 0

; Play again vars
play_again_prompt BYTE "Do you want to play again (Y = Yes (capital), N = No)? ", 10, 0
user_play_again BYTE 5 DUP(?), 0

thanks_for_playing BYTE "Thanks for playing!!", 10, 0

.code
    main PROC
        ; Print Start Info
        mov edx, offset intro_slide
        call WriteString

        ; Set console title name
        INVOKE SetConsoleTitle, ADDR game_title 

        ; wait (seconds x 1000) and clear everything
        INVOKE Sleep, 1000
        call Clrscr 

        ; Print Gameplay Info
        mov edx, offset instruction_string
        call WriteString

        mov edx, offset instruction_string_2
        call WriteString

        ; Wait (seconds x 1000) [clear is done in game loop]
        INVOKE Sleep, 7000

        main_game_loop:
            ; Reset the random seed for a new string each run!
            call Randomize

            ; Reset word
            mov ebx, 0
            reset_word:
                mov random_string[ebx], 0
                inc ebx
                cmp ebx, string_size
                jle reset_word
            
            ; Reset string size
            mov string_size, 000000000h

            ; Wait (seconds x 1000) and clear everything
            INVOKE Sleep, 1000
            call Clrscr 

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
                
                ; string_size decides number of chars
                cmp edx, string_size
	        
                ; jump while we are below, this allows us to add one extra space at the end of the newline
                jb make_random_string
            
                ; add the newline to the end
                mov random_string[edx], 0Ah

            ; Small countdown to kick off the game
            mov eax, 3
            countdown:
                call WriteInt
                dec eax
                call Crlf
                push eax
                INVOKE Sleep, 1000 ; uses EAX so we put it on the stack for keeping
                pop eax
                cmp eax, 0
                jne countdown

            ; Print the random word out
            mov edx, OFFSET random_word_header ; print the header
            call WriteString
            mov edx, OFFSET random_string ; print the actual string
            call WriteString

            ; Put user input prompt on screen
            mov edx, OFFSET get_input_string
            call WriteString

            ; get user input
            mov  edx, OFFSET user_input_string
            mov  ecx, string_size
            inc ecx ; Add one more for the null char
            call ReadString

            mov ebx, 0 ; our looping value
            check_if_correct_loop:
                ; move for comparison and do the comparison between words
                mov al, user_input_string[ebx]
                cmp al, random_string[ebx]

                jne wrong_letter
                je correct_letter
            
                ; If wrong, change background color to red
                wrong_letter:
                   ; Line up to the correct character
                    mov  dl, bl  ; column

                    mov al, LENGTHOF get_input_string
                    sub al, 1 ; remove null char
                
                    add dl, al
                    mov dh, 5  ; row
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

                ; If right, change background color to green
                correct_letter:
                    ; Line up to the correct character
                    mov  dl, bl  ; column

                    mov al, LENGTHOF get_input_string
                    sub al, 1 ; remove null char
                
                    add dl, al
                    mov dh, 5  ; row
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

            ; Loop game!!!!
            ; Put user input prompt on screen
            mov edx, OFFSET play_again_prompt
            call WriteString

            ; get user input for looping
            mov  edx, OFFSET user_play_again
            mov  ecx, 1
            inc ecx ; Add one more for the null char
            call ReadString

            mov al, user_play_again[0]
            cmp al, "Y"
            je main_game_loop

        ; Thanks for playing
        mov edx, OFFSET thanks_for_playing
        call WriteString
        exit
    main ENDP

    GenerateReandomChar PROC
        ; This proc returns AL with a random uppercase letter

        ; Choose a random letter
        mov eax, 26
        call RandomRange

        ; Move to ebx for storage
        mov ebx, eax

        ; Generate a random number and compare to choose upper/lower case
        mov eax, 2
        call RandomRange
        cmp eax, 1
        je uppercase_letter ; 1 = uppercase
        jne lowercase_letter 

        uppercase_letter:
            ; make it uppercase
            add ebx, 65
            jmp finish_GenerateReandomChar
        
        lowercase_letter:
            ; make it lowercase
            add ebx, 97
            jmp finish_GenerateReandomChar

        finish_GenerateReandomChar:
            mov eax, ebx ; send it back in al properly
	        ret
    GenerateReandomChar ENDP
END main