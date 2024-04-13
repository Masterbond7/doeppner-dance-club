global _start

%macro print 1
        mov rax, 1 ; sys_write
        mov rdi, 1 ; stdout

        mov rdx, %%message_len
        mov rsi, %%message

        syscall
        jmp %%over

    %%message: db %1 ; define bytes for string
    %%message_len: equ $ - %%message ; get length of string
    %%over:
%endmacro

section .text

_start:
    print "hello"

    mov rax, 60 ; exit command
    mov rdi, 0 ; valid exit code
    syscall