.386 
.model flat, stdcall 
option casemap :none 

include BubbleSortRev.inc

.code 
start: 
;ekrana dizimizin ilk hali yazd�r�yoruz
invoke StdOut, addr ileti1
xor esi, esi
xor eax, eax
xor ebx, ebx
xor ecx, ecx
mov ecx, LENGTHOF intArray
mov ebx, 11
_yazdir0 :
mov al, [intArray + esi]
invoke dwtoa, eax, addr tampon01	;dwtoa ile eax yazmac�nda ne yaz�yorsa onu belirledi�imiz tampon de�i�kene att�k
invoke StdOut, addr tampon01
invoke StdOut, addr yeniSatir
dec ebx
mov ecx, ebx
inc esi
loop _yazdir0
;_________________________________________
;�imdi kabarc�k algoritmam�z� yazd�ral�m:
xor eax,eax
xor ecx,ecx
; LENGHTOF ile dizinin boyunu alabiliyoruz
mov ecx, LENGTHOF intArray

_disDongu:
xor ebx, ebx					;yazmac�n birtanesini tampon olarak kullanmak i�in s�f�rl�yoruz

_icDongu:
mov al, [intArray + bx]; dizinin ilk eleman�n� al, ebx artt�k�a da s�radaki eleman� al
cmp al, [intArray + bx + 1]; al ile dizinin s�radaki eleman�n� kar��la�t�r
ja _degistirme; e�er ikinci eleman ilkinden b�y�kse sayac� art�r�p di�er dizi eleman�na ge�mek �zere dallan

mov ah, [intArray + bx + 1];dallanma olmazsa buraya geliyor 
mov[intArray + bx + 1], al
mov[intArray + bx], ah


_degistirme:
inc bx
cmp bx, 9
jne _icDongu
loop _disDongu


;__________________________________________
;Dizimizin son halini yazd�ral�m:
mov edx, offset ileti2
invoke StdOut, addr ileti2
xor esi, esi
xor eax, eax
xor ebx, ebx
xor ecx, ecx
mov ecx, LENGTHOF intArray
mov ebx, 11
_yazdir :
mov al, [intArray + esi]
invoke dwtoa, eax, addr tampon01
invoke StdOut, addr tampon01
invoke StdOut, addr yeniSatir
dec ebx
mov ecx, ebx
inc esi
loop _yazdir
        
inkey	;Press any key to continue yazd�rmak i�in gerekli.
invoke ExitProcess, 0 
end start