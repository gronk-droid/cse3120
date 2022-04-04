INCLUDE Irvine32.inc

.data
start_tick DWORD ?
elapsed_time DWORD ?
timer DWORD ?
timer_string BYTE ?


.code
; records the starting tick of the typing test and sets timer to 0
startTimer PROC
    ; set starting tick
    call GetTickCount
    mov start_tick, eax

    ; set timer to 0
    mov timer, 0
startTimer ENDP

; record end tick and set timer to time
endTimer PROC
    ; get ending time of program
    call GetTickCount
    mov elapsed_time, eax

    ; (end - start) = elapsed time in ms
    sub elapsed_time, start_tick

    ; ms →  s = (t ms)*0.001
    mov eax,
    mov ebx, elapsed_time


endTimer ENDP



ENDP startTimer
