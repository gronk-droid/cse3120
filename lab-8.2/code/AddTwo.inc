.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

OPTION PROC:PRIVATE

AddTwo PROTO

DumpRegs PROTO

EXTERNDEF sum:DWORD