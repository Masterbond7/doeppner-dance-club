nasm -f elf64 -F dwarf -g program.asm -o program.o
ld program.o --omagic -o program
rm program.o