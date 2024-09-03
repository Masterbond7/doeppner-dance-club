nasm -f elf64 -F dwarf -g calculator.asm -o calculator.o
ld calculator.o -o calculator.elf
rm calculator.o