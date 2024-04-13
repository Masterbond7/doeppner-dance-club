global _start

section .data
    string db "Hello world!", 10
    string_len equ $ - string

section .text

_start:
    mov rax, 1  ; sys_write
    mov rdi, 1  ; stdout

    mov rdx, string_len
    mov rsi, string
    syscall

    mov rax, 60
    mov rdi, 0
    syscall