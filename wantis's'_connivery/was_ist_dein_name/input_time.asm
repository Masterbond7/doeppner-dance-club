section .data ; me when me when constants
    message1 db "Haiiiiiiiiii :3, what is your name? ", 0x7
    message1_len equ $ - message1
    message2 db "henlo "
    message2_len equ $ - message2

section .bss ; the place where variable variables vary
    name resb 32 ; i reserved 32 because Joe's full name is 17 bits not 16 :3

section .text ; code goes here
    global _start  ; hey computer wake up. It's time to program

; this one please
_start:
    ; kinda reminds me of python classes honestly
    call _printmessage1
    call _getname
    call _printmessage2
    call _printname
    call _conclude

_printmessage1:
    ; say haiii :3
    mov rax, 1 ; print
    mov rdi, 1 ; stdout
    mov rsi, message1
    mov rdx, message1_len
    syscall
    ret

_getname:
    ; was yo name bruv
    mov rax, 0 ; take
    mov rdi, 0 ; stdinp
    mov rsi, name
    mov rdx, 32
    syscall
    ret

_printmessage2:
    ; definetly saying both on the same line ;3c
    mov rax, 1 ; print
    mov rdi, 1  ; stdout
    mov rsi, message2
    mov rdx, message2_len
    syscall
    ret

_printname:
    ; Im not very good with names 3:
    mov rax, 1 ; print
    mov rdi, 1  ; stdout
    mov rsi, name
    mov rdx, 32
    syscall
    ret

_conclude:
    ; bye bye
    mov rax, 60 ; kapiti youth services
    mov rdi, 0 ; error code, not often
    syscall ; thank you for your work today mr Kernel
