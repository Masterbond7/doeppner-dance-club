section .data ; me when me when constants
    message db "Hello world!", 0xa, 0x7 ; dont forget to like subscribe and hit that bell  
    message_len equ $ - message ; so thats how many letters that sentence is

section .text ; code goes here

global _start  ; hey computer wake up. It's time to program

; this one please
_start:
    ; haiiiiii :3
    mov rax, 1 ; computer to printer pipeline
    mov rdi, 1 ; yes I want you to output in a standard fashion
    mov rsi, message ; this sentence please mr kernel
    mov rdx, message_len ; how many letters is it again
    syscall ; your turn Mr kernel

    ; bye bye
    mov rax, 60 ; kapiti youth services
    mov rdi, 0 ; error code, not often
    syscall ; thank you for your work today mr Kernel
