include Irvine32.inc
.386
.data
str1 byte "OOOOOOO",0
black_str2 byte "OOOOOOO",0

var1 byte ?
save_bl byte ?

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
sub dl,5
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
cmp bl,0
jnz rev_move


far_move:
l1:
mov dh,20                 ; row 10
mov dl,bl
call Gotoxy 


mov eax,13
call settextcolor
mov edx,offset str1
call writestring
add bl,5

mov save_bl,bl
 mov bl,var1

mov eax,1000*1/2; 0.125 second
call Delay

call readchar
cmp al,'s'
jnz l3

sss:
 call black_color
 add bl,5
mov var1,bl
mov bl,save_bl

mov eax,1000*1/1024; 0.125 second
call Delay
loop l1
jmp again


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

l3:

rev_move:
comment $

l2:
mov dh,20 ; row 10
mov dl,bl
call Gotoxy 

mov eax,14
call settextcolor
mov edx,offset str1
call writestring
sub bl,5

mov save_bl,bl
 mov bl,var1

mov eax,1000*1/2; second
call Delay
 call black_color
 sub bl,5
mov var1,bl
mov bl,save_bl

mov eax,1000*1/1024; second
call Delay
loop l2
jmp again
$

 INVOKE ExitProcess, 0 
 main ENDP 

 
 END main

 