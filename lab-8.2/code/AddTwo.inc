; header
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
; exit PROTO

; use private proc option
OPTION PROC:PRIVATE

; make AddTwo a proto
AddTwo PROTO

DumpRegs PROTO

EXTERNDEF sum:DWORD
