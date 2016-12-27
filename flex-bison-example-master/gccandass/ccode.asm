.386 
.Model Flat,StdCall 
Option CaseMap:None 
include .\masm32\include\msvcrt.inc 
includelib .\masm32\LIB\msvcrt.lib 
include .\masm32\include\masm32.inc 
include .\masm32\include\kernel32.inc 
include .\masm32\macros\macros.asm 
includelib .\masm32\lib\masm32.lib 
includelib .\masm32\lib\kernel32.lib 
.data 
_t0 dd ?
_t1 dd ?
_t2 dd ?
_t3 dd ?
_t4 dd ?
_t5 dd ?
_t6 dd ?
_t7 dd ?
_t8 dd ?
_t9 dd ?
_t10 dd ?
_t11 dd ?
_t12 dd ?
_t13 dd ?
_t14 dd ?
_t15 dd ?
_t16 dd ?
_t17 dd ?
_t18 dd ?
_t19 dd ?
_t20 dd ?
_t21 dd ?
_t22 dd ?
_t23 dd ?
_t24 dd ?
_t25 dd ?
_t26 dd ?
_t27 dd ?
_t28 dd ?
_t29 dd ?
_t30 dd ?
_t31 dd ?
_t32 dd ?
_t33 dd ?
_t34 dd ?
_t35 dd ?
_t36 dd ?
_t37 dd ?
_t38 dd ?
_t39 dd ?
_t40 dd ?
_t41 dd ?
_t42 dd ?
_t43 dd ?
_t44 dd ?
_t45 dd ?
_t46 dd ?
_t47 dd ?
_t48 dd ?
_t49 dd ?
_t50 dd ?
_t51 dd ?
_t52 dd ?
_t53 dd ?
_t54 dd ?
_t55 dd ?
_t56 dd ?
_t57 dd ?
_t58 dd ?
_t59 dd ?
_t60 dd ?
_t61 dd ?
_t62 dd ?
_t63 dd ?
_t64 dd ?
_t65 dd ?
_t66 dd ?
_t67 dd ?
_t68 dd ?
_t69 dd ?
_t70 dd ?
_t71 dd ?
_t72 dd ?
_t73 dd ?
_t74 dd ?
_t75 dd ?
_t76 dd ?
_t77 dd ?
_t78 dd ?
_t79 dd ?
_t80 dd ?
_t81 dd ?
_t82 dd ?
_t83 dd ?
_t84 dd ?
_t85 dd ?
_t86 dd ?
_t87 dd ?
_t88 dd ?
_t89 dd ?
_t90 dd ?
_t91 dd ?
_t92 dd ?
_t93 dd ?
_t94 dd ?
_t95 dd ?
_t96 dd ?
_t97 dd ?
_t98 dd ?
_t99 dd ?
_t100 dd ?
_t101 dd ?
_t102 dd ?
szInput db '%d',0
szoutput db '%d',0ah,0dh
.code
start:
mov eax,0
mov _t7,eax
mov eax,_t7
mov _t6,eax
mov eax,39
mov _t9,eax
mov eax,_t9
mov _t8,eax
mov eax,1
mov _t10,eax
mov eax,2
mov _t11,eax
mov eax,_t10
mov ebx,_t11
add eax,ebx
mov _t12,eax
mov eax,3
mov _t13,eax
mov eax,4
mov _t14,eax
mov eax,_t13
mov ebx,_t14
imul ebx
mov _t15,eax
mov eax,5
mov _t16,eax
mov edx,0
mov eax,_t15
mov ebx,_t16
idiv ebx
mov _t17,eax
mov eax,6
mov _t18,eax
mov edx,0
mov eax,_t17
mov ebx,_t18
idiv ebx
mov _t19,edx
mov eax,_t12
mov ebx,_t19
sub eax,ebx
mov _t20,eax
mov eax,7
mov _t21,eax
mov eax,_t20
mov ebx,_t21
and eax,ebx
mov _t22,eax
mov eax,8
mov _t23,eax
mov eax,9
mov _t24,eax
mov eax,1
mov _t25,eax
mov eax,_t24
mov ecx,_t25
L0:
shr eax,1
loop L0
mov _t26,eax
mov eax,_t23
mov ebx,_t26
xor eax,ebx
mov _t27,eax
mov eax,_t22
mov ebx,_t27
or eax,ebx
mov _t28,eax
invoke crt_printf,addr szoutput,_t28
mov eax,0
mov _t29,eax
mov eax,_t29
mov _t0,eax
L4:
mov eax,10
mov _t30,eax
mov eax,_t0
mov ebx,_t30
cmp eax,ebx
jl L2
mov eax,0
jmp L1
L2:
mov eax,1
L1:
mov _t31,eax
mov eax,_t31
cmp eax,0
je L3
mov eax,_t8
mov _t34,eax
inc eax
mov _t8,eax
mov eax,39
mov _t35,eax
mov eax,_t34
mov ebx,_t35
sub eax,ebx
mov _t36,eax
invoke crt_printf,addr szoutput,_t36
mov eax,1
mov _t32,eax
mov eax,_t0
mov ebx,_t32
add eax,ebx
mov _t33,eax
mov eax,_t33
mov _t0,eax
jmp L4
L3:
invoke crt_scanf,addr szInput,addr _t2
L44:
mov eax,0
mov _t38,eax
mov eax,_t2
mov ebx,_t38
cmp eax,ebx
jge L6
mov eax,0
jmp L5
L6:
mov eax,1
L5:
mov _t39,eax
mov eax,_t39
cmp eax,0
je L43
mov eax,10
mov _t40,eax
mov eax,_t2
mov ebx,_t40
cmp eax,ebx
jge L8
mov eax,0
jmp L7
L8:
mov eax,1
L7:
mov _t41,eax
mov eax,100
mov _t42,eax
mov eax,_t2
mov ebx,_t42
cmp eax,ebx
jl L10
mov eax,0
jmp L9
L10:
mov eax,1
L9:
mov _t43,eax
mov eax,_t41
mov ebx,_t43
and eax,ebx
mov _t44,eax
mov eax,_t44
cmp eax,0
je L24
mov eax,1
mov _t45,eax
invoke crt_printf,addr szoutput,_t45
jmp L23
L24:
mov eax,_t46
mov ebx,0
sub ebx,eax
mov _t47,ebx
mov eax,_t2
mov ebx,_t47
cmp eax,ebx
jle L12
mov eax,0
jmp L11
L12:
mov eax,1
L11:
mov _t48,eax
mov eax,4
mov _t49,eax
mov eax,_t2
mov ebx,_t49
cmp eax,ebx
jg L14
mov eax,0
jmp L13
L14:
mov eax,1
L13:
mov _t50,eax
mov eax,_t48
mov ebx,_t50
or eax,ebx
mov _t51,eax
mov eax,_t51
cmp eax,0
je L22
mov eax,0
mov _t52,eax
mov eax,_t52
mov _t3,eax
jmp L21
L22:
mov eax,1
mov _t53,eax
mov eax,_t53
mov _t3,eax
L20:
mov eax,0
mov _t54,eax
mov eax,_t2
mov ebx,_t54
cmp eax,ebx
jg L16
mov eax,0
jmp L15
L16:
mov eax,1
L15:
mov _t55,eax
mov eax,_t55
cmp eax,0
je L19
mov eax,3
mov _t57,eax
mov eax,_t3
mov ecx,_t57
L17:
shl eax,1
loop L17
mov _t58,eax
mov eax,1
mov _t59,eax
mov eax,_t3
mov ecx,_t59
L18:
shl eax,1
loop L18
mov _t60,eax
mov eax,_t58
mov ebx,_t60
add eax,ebx
mov _t61,eax
mov eax,_t61
mov _t3,eax
mov eax,_t2
mov _t56,eax
dec eax
mov _t2,eax
jmp L20
L19:
L21:
L23:
mov eax,0
mov _t65,eax
mov eax,_t65
mov _t6,eax
mov eax,_t3
mov ebx,0
sub ebx,eax
mov _t66,ebx
mov eax,_t66
mov _t0,eax
L35:
mov eax,_t0
mov ebx,_t3
cmp eax,ebx
jl L26
mov eax,0
jmp L25
L26:
mov eax,1
L25:
mov _t67,eax
mov eax,_t67
cmp eax,0
je L34
mov eax,_t3
mov ebx,0
sub ebx,eax
mov _t70,ebx
mov eax,_t70
mov _t1,eax
L33:
mov eax,_t1
mov ebx,_t3
cmp eax,ebx
jl L28
mov eax,0
jmp L27
L28:
mov eax,1
L27:
mov _t71,eax
mov eax,_t71
cmp eax,0
je L32
mov eax,2
mov _t74,eax
mov eax,_t0
mov ebx,_t74
imul ebx
mov _t75,eax
mov eax,1
mov _t76,eax
mov eax,_t75
mov ebx,_t76
add eax,ebx
mov _t77,eax
mov eax,_t77
mov _t4,eax
mov eax,2
mov _t78,eax
mov eax,_t1
mov ebx,_t78
imul ebx
mov _t79,eax
mov eax,1
mov _t80,eax
mov eax,_t79
mov ebx,_t80
add eax,ebx
mov _t81,eax
mov eax,_t81
mov _t5,eax
mov eax,_t4
mov ebx,_t4
imul ebx
mov _t82,eax
mov eax,_t5
mov ebx,_t5
imul ebx
mov _t83,eax
mov eax,_t82
mov ebx,_t83
add eax,ebx
mov _t84,eax
mov eax,4
mov _t85,eax
mov eax,_t85
mov ebx,_t3
imul ebx
mov _t86,eax
mov eax,_t86
mov ebx,_t3
imul ebx
mov _t87,eax
mov eax,_t84
mov ebx,_t87
cmp eax,ebx
jl L30
mov eax,0
jmp L29
L30:
mov eax,1
L29:
mov _t88,eax
mov eax,_t88
cmp eax,0
je L31
mov eax,1
mov _t89,eax
mov eax,_t6
mov ebx,_t89
add eax,ebx
mov _t90,eax
mov eax,_t90
mov _t6,eax
L31:
mov eax,1
mov _t72,eax
mov eax,_t1
mov ebx,_t72
add eax,ebx
mov _t73,eax
mov eax,_t73
mov _t1,eax
jmp L33
L32:
mov eax,1
mov _t68,eax
mov eax,_t0
mov ebx,_t68
add eax,ebx
mov _t69,eax
mov eax,_t69
mov _t0,eax
jmp L35
L34:
mov eax,1
mov _t94,eax
mov eax,_t3
mov ebx,_t94
cmp eax,ebx
jge L37
mov eax,0
jmp L36
L37:
mov eax,1
L36:
mov _t95,eax
mov eax,_t95
cmp eax,0
je L42
mov eax,2
mov _t96,eax
mov eax,_t3
mov ebx,_t96
cmp eax,ebx
jge L39
mov eax,0
jmp L38
L39:
mov eax,1
L38:
mov _t97,eax
mov eax,_t97
cmp eax,0
je L41
mov edx,0
mov eax,_t6
mov ebx,_t3
idiv ebx
mov _t98,eax
invoke crt_printf,addr szoutput,_t98
jmp L40
L41:
mov eax,3
mov _t99,eax
invoke crt_printf,addr szoutput,_t99
L40:
L42:
invoke crt_scanf,addr szInput,addr _t2
jmp L44
L43:
exit
end start
