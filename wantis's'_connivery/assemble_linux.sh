nasm -f elf64 -F dwarf -g stack_based_tomfoolery.asm -o stack_based_tomfoolery.o
ld stack_based_tomfoolery.o -o stack_based_tomfoolery.elf
rm stack_based_tomfoolery.o