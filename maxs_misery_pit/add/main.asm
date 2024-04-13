global _start

section .data
    prompt db "Num 1: "
    prompt_len equ $ - prompt

section .text

_start:
    