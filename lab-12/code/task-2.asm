INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
_one DWORD 1
_two REAL4 2.0

.code
main PROC  ;... add proc definition
FINIT
FILD _one ; _one should be defined as dword 1
FILD _two ; also define and load real4 _two with fld

FCOM  ; compares _two, _one...... cf FCOMI
FNSTSW AX ; no wait for exceptions
mShow AX, B
SAHF
JNBE label_success
JMP label_failure
label_success: ; print a happy message using the "mWrite" macro
 mWrite <10,13, "two <= one", 10,13>
 exit
label_failure:
	mWrite <10,13, "one <= two", 10,13>; print a less happy message with mWrite, like "two <= one"
	exit
main ENDP; close proc and program
END main
