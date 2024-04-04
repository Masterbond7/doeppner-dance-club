global _start
global msg
global msglen

%define LINUX 1

; Linux specific code
%ifdef LINUX
    ; Macro to print to terminal
    %macro macro_print 2 
        mov rax, 1
        mov rdi, 1
        mov rsi, %1
        mov rdx, %2
        syscall
   %endmacro

    ; Exit with code
    %macro macro_exit 1
        mov rax, 60
        mov rdi, %1
        syscall
    %endmacro


; Windows specific code
%elifdef WINDOWS
%endif


; Defining constants
section .data
    msg: db "Hello world!", 0x7, 0xa
    msglen: equ $ - msg

section .text
_start:
    macro_print msg, msglen

    macro_exit 0