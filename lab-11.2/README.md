Bundle your submission in a single .doc or .docx file, besides individual files.

 

1. Load and execute the program Heaptest1.asm

Upload a snapshot of the execution showing the console display before exit.

2. Load the program ch11\WinApp.asm.

Modify your Project configuration:. Right-click on "Project" in solution explorer. Select: "Properties->Linker->System". Select "SubSystem=Windows" instead of console.

In Properties->Linker->Input, for "Additional Dependencies" you can add "kernel32.lib".

Execute your program and take a snapshot of the message that displays after clicking in the program window.

Note during debugging that the main relevant structures are as follows.

The message for events is:
```
MSGStruct STRUCT
 msgWnd  DWORD ?
 msgMessage  DWORD ?
 msgWparam  DWORD ?
 msgLparam  DWORD ?
 msgTime  DWORD ?
 msgPt  POINT <>
MSGStruct ENDS

POINT STRUCT
 ptX DWORD ?
 ptY DWORD ?
POINT ENDS
 
The filled window descriptor is:

WNDCLASS STRUC
 style         DWORD ?  ; window style options
 lpfnWndProc   DWORD ?  ; WinProc function pointer
 cbClsExtra   DWORD ?  ; shared memory
 cbWndExtra   DWORD ?  ; number of extra bytes
 hInstance     DWORD ?  ; handle to current program
 hIcon         DWORD ?  ; handle to icon
 hCursor       DWORD ?  ; handle to cursor
 hbrBackground DWORD ?  ; handle to background brush
 lpszMenuName DWORD ?  ; pointer to menu name
 lpszClassName DWORD ?  ; pointer to WinClass name
WNDCLASS ENDS
```

3. The WinProc procedure receives the x coordinate of the mouse click in the least significant WORD of lParam.

Modify your program by inserting before the 0 of PopupText a 4 bytes buffer, to look like:
```
PopupText BYTE "This window was activated by a BUTTON down message at x="
PopupTextXPos=$-PopupText
popupx    BYTE 4 DUP(? )
            BYTE 0
PopupTextSize=$-PopupText
```

Then, modify the procedure WinProc to start by converting the low word in lParam into a 4 digits ASCII decimal representation (by repeated unsigned division with 10 of the value, and xor reminder with 30h). You can use the registers ecx, ebx=10, and eax/edx for the division. You may use 4 steps, a loop, and when appropriate aam.

The signature of the callback is:
```
WinProc PROC,
  hWnd:DWORD,  ; handle to the window
  localMsg:DWORD,   ; message ID
  wParam:DWORD,   ; parameter 1 (varies)
  lParam:DWORD  ; parameter 2 (varies)
``` 

Upload a snapshot of the obtained message, and the source of the procedure (only).

4. Inspiring from the program at Task 1, modify your program at Task 3, such that WinProc allocates dynamically the buffer where it constructs the text to be displayed, and copies in that buffer the original PopupText string and value of x. Use string copy instruction "rep movsb", saving registers as appropriate. After the window is displayed, free the memory from the heap (just before the WinProcExit label, or after the message is displayed). Do not forget to change the corresponding MessageBox text address parameter to pBuffer.

Use the functions: GetProcessHeap, HeapAlloc, and HeapFree.... and WriteWindowsMsg (or ErrorHandler) for handling errors. You can see sample solutions at:  https://drive.google.com/file/d/1Phg3hvAba5ogvoixpGdX5fXfOo3NepqI/viewusp=sharing

https://drive.google.com/file/d/1j7z0NZ5oxvarSbiD8bSy5sribcl3QPOu/view?usp=sharing

The relevant heap management code is as follows.
```
hProcHeap HANDLE ?
pBuffer DWORD ?   ; pointer to buffer
...
INVOKE GetProcessHeap
.IF eax == NULL   ; cannot get handle
 call WriteWindowsMsg 
 ; jmp ... exit
.ELSE
  mov hProcHeap,eax   ; handle is OK
.ENDIF
INVOKE HeapAlloc, hProcHeap, HEAP_ZERO_MEMORY, <desired size of buffer>
.IF eax == NULL
  call WriteWindowsMsg
  ; jmp .... exit
.ELSE
  mov pBuffer,eax
.ENDIF
INVOKE HeapFree,
  hProcHeap,   ; handle to heap
  0,   ; flags
  pBuffer
 ```

Submit source sections written, and the snapshot after mouse clicks. 

