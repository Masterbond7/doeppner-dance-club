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
    input_len equ 2 ; 2 bytes for user input
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

    ;
    ; ascii to int
    ;
    xor r12, input_len ; loop counter
    mov r13, 1 ; power

    xor r11, r11 ; total value

    .iterate:
        sub r12, 1d ; decrease loop counter

        movzx rax, byte[input+r12] ; access specfied byte of the input buffer

        sub rax, 48 ; convert to int
        imul rax, r13 ; multiply by the current power of 10
        
        imul r13, 10 ; increase the power of 10

        add r11, rax ; add the value of the digit to the total value


        ; iterating
        cmp r12, 0d
        jne .iterate

    
    add r11, 1 ; add 1 to input number to prove it converts properly

    push r11 ; push total int value of input to stack


    print "Your number plus 1 equals: "

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

    ; Exit
    xor edi, edi ; valid exit code
    mov rax, SYS_EXIT
    syscall