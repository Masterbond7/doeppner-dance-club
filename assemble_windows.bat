nasm -fwin64 -g program.asm -o program.obj
link /MACHINE:X64 /SUBSYSTEM:CONSOLE /OUT:program.exe /NODEFAULTLIB /ENTRY:_start kernel32.lib program.obj