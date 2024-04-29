global _start

;ESC equ 0x1b

section .data
    stringa db "hello world!", 10
    stringa_len equ $ - stringa

    stringb db "HELLO WORLD!", 10
    stringb_len equ $ - stringb

    

    overwrite db 0x1b, "[1;1H"
    overwrite_len equ $ - overwrite

section .text

_start:
    mov rax, 1  ; sys_write
    mov rdi, 1  ; stdout

    mov rdx, overwrite_len
    mov rsi, overwrite
    syscall

    mov rax, 1  ; sys_write
    mov rdi, 1  ; stdout

    mov rdx, stringa_len
    mov rsi, stringa
    syscall

    mov rax, 1  ; sys_write
    mov rdi, 1  ; stdout

    mov rdx, overwrite_len
    mov rsi, overwrite
    syscall

    mov rax, 1  ; sys_write
    mov rdi, 1  ; stdout

    mov rdx, stringb_len
    mov rsi, stringb
    syscall

    mov rax, 60
    mov rdi, 0
    syscall