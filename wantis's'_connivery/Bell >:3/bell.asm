section .data ; me when me when constants
    message db 0x7 ; ding  
    message_len equ $ - message ; how many characters to make a bell sound

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

    ; some may consider this a touch devious
    jmp _start ; in the famous words of gustavo fring "oaahhhhhhhhhhhhhhh"

    ; Im keeping this here because its funny >:3
    mov rax, 60 ; kapiti youth services
    mov rdi, 0 ; error code, not often
    syscall ; thank you for your work today mr Kernel
