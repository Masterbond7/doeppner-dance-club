global _start

SYS_EXIT equ 60
SYS_READ equ 0
SYS_WRITE equ 1
STDIN equ 0
STDOUT equ 1

%macro print 1
        mov rax, SYS_WRITE
        mov rdi, STDOUT

        mov rdx, %%message_len
        mov rsi, %%message

        syscall
        jmp %%over

    %%message: db %1 ; define bytes for string
    %%message_len: equ $ - %%message ; get length of string
    %%over:
%endmacro

section .text

_start:
    ; move 14 to lower half of ax
    mov al, 14
    mov ah, 0

    ; set number to divide by
    mov bl, 10

    ; divide by 10, leaving the quotient in al and the remainder in ah
    div bl

    ; acsii to int
    add al, 48
    add ah, 48

    ; push digits to stack
    sub rsp, 1
    mov byte [rsp], ah

    sub rsp, 1
    mov byte [rsp], al

    ; print
    mov rax, SYS_WRITE
    mov rdi, STDOUT

    mov rdx, 2
    mov rsi, rsp

    ; move pointer back
    add rsp, 2
    
    syscall





    
    ;     remainder   quotient
    ; ax: 00000100    00000001

    ; move ax to cx
    ; clear upper so only quotient: 00000000 00000001
    ; print cx

    ; move ax to cx
    ; clear lower and shift right so only remainder: 00000000 00000100
    ; print cx

    ; Exit
    xor edi, edi ; valid exit code
    mov rax, SYS_EXIT
    syscall