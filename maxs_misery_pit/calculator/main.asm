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
    input_len equ 8 ; 8 bytes for user input
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

    ; Get all numbers and store them
    mov r9, input_len ; loop counter
    
    .numbers_start:
        mov r10, 1 ; power
        xor r11, r11 ; current number

    .numbers_loop:
        sub r9, 1d ; decrease loop counter
        movzx rax, byte[input+r9] ; access specfied byte of the input buffer

        ; if not a digit, jump to operator
        cmp rax, 48d ; check if < '0'
        jb .next_num ; if so, jump to .next_num

        cmp rax, 57d ; check if > '0'
        jg .next_num ; if so, jump to .next_num

        ; else
        sub rax, 48 ; convert to int

        imul rax, r10 ; multiply by the current power of 10
        imul r10, 10 ; increase the power of 10

        add r11, rax ; add the value of the digit to the total value

        cmp rax, 0d
        jne .numbers_loop
    
    .next_num:
        push r11

        cmp rax, 0d
        jne .numbers_start



    mov r9, 8
    xor r10, r10

    .add_all:
        pop r11
        add r10, r11
        
        cmp r9, 0d
        sub r9, 1
        jne .add_all

    push r10






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