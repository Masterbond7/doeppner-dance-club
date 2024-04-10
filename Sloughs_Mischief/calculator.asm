global _start

extern MESSAGE
extern MSG_LEN

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, MESSAGE
    mov rdx, MSG_LEN
    syscall

    mov rax, 60
    mov rdi, 0
    syscall