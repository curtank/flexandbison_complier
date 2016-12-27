.386
.Model Flat,StdCall
Option CaseMap:None

include .\include\msvcrt.inc
includelib .\LIB\msvcrt.lib

.data
       szI dd ?
       szN dd ?
       szF dd ?
       szInput db '%d',0
              
.code
start:
       
        invoke  crt_scanf,addr szInput,addr szN  
        mov szI,2
        mov szF,1 
        
        
AGAIN : 
        mov eax,szI
        mov ebx,szN
        cmp ebx,eax
        JNB CACL
        JMP OUTPUT

        
CACL :  
        
        ;invoke  crt_printf, addr szInput,szF
        ;invoke  crt_printf, addr szInput,szI
                
        MOV EAX,szF
        MOV EBX,szI
        MUL EBX
        MOV szF,EAX
        MOV EAX,szI
        INC EAX
        MOV szI,EAX
        JMP AGAIN
        

OUTPUT: 
        invoke  crt_printf,addr szInput,szF 
                
        invoke  crt_scanf,addr szInput,addr szN    
    ret
end start