INCLUDE Irvine32.inc

writeAtXY MACRO position, buffer, lenbuffer
    INVOKE SetConsoleCursorPosition, outputConsole, position
    INVOKE WriteConsole, outputConsole, ADDR buffer, lenbuffer, ADDR writtenBytes, 0
ENDM

readAtXY MACRO position, buffer, lenbuffer, result
    INVOKE SetConsoleCursorPosition, outputConsole, position
    INVOKE ReadConsole, inputConsole, ADDR buffer, lenbuffer, ADDR result, 0
ENDM

LENLABEL = 20
BUFSIZE = 30
labelInfo MACRO position, X, Y, nfield, vfield, positionRead, buffer, lReadBytes, positionResult
    position COORD<X, Y>
    nfield BYTE vfield
    positionRead COORD<X+LENLABEL, Y>
    positionResult COORD<X, Y+10>
    buffer BYTE BUFSIZE DUP(?)
    lReadBytes DWORD ?
ENDM

.data
inputConsole HANDLE 0
outputConsole HANDLE 0

writtenBytes DWORD ?

labelInfo p1, 0, 0, n1, <"First Name:", 0>, pr1, b1, rb1, pre1
labelInfo p2, 0, 1, n2, <"Last Name:", 0>, pr2, b2, rb2, pre2
labelInfo p3, 0, 2, n3, <"Age:", 0>, pr3, b3, rb3, pre3
labelInfo p4, 0, 3, n4, <"Phone:", 0>, pr4, b4, rb4, pre4

.code
main PROC
    ; get console handles/ptrs
    INVOKE GetStdHandle, STD_INPUT_HANDLE
    mov inputConsole, eax

    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputConsole, eax

    ; writing out the messages
    writeAtXY p1, n1, <sizeof n1>
    writeAtXY p2, n2, <sizeof n2>
    writeAtXY p3, n3, <sizeof n3>
    writeAtXY p4, n4, <sizeof n4>

    ; read in data
    readAtXY pr1, b1, <sizeof b1>, rb1
    readAtXY pr2, b2, <sizeof b2>, rb2
    readAtXY pr3, b3, <sizeof b3>, rb3
    readAtXY pr4, b4, <sizeof b4>, rb4

    ; write it out
    writeAtXY pre1, b1, rb1
    writeAtXY pre2, b2, rb2
    writeAtXY pre3, b3, rb3
    writeAtXY pre4, b4, rb4



    exit
main ENDP

END main
