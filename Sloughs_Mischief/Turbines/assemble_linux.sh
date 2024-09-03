nasm -f elf64 -F dwarf -g turbines.asm -o turbines.o
ld turbines.o -o turbines.elf
rm turbines.o