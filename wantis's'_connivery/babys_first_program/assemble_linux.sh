nasm -f elf64 -F dwarf -g Haii.asm -o Haii.o
ld Haii.o -o Haii.elf
rm Haii.o