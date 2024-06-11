INCLUDE irvine32.inc

.data
ww db "\\      /\      // ||===== ||       ====   ====    |\      /| ||=====     ========  ====         ====       /\     |\      /| ||=====      ",0ah,0dh
    db" \\    //\\    //  ||      ||      =      =    =   ||\    //| ||             ||    =    =       =     =    //\\    ||\    //| ||           ",0ah,0dh
    db"  \\  //  \\  //   ||===== ||     =      =      =  ||\\  //|| ||=====        ||   =      =     =   =      //  \\   ||\\  //|| ||=====      ",0ah,0dh
    db"   \\//    \\//    ||      ||      =      =    =   || \\// || ||             ||    =    =       =   ===  //====\\  || \\// || ||           ",0ah,0dh
    db"    \/      \/     ||===== ||=====  ====   ====    ||  \/  || ||=====        ||     ====         ====   //      \\ ||  \/  || ||=====      ",0 
rbard db "=",0
cbard db "|",0
ball db "*",0
bricks db " ",0
ballsp dword 50
maxr db ?
maxc db ?
rmaxr db ?
rmaxc db ?
minr db 4
minc db 4
x db 4
y db 0
col word 01h
chk db 0
wait1 dword 5
radd db 1
cadd db 1
missv db ?
mistake db "mistake",0
vv db 1
ppadx byte ?
ppady byte ?
cpadx byte 36
cpady byte 57
npadx byte ?
npady byte ?
nx byte 2
ny byte 2
gor byte "GAME OVER",0
score db 0
str11 db "WELCOME TO DX BALL GAME",0
str22 db "Enter your Name : ",0
pdiffq db "ENTER DIFFICULTY LEVEL ",0
p1 db  "B.Begginner",0
p2 db    "M.Medium",0
p3 db     "H.Hard",0
p4 db "your score ",0
pname db 20 dup  (?)
scorestr db "score :",0
str1 byte "OOOOOOO",0
black_str2 byte "OOOOOOO",0
var1 byte 0
chk1 db 0
.code

welcome proc
pushad
mov dh,15
mov dl,57
call gotoxy
mov eax,00bh
call settextcolor
mov edx, offset str11
call writestring
call crlf
mov dh,17
mov dl,57
call gotoxy

mov edx,offset str22
call writestring
mov eax,00ch
call settextcolor
mov ecx,20
mov eax,0
mov edx,offset pname
call readstring

mov dh,19
mov dl,57
call gotoxy
mov eax,009h
call settextcolor
mov edx,offset pdiffq
call writestring
call crlf
mov dh,20
mov dl,57
call gotoxy


mov edx,offset p1
call writestring


call crlf
mov dh,21
mov dl,57
call gotoxy
mov edx,offset p2
call writestring

call crlf
mov dh,22
mov dl,57
call gotoxy
mov edx,offset p3
call writestring
call crlf
mov dh,23
mov dl,57
call gotoxy
call readchar
cmp al,'b'
je beg
cmp al,'m'
je med
cmp al,'h'
je hard

beg:
mov eax,80
mov ballsp,eax
jmp eee
med:
mov eax,60
mov ballsp,eax
jmp eee
hard:
mov eax,40
mov ballsp,eax
jmp eee

eee:
mov eax,00eh
call settextcolor
popad
ret
welcome endp




input proc
pushad
call readkey
jz ex
cmp al,'s'
jne l3
mov bl,cpady
mov ppady,bl
cmp bl,107
jae ex
call black_color
add bl,7
mov cpady,bl
call my_color

jmp ex
;mov eax,1000*1/1024; 0.125 second
;call Delay

l3:
cmp al,'a'
jne ex
;mov eax,1000*1/2; 0.125 second
;call Delay
mov bl,cpady
mov ppady,bl
cmp bl,10
jbe ex
call black_color
sub bl,7
mov cpady,bl
;mov eax,1000*1/1024; 0.125 second
;call Delay
call my_color


ex:

popad
ret
input endp


scoreup proc
pushad
mov eax,0
mov al,score
add al,1
mov score,al
mov dh,42
mov dl,72
call gotoxy
call writedec
popad
ret
scoreup endp
;                                 gameover
gameoverr proc
pushad
mov edx,0
mov dh,18
mov dl,57
call gotoxy
mov eax,003h
call settextcolor
mov edx,offset gor
call writestring
mov dh,19
mov dl,57
call gotoxy
mov edx,offset pname
call writestring
mov dh,20
mov dl,57
call gotoxy
mov edx,offset p4
call writestring
mov dh,20
mov dl,68
call gotoxy
mov eax,0
mov al,score
call writedec
popad
ret
gameoverr endp



mov dh,42
mov dl,0
;mov eax,5000
;call delay
call gotoxy




black_color proc
pushad
mov dh,cpadx 
mov dl,ppady
call Gotoxy 
mov eax,0
call settextcolor
mov edx,offset black_str2
call writestring
popad
ret
black_color endp

my_color proc
pushad
mov dh,cpadx ; row 10
mov dl,cpady
call Gotoxy 
mov eax,13
call settextcolor
mov edx,offset black_str2
call writestring
popad
ret
my_color endp

main proc
pushad
mov eax,00ah
call settextcolor
mov edx,offset ww
call writestring

call welcome
call clrscr

mov edx,0
mov dh,42
mov dl,64
call gotoxy
mov edx,offset scorestr
call writestring
mov eax,0
mov dl,68
call gotoxy
call writedec
;call getmaxxy
mov dl,128
mov al,41
mov rmaxr,al
mov rmaxc,dl
push eax

mov ah,rmaxr
mov al,rmaxc

sub ah,minr
sub al,minc

mov maxr,ah
mov maxc,al
sub maxr,1
sub maxc,1
mov eax,5000
call delay
pop eax
push eax
mov eax,0
mov al,rmaxc
sub al,1
mov missv,al
pop eax
push edx
mov dh,0
mov dl,0
call gotoxy
;                                              BORDERS

rowborders:
push edx
push eax 
cmp col,0Fh
je resetr
conti:
mov ax,col
call settextcolor
mov eax,wait1
call delay
mov edx,offset rbard
call writestring
pop eax
pop edx

cmp dl,missv
je setx
add dl,1

jmp rowborders

resetr:
mov col,1
jmp conti
resetc:
mov col,1
jmp cont


columnborders:

push edx
push eax 
cmp col,0Fh
je resetc
cont:
mov ax,col
call settextcolor
mov eax,wait1
call delay
mov edx,offset cbard
call writestring
pop eax
pop edx
cmp dl,y
je sett
add dl,1

 jmp columnborders
 sett:
 ;add col,1
 add dh,1
 cmp dh,maxr
 jg setvv

 mov dl,chk
 call gotoxy
 call columnborders

setx:
;add col,1
mov dl,0
add dh,1
cmp dh,x
je setxy1
call gotoxy
jmp rowborders

setvv :
mov col,1
cmp chk,0
jne lbricks
mov dh,4
mov dl,rmaxc
mov y,dl
sub y,1
sub dl,4

mov chk,dl
call gotoxy
call columnborders

sety:
mov dl,0
add dh,1
cmp dh,maxr
jg lbricks

jmp columnborders

setxy1:
push ebx
mov col,1
;jmp lmain
mov bh,rmaxr
cmp x,bh
je setv
mov x,bh
sub bh,4
mov dh,bh
mov dl,0
call gotoxy

jmp rowborders

setv:
mov col,1
mov dh,4
mov dl,0
mov y,3
call gotoxy
jmp columnborders





;                                                   BRICKS
lbricks:






llbricks:
pushad
mov eax,0d7h
call settextcolor
mov dh,minr
mov dl,minc
mov x,0
mov y,0
mov x,6
la:
call gotoxy
push edx
mov edx,offset bricks
call writestring
pop edx
cmp dl,maxc
je lc


add dl,1
jmp la





lb:
cmp dh,x
je lc
add dh,1
mov dl,minc
jmp la
lc:
popad
jmp lpaddle
;                                         Paddle
lpaddle:
call my_color
jmp lmain

;                                          BALL MOVEMNT

lmain:



pop edx
mov edx,1
mov dh,minr
mov dl,minc
movzx ebx,minr

;                                                                   11

l11:


call input
call gotoxy
push edx

mov edx,offset ball
call writestring

mov eax,ballsp
call delay


pop edx
call gotoxy
push edx

push eax
mov eax,000h
call settextcolor

mov edx,offset ball
call writestring

mov eax,00fh
call settextcolor

pop eax
pop edx


cmp dh,maxr
jae l0x
cmp dl,maxc
jae lx0

mov bh,dh
mov bl,dl

add dh,radd
add dl,cadd

mov ah,dh
add ah,radd
mov nx,ah
mov al,dl
add al,cadd
mov ny,al

cmp ah,maxr 
jae paddle11

cmp dh,maxr
jae set11
;cmp dl
jmp l11

;                     paddle11
paddle11:

cmp al,cpady
jl gameover
mov ah,cpady
add ah,7
cmp ny,ah
jg gameover

jmp l0x



;                                                                     01

l01:
call input
call gotoxy
push edx

mov edx,offset ball
call writestring

mov eax,ballsp
call delay


pop edx
call gotoxy
push edx

push eax
mov eax,000h
call settextcolor

mov edx,offset ball
call writestring

mov eax,00fh
call settextcolor

pop eax
pop edx

cmp dh,minr
je l1x
cmp dl,maxc
je lx0

mov bh,dh
mov bl,dl
sub dh,radd
add dl,cadd

cmp dh,minr
jbe set01

jmp l01

;                                                                       10

l10:
call input

call gotoxy
push edx

mov edx,offset ball
call writestring

mov eax,ballsp
call delay


pop edx
call gotoxy
push edx

push eax
mov eax,000h
call settextcolor

mov edx,offset ball
call writestring

mov eax,00fh
call settextcolor

pop eax
pop edx

cmp dh,maxr
je l0x
cmp dl,minc
je lx1

mov bh,dh
mov bl,dl

add dh,radd
sub dl,cadd

mov ah,dh
add ah,radd
mov nx,ah
mov al,dl
sub al,cadd
mov ny,al

cmp ah,maxr 
jae paddle10

cmp dh,maxr
jae set10

jmp l10

;                                       paddle10


paddle10:
cmp al,cpady
jl gameover
mov ah,cpady
add ah,7
cmp ny,ah
jg gameover

jmp l0x



;                                                                        00

l00:

call input
call gotoxy
push edx

mov edx,offset ball
call writestring

mov eax,ballsp
call delay


pop edx
call gotoxy
push edx

push eax
mov eax,000h
call settextcolor

mov edx,offset ball
call writestring

mov eax,00fh
call settextcolor

pop eax
pop edx

cmp dh,minr
je  l1x
cmp dl,minc
je  lx1

mov bh,dh
mov bl,dl

sub dh,radd
sub dl,cadd

cmp dh,minr
jbe set00

jmp l00

 ;                                                                      1x

l1x:
call scoreup
cmp dl,bl
jg l11
cmp dl,bl
jl l10


;                                                                        0x

l0x:
cmp dl,bl
jg l01
cmp dl,bl
jl l00
jmp l0x

;                                                                       x0

lx0:

cmp dh,bh
jg l10
cmp dh,bh
jl l00

 ;                                                                       x1

lx1:
cmp dh,bh
jg l11
cmp dh,bh
jl l01

;                                                           set11
set11:
cmp dl,maxc
jne l11
mov dh,35

call setbd
jmp l00
;                                                             set01
set01:
cmp dl,maxc
jne l01
mov dh,5

call setbd
jmp l10
;                                                            set10
set10:
cmp dl,minc
jne l10
mov dl,5

call setbd
jmp l01
;                                                           set00
set00:
cmp dl,minc
jne l00
mov dh,5
call setbd
jmp l11
;                                                           setballdiagnol
setbd proc
push ebx
mov bl,vv
mov cadd,bl
cmp vv,1
je lll
mov vv,1
jmp llll
lll:
mov vv,3
llll:
pop ebx
ret
setbd endp


gameover:
call gameoverr
mov dh,42
mov dl,0
call gotoxy
jmp exi











;                                              destroyingbricks
exi:
main endp
end main