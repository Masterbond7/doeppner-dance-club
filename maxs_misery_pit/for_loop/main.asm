global _start

section .data
    string db "boobs", 10
    string_len equ $ - string

    loop_len equ 3

section .text

_start:

    mov rbx, loop_len

    .recursive:
        mov rax, 1  ; sys_write
        mov rdi, 1  ; stdout

        mov rdx, string_len
        mov rsi, string
        syscall

        sub rbx, 1

        cmp rbx, 0
        jg .recursive

        mov rax, 60
        mov rdi, 0
        syscall

        