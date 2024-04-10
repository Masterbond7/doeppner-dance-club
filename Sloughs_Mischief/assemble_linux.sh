nasm -f elf64 -F dwarf -g constants.asm -o constants.o
nasm -f elf64 -F dwarf -g calculator.asm -o calculator.o
ld calculator.o constants.o -o calculator.elf
rm calculator.o constants.o