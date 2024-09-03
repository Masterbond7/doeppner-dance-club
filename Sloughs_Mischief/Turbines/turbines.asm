global _start

; Data
section .data
    text db "Hello World!", 0x0A
    text_len equ $ - text

section .text
; Main function
_start:
    ; Print text
    mov rax, 1
    mov rdi, 1
    mov rdx, text_len
    mov rsi, text
    syscall

    ; Exit with status 0
    mov rax, 60
    mov rdi, 0
    syscall
