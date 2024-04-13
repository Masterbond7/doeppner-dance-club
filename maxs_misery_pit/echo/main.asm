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
    input_len equ 8 ; 1 byte for user input
    input resb input_len ; buffer for user input


section .text

_start:
    print "Speak: "
    call get_input

    print "(echo) "
    call print_input
    print 10

    ; Exit
    xor edi, edi ; valid exit code
    mov rax, SYS_EXIT
    syscall


get_input:
    pop r15

    ; get input
    mov rax, SYS_READ
    mov rdi, STDIN
    
    mov rsi, input
    mov rdx, input_len

    syscall

    push rax

    push r15
    ret


print_input:
    pop r15

    mov rax, SYS_WRITE
    mov rdi, STDOUT

    pop rdx
    mov rsi, input

    syscall

    push r15
    ret

