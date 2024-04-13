bits 64

; 'Global variables' to make things clearer
SYS_EXIT equ 60
SYS_READ equ 0
SYS_WRITE equ 1
STDIN equ 0
STDOUT equ 1

section .data
    prompt db "Enter your number:"
    prompt_len equ $-prompt

    newLine db ', '
    newLine_len equ $-newLine

section .bss
    input_len equ 19
    input resb input_len
    digit_len equ 1
    digit resb digit_len
    number resq 1

section .text
    global _start

printNewline:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newLine
    mov rdx, newLine_len
    syscall
    ret

printNum:
    mov rax, [number]; Get number to print

    mov r12, 0      ; Digit counter
    mov r10, 10     ; Divisor

.divideNum:
    xor rdx, rdx    ; Clear rdx
    add r12, 1
    div r10
    add rdx, 48     ; Char to number
    push rdx        ; Store number

    cmp rax, 0      ; Check if more digits need to be printed
    jne .divideNum

.printDigit:
    sub r12, 1
    pop rax
    mov [digit], al

    ; Output digit
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, digit
    mov rdx, digit_len
    syscall

    cmp r12, 0
    jg .printDigit

    call printNewline
    ret


getInput:
    ; Output prompt
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; Get input
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input
    mov rdx, input_len
    syscall

    mov rax, 0          ; rax - Total number
    mov r8, 0           ; rbx - Index of current byte
.CheckByte:
    mov r9, input
    add r9, r8          ; r9 - Memory address of next byte

    mov r10b, [r9]      ; rdx - Number at memory address
    cmp r10, 10
    je .CountComplete   ; If next byte is empty, string is ended

    sub r10, 48         ; Char to number
    
    mov r11, 10
    mul r11             ; Multiply current num by 10
    add rax, r10        ; Add last digit to current num

    add r8, 1
    jmp .CheckByte
.CountComplete:
    mov [number], rax   ; Store current num
    ret

exit:
    xor edi, edi
    mov rax, SYS_EXIT
    syscall

loop:
    call printNum

    mov rax, [number]   ; Get current counter value
    sub rax, 1          ; Decrease Counter
    mov [number], rax   ; Store new counter value

    cmp rax, 0      ; See if counter is at zero
    jg loop         ; If it is greater, keep looping

    call exit
    ret             ; Otherwise end program


_start:
    call getInput
    call loop
    call exit
    ;call loop