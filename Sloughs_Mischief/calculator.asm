global _start

section .bss


section .text
_start:
    mov bx, 5d
    mov ax, 4d
    neg ax
    add bx, ax

    add bx, 0x30
    push bx
    push 1d

    ; Print stuff
    call print

    mov rax, 60
    mov rdi, 0
    syscall

; Print to stdout (message, message length)
print:
    ; Pop return address and store in r15
    pop r15

    ; Move to registers and print
    mov rax, 1   ; sys_write
    mov rdi, 1   ; stdout
    pop rdx      ; Length of the message
    mov rsi, rsp ; Pointer to the message
    syscall      ; Call kernel

    ; Move stack pointer back past the message
    add rsp, rdx

    ; Return to program
    push r15 ; Put return address back
    ret      ; Return
