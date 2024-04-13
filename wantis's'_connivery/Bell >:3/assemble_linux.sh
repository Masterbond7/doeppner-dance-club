nasm -f elf64 -F dwarf -g bell.asm -o bell.o
ld bell.o -o bell.elf
rm bell.o