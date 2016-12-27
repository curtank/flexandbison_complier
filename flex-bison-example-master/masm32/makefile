all:link
	wine test.exe 

link:asm
	wine ./bin/link.exe  /SUBSYSTEM:CONSOLE /OPT:NOREF test.obj

asm:
	wine ./bin/ml.exe /c /coff test.asm