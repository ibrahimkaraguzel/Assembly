include \masm32\include\windows.inc 
include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib 
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib	;olmazsa "inkey" hata veriyor

;masm macrosu     
include \masm32\macros\macros.asm	;olmazsa "inkey" hata veriyor

;prototiplerimiz
ExitProcess PROTO, dwExitCode:dword

.data
; intArray ad�nda 10 elemanl� bir dizi tan�ml�yoruz
intArray BYTE 21, 43, 11, 32, 98, 23, 44, 72, 13, 91
ileti1 BYTE "Dizimizin ilk hali: ",13,10,0
ileti2 BYTE "Dizimizin son hali: ",13,10,0
yeniSatir db 13, 10, 0 ;,13,10 yazd�k b�ylece alt sat�ra ge�mi� oldu.

.data?
tampon01 db 12 dup(?)
tampon02 db 12 dup(?) 