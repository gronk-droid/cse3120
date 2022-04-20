# Lab 11.1 Windows in console mode

In this lab you will combine your results in a single .doc file, but also submit individually each file. You will start by running two basic programs using the Windows API, and then you will address one of the tasks proposed by the book.



1. Load and run program ch11\MessageBox.asm

The relevant Windows procedure is:

```as
MessageBox PROTO,
  hWnd:DWORD,
  pText:PTR BYTE,
  pCaption:PTR BYTE,
  style:DWORD
```

Possible options for style are:
`MB_OK, MB_YESNO, MB_YESNOCANCEL, MB_DEFBUTTON2, MB_ICONQUESTION, MB_ICONERROR, MB_ICONEXCLAMATION, MB_ICONINFORMATION, MB_ICONSTOP`

Upload a snapshot of the execution.

Write how many types of message boxes were used, and what was the difference in the code needed to generate them?

2. Load and run `ch11\ReadConsole.asm`

Upload a snapshot of the execution after DumpMem, displaying the buffer in the watch to see the whole string, with &buffer.

3. Load and run `ch11\Console1.asm`

Upload a snapshot of the execution just before exit.

4.  Problem 11.8   2.

Write a program that inputs user information (first/last name, age, phone) with ReadConsole, then display it with WriteConsole. Do not use the Irvine input/output procedures. You may inspire yourself from the program ch11\Console2.asm to control better a nice layout of the questions on the screen.

Relevant Windows procedure signatures are:

```as
GetStdHandle PROTO,
 nStdHandle:DWORD  ; handle type
```

Possible types being: `STD_INPUT_HANDLE, STD_OUTPUT_HANDLE, STD_ERROR_HANDLE`
```as
ReadConsole PROTO,
  handle:DWORD,  ; input handle
  pBuffer:PTR BYTE,  ; pointer to buffer
  maxBytes:DWORD,  ; number of chars to read
  pBytesRead:PTR DWORD,  ; ptr to num bytes read
  notUsed:DWORD  ; (not used)
```

```as
WriteConsole PROTO,
  handle:DWORD,  ; output handle
  pBuffer:PTR BYTE,  ; pointer to buffer
  bufsize:DWORD,  ; size of buffer
  pCount:PTR DWORD,  ; output count
  lpReserved:DWORD  ; (not used)
  ```

The layout should be:
><span style="color: #000000; background-color: #ced4d9;">First Name:&nbsp; &nbsp; <span style="background-color: #fbeeb8;">Marius     </span></span><br><span style="color: #000000; background-color: #ced4d9;">Last Name:&nbsp; &nbsp; &nbsp;<span style="background-color: #fbeeb8;">Silaghi    </span></span><br><span style="color: #000000; background-color: #ced4d9;">Age:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="background-color: #fbeeb8;">N/A        </span></span><br><span style="color: #000000; background-color: #ced4d9;">Phone:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="background-color: #fbeeb8;">3216747493 </span></span></br></br></br><span style="color: #000000; background-color: #ecf0f1;">Marius     </span><br><span style="color: #000000; background-color: #ecf0f1;">Silaghi    </span><br><span style="color: #000000; background-color: #ecf0f1;">N/A        </span><br><span style="color: #000000; background-color: #ecf0f1;">3216747493 </span>

Upload source and a snapshot.
