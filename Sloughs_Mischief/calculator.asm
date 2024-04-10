global _start

section .data
    tbuffer_len equ 21 ; # chars for text buffer

section .bss
    tbuffer resb tbuffer_len ; Buffer for text input
    number resb 8

section .text
; Main function
_start:
    ; Get input from user
    push tbuffer
    push tbuffer_len
    call get_input

    ; Convert input to a number
    push number
    push tbuffer
    call conv_a2int

    mov  rax, [number]
    imul rax, 2
    add  rax, 0x30
    mov  [number], rax

    ; Print stuff
    push number
    push 1d
    call print

    ; Exit
    mov rax, 60
    mov rdi, 0
    syscall

; Convert ASCII to int (*number, *char buffer)
conv_a2int:
    ; Pop return address and store in r15
    pop r15

    ; Pop pointers
    pop r9 ; *char buffer -> r9
    pop r8 ;      *number -> r8

    ; Zero byte counter & RAX (result)
    xor r10, r10
    xor rax, rax

    .recursive:
        ; Get a charachter
        movzx rcx, BYTE [r9+r10] ; Move char into RCX
        add r10, 1d              ; Move to next char

        ; Exit if charachter is not a number
        cmp rcx, 0x30 ; / If char < "0"
        jb .exit      ; \ Exit function
        cmp rcx, 0x39 ; / If char > "9"
        jg .exit      ; \ Exit function
        
        ; Convert char to dec
        sub rcx, 0x30  ; Char - "0"
        imul rax, 10d  ; Multiply current result by 10
        add rax, rcx   ; Add char to end of current result
        jmp .recursive ; Loop until inval char

    .exit:
        ; Move result into *num
        mov [r8], rax

        ; Return to program
        push r15 ; Put return address back
        ret      ; Return


; Get input from stdin (*char buffer, # chars)
get_input:
    ; Pop return address and store in r15
    pop r15

    ; Move to registers and read
    mov rax, 0 ; sys_read
    mov rdi, 0 ; stdin
    pop rdx    ; # of chars
    pop rsi    ; Pointer to buffer
    syscall    ; Call kernel

    ; Return to program
    push r15 ; Put return address back
    ret      ; Return


; Print to stdout (*message, message length)
print:
    ; Pop return address and store in r15
    pop r15

    ; Move to registers and print
    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    pop rdx    ; Length of the message
    pop rsi    ; Pointer to buffer
    syscall    ; Call kernel

    ; Return to program
    push r15 ; Put return address back
    ret      ; Return
