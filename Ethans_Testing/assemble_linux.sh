nasm -f elf64 -F dwarf -g program.asm -o program.o
ld program.o -o program.elf
rm program.o
./program.elf