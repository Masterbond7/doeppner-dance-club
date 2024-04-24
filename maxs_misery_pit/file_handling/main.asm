.stack 100h
.data

text db "Adam$"
filename db "name.txt",0
handler dw ?

.code          
;INITIALIZE DATA SEGMENT.
  mov  ax,@data
  mov  ds,ax

;CREATE FILE.
  mov  ah, 3ch
  mov  cx, 0
  mov  dx, offset filename
  int  21h  

;PRESERVE FILE HANDLER RETURNED.
  mov  handler, ax

;WRITE STRING.
  mov  ah, 40h
  mov  bx, handler
  mov  cx, 5  ;STRING LENGTH.
  mov  dx, offset text
  int  21h

;CLOSE FILE (OR DATA WILL BE LOST).
  mov  ah, 3eh
  mov  bx, handler
  int  21h      

;FINISH THE PROGRAM.
  mov  ax,4c00h
  int  21h           
