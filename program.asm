global _start
global msg
global msglen

section .text
; Print text to stdout (message, message length)
print:
    pop rbx
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    add rsp, 8
    pop rdx
    syscall
    push rbx
    ret

; Exit with code (exit code)
exit:
    pop rbx
    mov rax, 60
    pop rdi
    syscall

_start:
    ;push msglen
    ;push msg
    ;call print
    ;pop rbx

    mov rbp, 5
    push rbp
    call loop

    push 0x00  ; Exit code 0
    call exit ; Call exit function

loop:
    ; Get stuff from stack
    pop r12
    pop rbp

    ; Print message to stack
    dec rbp
    mov r13, 0x30
    add r13, rbp
    push 0x1
    push 0x0A
    push r13
    call print
    add rsp, 8
    
    ; Loop again if rbp>0
    push rbp
    push r12
    cmp rbp, 0
    jg loop

    ; Otherwise return
    ret