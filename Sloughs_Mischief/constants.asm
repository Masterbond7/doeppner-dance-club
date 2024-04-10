global MESSAGE
global MSG_LEN

section .data
MESSAGE db "Hello World!", 0x0A
MSG_LEN equ $ - MESSAGE