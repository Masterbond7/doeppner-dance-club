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

    newLine db 10
    newLine_len equ $-newLine

section .bss
    input_len equ 19
    input resb input_len

section .text
    global _start

printNum:
    pop r12             ; Get rid of return pointer

    pop rax             ; Get counter
    push rax            ; Chuck it back on the stack, leaving it in rax

    add rax, 48         ; Convert to ascii
    mov [input], rax    ; Store the ascii number

    ; Print current number
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, input
    mov rdx, input_len
    syscall

    ; Print newline
    mov rsi, newLine
    mov rdx, newLine_len
    syscall

    push r12            ; Push the pointer back
    ret


getInput:
    ;pop r12
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
    mov rbx, 0          ; rbx - Index of current byte
.CheckByte:
    mov rcx, input
    add rcx, rbx        ; rcx - Memory address of next byte

    mov rdx, (rcx)      ; rdx - Number at memory address
    cmp rdx, 0
    je .CountComplete   ; If next byte is empty, string is ended

    sub rdx, 48         ; Char to number
    
    mov r8, 10
    mul r8              ; Multiply current num by 10
    add rbx, rdx        ; Add last digit to current num

    jmp .CheckByte
.CountComplete:

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, input
    add rsi, 2
    mov rdx, 1
    syscall

    mov rax, (rsi)
    cmp rax, 0
    je .CheckByte

    ; Convert char to number
    ;mov rax, [input]
    ;sub rax, 48
    ;push rax

    ;push r12
    ret

exit:
    xor edi, edi
    mov rax, SYS_EXIT
    syscall

loop:
    pop r11        ; Get rid of function pointer

    call printNum

    pop rax         ; Get current counter value
    sub rax, 1      ; Decrease Counter
    push rax        ; Store new counter value

    push r11         ; Put the function pointer back

    cmp rax, 0      ; See if counter is at zero
    jg loop         ; If it is greater, keep looping

    call exit
    ret             ; Otherwise end program


_start:
    call getInput
    call exit
    ;call loop