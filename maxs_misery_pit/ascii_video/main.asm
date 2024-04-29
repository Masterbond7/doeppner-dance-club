section .data
    filename db 'ascii_frames/hehehehaw.asv', 0
    buffer   db 1   ; Buffer to store read data
    buflen   equ $ - buffer

    ;new_line db 10

    overwrite db 0x1b, "[H"
    overwrite_len equ $ - overwrite

    erase db 0x1b, "[2J"
    erase_len equ $ - erase

section .bss
    fd       resq 1     ; File descriptor

section .text
    global _start

_start:
    ; Open the file
    mov rdi, filename
    mov rsi, 0       ; Flags: O_RDONLY (read-only)
    mov rax, 2       ; syscall number for sys_open
    syscall
    mov qword [fd], rax   ; Save file descriptor

    ; Check for errors in opening the file
    cmp rax, 0
    jl error_exit

    mov rax, 1
    mov rdi, 1
    mov rdx, overwrite_len
    mov rsi, overwrite
    syscall

read_loop:
    ; Read from the file
    mov rdi, qword [fd]   ; File descriptor
    mov rsi, buffer       ; Buffer to read into
    mov rdx, buflen       ; Number of bytes to read
    mov rax, 0           ; syscall number for sys_read
    syscall

    ; Check for errors in reading from the file
    cmp rax, 0
    jl error_exit

    ; Check if EOF reached
    test rax, rax
    jz close_file

    ;movzx r10, byte[buffer]
    ;cmp r10, 9
    ;je clear

    ; Print the read data (you can replace this with your own processing)
    mov rdi, 1     ; File descriptor for stdout
    mov rax, 1     ; syscall number for sys_write
    mov rdx, rax   ; Length
    syscall

    ; Continue loops
    jmp read_loop

    ;clear:
    ;    mov rax, 1
    ;    mov rdi, 1
    ;    mov rdx, overwrite_len
    ;    mov rsi, overwrite
    ;    syscall
    ;    jmp read_loop

close_file:
    ; Close the file
    mov rdi, qword [fd]   ; File descriptor
    mov rax, 3            ; syscall number for sys_close
    syscall

    ; Clear the screen
    mov rax, 1
    mov rdi, 1
    mov rdx, erase_len
    mov rsi, erase
    syscall

    ; Exit the program
    mov rax, 60     ; syscall number for sys_exit
    xor rdi, rdi    ; Exit code 0
    syscall

error_exit:
    ; Handle errors (print error message, cleanup, and exit)
    ; Example: print error message and exit with error code
    mov rax, 60     ; syscall number for sys_exit
    mov rdi, -1     ; Error exit code
    syscall
