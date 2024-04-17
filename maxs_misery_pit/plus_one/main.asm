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
    mov ax, 128d
    mov r11, 10d ; set as 10 for division
    xor r12, r12 ; set digit counter to 0

    .stack:
        xor dx, dx ; reset remainder register
        div r11 ; divide the quotient by 10

        add dx, 48 ; convert to ascii
        push dx ; push ascii value
        sub dx, 48 ; convert back to ascii

        add r12, 1 ; add to digit counter value

        cmp ax, 0d ; check if quotient is 0
        jne .stack ; if quotient = 0, jump to .stack

    .unstack:
        ; printing
        mov rax, SYS_WRITE
        mov rdi, STDOUT

        mov rdx, 1
        mov rsi, rsp

        syscall

        add rsp, 2

        sub r12, 1
        cmp r12, 0d
        jne .unstack

    ; Exit
    xor edi, edi ; valid exit code
    mov rax, SYS_EXIT
    syscall
    


; to print number

; divide by 10

; push remainder to stack
; if quotient < 10, push to stack
; else, divide again

; once done, flip order of things in stack cause
; things will be the wrong away around



; 


; 821