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


section .bss
    input_len equ 1 ; 1 byte for user input
    input resb input_len ; buffer for user input

section .text

_start:


    print "Enter number: "

    ;
    ; get input
    ;
    mov rax, SYS_READ
    mov rdi, STDIN
    
    mov rsi, input
    mov rdx, input_len

    syscall


    
    xor r12, r12 ; loop counter

    xor r11, r11 ; total value

    .iterate:

        mov r10, [input]

        sub r10, 48
        add r11, r10


        ; iterating
        add r12, 1d
        cmp r12, 1d
        jne .iterate


    push r11

    ;
    ; int to ascii
    ;

    pop rax
    mov r11, 10d ; set as 10 for division
    xor r12, r12 ; set digit counter to 0

    .stack:
        xor rdx, rdx ; reset remainder register
        div r11 ; divide the quotient by 10

        add rdx, 48 ; convert to ascii
        push rdx ; push ascii value
        sub rdx, 48 ; convert back to ascii

        add r12, 1 ; add to digit counter value

        cmp rax, 0d ; check if quotient is 0
        jne .stack ; if quotient != 0, jump to .stack

    .unstack:
        ; printing
        mov rax, SYS_WRITE
        mov rdi, STDOUT

        mov rdx, 1
        mov rsi, rsp

        syscall

        pop r11 ; remove top value from stack

        sub r12, 1 ; decrease digit counter
        cmp r12, 0d ; check if digit counter is zero
        jne .unstack ; if digit counter != 0, jump to .unstack

    ; Exit
    xor edi, edi ; valid exit code
    mov rax, SYS_EXIT
    syscall