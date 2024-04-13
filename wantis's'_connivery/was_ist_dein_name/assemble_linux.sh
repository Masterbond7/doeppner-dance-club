nasm -f elf64 -F dwarf -g input_time.asm -o input_time.o
ld input_time.o -o input_time.elf
rm input_time.o