all:  ccode.exe
	wine ./masm32/bin/ml.exe /c /coff ccode.asm
	wine ./masm32/bin/link.exe /SUBSYSTEM:CONSOLE /OPT:NOREF ccode.obj
	wine ccode.exe
clean:
	rm ccode.exe ccode.obj