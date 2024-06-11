include Irvine32.inc
.data

str1 byte "OOOOOOO",0
black_str2 byte "OOOOOOO",0
var1 byte 0
.code
black_color proc
mov dh,20 ; row 10
mov dl,bl
call Gotoxy 
mov eax,0
call settextcolor
mov edx,offset black_str2
call writestring
ret
black_color endp

my_color proc
mov dh,20 ; row 10
mov dl,bl
call Gotoxy 
mov eax,13
call settextcolor
mov edx,offset black_str2
call writestring
ret
my_color endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main PROC
mov bl,0
again:
mov ecx,15
l1:
call my_color
add bl,7
;mov eax,1000*1/2; 0.125 second
;call Delay
input1:
call readchar
cmp al,'s'
jnz l3
push ebx
mov bl,var1
call black_color
add bl,7
mov var1,bl
pop ebx
;mov eax,1000*1/1024; 0.125 second
;call Delay
loop l1
jmp again
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
l3:
cmp al,'a'
jnz l5
;mov eax,1000*1/2; 0.125 second
;call Delay
call black_color
cmp bl,0
jz for_1
sub bl,7
mov var1,bl
sub var1,7
for_1:
;mov eax,1000*1/1024; 0.125 second
;call Delay
call my_color
jmp input1
l5:
 INVOKE ExitProcess, 0 
 main ENDP 
 END main