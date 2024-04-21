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
    input_len equ 8 ; 2 bytes for user input
    input resb input_len ; buffer for user input

section .text

_start:
    print "Calgulagor!!!"
    print 10
    print "Enter equation:  "
    


    ;
    ; Get input
    ;
    mov rax, SYS_READ
    mov rdi, STDIN
    
    mov rsi, input
    mov rdx, input_len

    syscall


    ;
    ; Ascii to int
    ;
    mov r9, input_len ; loop counter
    mov r10, 1 ; power of 10

    xor r11, r11 ; current number value
    xor r12, r12 ; total value

    mov r13, 1 ; queued operation
    ; 1 = add
    ; 3 = mult


    .recursive:
        sub r9, 1d ; decrease loop counter

        movzx rax, byte[input+r9] ; access specfied byte of the input buffer

        ; if not a digit, jump to operator
        cmp rax, 48d ; check if < '0'
        jb .operator ; if so, jump to .operator

        cmp rax, 57d ; check if > '0'
        jg .operator ; if so, jump to .operator


        sub rax, 48 ; convert to int

        imul rax, r10 ; multiply by the current power of 10
        imul r10, 10 ; increase the power of 10

        add r11, rax ; add the value of the digit to the total value

        .iterate:
            cmp r9, 0d
            jne .recursive

    cmp r13, 1d ; check if add is queued
    jne .adda ; if not equall, skip
        add r12, r11
        xor r13, r13
        mov r10, 1
    .adda:

    push r12



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

    print 10

    ;
    ; Exit
    ;
    xor edi, edi ; valid exit code
    mov rax, SYS_EXIT
    syscall





    ;
    ; meow
    ;
    .operator:

        cmp rax, 43d
        jne .iterate

        cmp r13, 1d ; check if add is queued
        jne .add ; if not equall, skip
            add r12, r11
            xor r13, r13
            mov r10, 1
        .add:


        cmp rax, 43d ; check if character is '+'
        jne .q_add ; if not equall, skip
            mov r13, 1d
        .q_add:

        cmp rax, 42d ; check if character is '*'
        jne .q_mul ; if not equall, skip
            mov r13, 3d
        .q_mul:
        

        jmp .iterate
