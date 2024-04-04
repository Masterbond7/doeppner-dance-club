global _start
global msg
global msglen

%define LINUX 1

; Linux specific code
%ifdef LINUX
    section .text
    ; Print text to stdout (message, message length)
    print:
        pop rbx
        mov rax, 1
        mov rdi, 1
        pop rsi
        pop rdx
        syscall
        push rbx
        ret

    ; Exit with code (exit code)
    exit:
        pop rbx
        mov rax, 60
        pop rdi
        syscall


; Windows specific code
%elifdef WINDOWS
%endif


; Defining constants
section .data
    msg: db "Hello world!", 0x7, 0xa
    msglen: equ $ - msg

section .text
_start:
    push msglen
    push msg
    call print
    pop rbx

    push 0x00  ; Exit code 0
    call exit ; Call exit function