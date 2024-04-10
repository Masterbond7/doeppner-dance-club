global _start

section .data
    tbuffer_len equ 21 ; # chars for text buffer

section .bss
    tbuffer resb tbuffer_len ; Buffer for text input

section .text
; Main function
_start:
    ; Get input from user
    push tbuffer
    push tbuffer_len
    call get_input

    ; Print stuff
    push tbuffer
    push tbuffer_len
    call print

    ; Exit
    mov rax, 60
    mov rdi, 0
    syscall


; Get input from stdin (*char buffer, # chars)
get_input:
    ; Pop return address and store in r15
    pop r15

    ; Move to registers and read
    mov rax, 0 ; sys_read
    mov rdi, 0 ; stdin
    pop rdx    ; # of chars
    pop rsi    ; Pointer to buffer
    syscall    ; Call kernel

    ; Return to program
    push r15 ; Put return address back
    ret      ; Return


; Print to stdout (*message, message length)
print:
    ; Pop return address and store in r15
    pop r15

    ; Move to registers and print
    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    pop rdx    ; Length of the message
    pop rsi    ; Pointer to buffer
    syscall    ; Call kernel

    ; Return to program
    push r15 ; Put return address back
    ret      ; Return
