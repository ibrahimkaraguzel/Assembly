; ����������������������������������������������?
; �?������������������������������������������?�?
; �?? �����������   �����������   ����������� ?�?
; �?? �����������   �����������   ����������� ?�?
; �?? ��            ���               ���     ?�?
; �?? ��            ��                ���     ?�?
; �?? �����������   ��                ���     ?�?
; �?? �����������   ��                ���     ?�?
; �??          ��   ��                ���     ?�?
; �??          ��   ���               ���     ?�?
; �?? �����������   �����������       ���     ?�?
; �?? �����������   �����������       ���     ?�?
; �??                                         ?�?
; �??                home of secret reversers�?�?
; �?������������������������������������������?�?
; HexBinConverter v1.0
; _______________________________________________________________________________
; Yazar		: BlueDeviL <blau_devil@hotmail.com>
; Tester	: ErrorInside <errorinside@hotmail.com>
; IDE		: RADAssembler v2.2.2.0 <http://radasm.cherrytree.at/>
; Taslak	: BlueDeviL // SCT
; �������������������������������������������������������������������������������
;																  www.sctzine.com

.386					;kulland���m�z opcodelar�n hangi i�lemci setine ba�l� oldu�u
.model flat, stdcall	;32 bit haf�za modeli
option casemap :none	;b�y�k k���k harfe duyarl�

include HexBinConverter.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,pencere,NULL,addr PencereIslemi,NULL
	invoke ExitProcess,0


PencereIslemi proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov		eax,uMsg
	.if eax==WM_INITDIALOG
	invoke LoadIcon,hInstance,5001
	invoke SendMessage,hWin,WM_SETICON,ICON_BIG,eax
	invoke SendDlgItemMessage,hWin,edtHEX,EM_LIMITTEXT,8,0		;edtHEX max 8 karakter ile s�n�rland�r
	invoke SendDlgItemMessage,hWin,edtBIN,EM_LIMITTEXT,20h,0	;edtBIN max 32 karakter ile s�n�rland�r
	invoke GetDlgItem,hWin,edtHEX								;edtHEX editinin "handle"�n� al eax'e yaz
	invoke SetWindowLong,eax,GWL_WNDPROC,addr EditAFKontrolu	;SetWindowLong APIsi ile EditAFKontrolu fonksiyonunda
																;belirtti�imiz �ekilde edtHEX editinin davran���n�
																;de�i�tir.Biz bu fonk. ile bu edite sadece 0-9 ve A-F
																;karakterlerinin yaz�labilmesine izin verdik.
	mov EskiPenIslemi,eax
	
	invoke GetDlgItem,hWin,edtBIN								;edtHEX editinin "handle"�n� al eax'e yaz
	invoke SetWindowLong,eax,GWL_WNDPROC,addr EditIkiKontrolu	;SetWindowLong APIsi ile EditIkiKontrolu fonksiyonunda
																;belirtti�imiz �ekilde edtBIN editinin davran���n�
																;de�i�tir.Biz bu fonk. ile bu edite sadece 0-1
																;karakterlerinin yaz�labilmesine izin verdik.
	mov EskiPenIslemi,eax
	mov kntrlBAYRAK,TRUE
	
	.elseif eax==WM_COMMAND
	mov eax,wParam
	mov edx,wParam
	shr edx,16
		.if dx==BN_CLICKED
			.if ax==btnKAPAT
				invoke SendMessage,hWin,WM_CLOSE,0,0
			.elseif ax==btnYARDIM
				invoke MessageBox,hWin,addr msgYardim,addr msgBaslik,MB_APPLMODAL
			.endif
		.endif
		shr eax,16
		.if ax==EN_SETFOCUS
			invoke SendMessage,lParam,WM_GETTEXT,24h,addr tampon2
		.elseif ax==(EN_UPDATE) && (kntrlBAYRAK)
			invoke SendMessage,lParam,WM_GETTEXT,24h,addr tampon1
			mov ecx,eax
			mov eax,wParam
			and eax,0000FFFFh
			.if ax==edtHEX
				mov kntrlBAYRAK,FALSE
				invoke HexOlarakAl,addr tampon1,ecx
				mov eax,ebx
				push eax
				push ebx
				invoke OnA2Iki,eax
				invoke wsprintf,addr tampon3,addr formatubits,eax
				invoke SetDlgItemText,hWin,lblBITS,addr tampon3
				invoke SetDlgItemText,hWin,edtBIN,addr tampon2
				invoke SetDlgItemText,hWin,edtBIN2,addr tampon2
				pop ebx
				pop eax
				invoke wsprintf,addr tampon3,addr formats,ebx
				invoke SetDlgItemText,hWin,edtDEC,addr tampon3
				mov kntrlBAYRAK,TRUE
			.elseif ax==edtBIN
				mov kntrlBAYRAK,FALSE
				
				sub eax,eax
				mov ebx,ecx
				or ebx,ebx
				je _islemyapma
				invoke Iki2OnA,addr tampon1,ecx
				
				_islemyapma:
				mov tampon4,ebx;ebx'de HEX de�erim var
				;a�a��daki 2 kodla ka� bitlik 2lik de�er girdi�imi yazd�r�yorum
				invoke wsprintf,addr tampon2E,addr formatubits,ecx
				invoke SetDlgItemText,hWin,lblBITS,addr tampon2E
				
				;a�a��daki 2 kodla edtHEX'e girdi�im ikilik de�erin HEX kar��l���n� yazd�r�yorum
				invoke wsprintf,addr tampon3E,addr formatX,tampon4
				invoke SetDlgItemText,hWin,edtHEX,addr tampon3E
				
				;a�a��daki 2 kodl ile de ikilik de�erin onluk kar��l���n� yazd�r�yorum
				invoke wsprintf,addr tampon1E,addr formats,ebx
				invoke SetDlgItemText,hWin,edtDEC,addr tampon1E
				
				;invoke OnA2Iki,tampon4
				invoke SetDlgItemText,hWin,edtBIN2,addr tampon1
				
				mov kntrlBAYRAK,TRUE
			.endif
		.endif
	.elseif eax==WM_CLOSE
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

PencereIslemi endp

comment *
HexOlarakAl fonksiyonunu kullan�c�n�n edite girdi�i 32bitlik HEX de�erini al�p
ebx yazmac�na (oradanda CikanDeger de�i�kenine) yazd�rmak i�in yazd�m. B�ylece
Yazmac�n bir tanesinde kullan�c�n�n girmi� oldu�u hex de�erini kolayl�kla kull
anabilmi� oluyorum.
*
HexOlarakAl proc GelenDeger:DWORD,GelenUzunluk:DWORD

mov esi,GelenDeger
mov ecx,GelenUzunluk
xor ebx,ebx


donguB:
shl ebx,4
dongu:
xor eax,eax
lodsb
push ecx
cmp al,30h
jb _son
cmp al,39h
ja _AFKontrol
sub al,30h
_devam:
add bl,al
pop ecx
loop donguB
mov CikanDeger,ebx
_son:

ret

_AFKontrol:
cmp al,41h
jb _son
cmp al,46h
ja _son
sub al,37h
jmp _devam

HexOlarakAl endp

comment *
OnA2Iki i�lemi onalt�l�k bir say�y�  ikilik bir say�ya �evirmek i�in  yazd���m
bir i�lemdir. Intel Opcodelar�nda BT olarak tan�mlanm�� "Bit Test" komutu var.
Bu komut ile yazmaca ald���m�z say�n�n her bir bitini test ederek tekrar yazd�
r�yoruz. Yazd�rd���m�z rakamlar bize o say�n�n ikilik de�erini veriyor
*

OnA2Iki proc GelenDeger:DWORD

mov edi,offset tampon2
mov ecx,1Fh
xor ebx,ebx
xchg edx,eax

_BitKontrol:
bt edx,ecx
setb al
or al,30h
stos byte ptr es:[edi]
dec ecx
jns _BitKontrol

mov ecx,20h
xchg edi,esi
sub esi,ecx

_DonguHB:
lods byte ptr ds:[esi]
cmp al,31h
je _DonguHB2
loopd _DonguHB
_DonguHB2:
xchg eax,ecx
pop edi
pop esi
pop edx
pop ecx

ret

OnA2Iki endp

comment *
Iki2OnA i�lemi ad�ndan da anla��laca�� gibi ikilik bir say�y� onalt�l�k de�ere
d�n��t�rmeye yarar.
*
Iki2OnA proc GelenDeger:DWORD,GelenUzunluk:DWORD

push eax
push ecx
push edi
sub eax,eax
xor edi,edi
mov ecx,GelenUzunluk
mov esi,offset tampon1
_donbasa:
lods byte ptr[esi]
or al,al
je _SayilarBitti
sub al,30h
_SayilarBitti:
add edi,edi
or edi,eax
dec ecx
jnz _donbasa
mov tampon3,edi
mov ebx,edi

;sonradan eklendi
mov ecx,GelenUzunluk
mov esi,offset tampon1
_basi:
lods byte ptr[esi]
cmp al,31h
je _dallan
loopd _basi
_dallan:
;buraya kadar
pop edi
;pop ecx
pop eax

ret

Iki2OnA endp

comment *
EditAFKontrolu bizim SubClassing i�in kulland���m�z 2 fonkisyondan birisi. A�a
��daki fonksiyonda edite sadece A-F, 0-9 ve Backspace tu�alar�n�n kullan�m�na
izin veriyoruz. Bu fonksiyomun i�lemesi i�in ise PencereIsleminin WM_INITDIALOG
b�l�m�nde �nce davran���n� de�i�tirece�imiz editin handlen� al�p daha sonrada
"SetWindowLong" APIsi ile a�a��daki foksiyonu �a��rarak editimizin davran���n� 
de�i�tiriyoruz.

Bir alttaki fonksiyonda ise edit binary(ikilik) oldu�u i�in sadece "0" ve "1"
karakterlerinin yazd�r�labilmesine ve yine Backspace tu�unun kullan�labilmesine
izin verdim.

Not:Bu subclassing i�lemini Iczelionun Subclassing dersinden d�zenleyerek buraya
ekledim.
*
EditAFKontrolu proc hEdit:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	
	.if uMsg==WM_CHAR
		mov eax,wParam
		.if (al>="0" && al<="9") || (al>="A" && al<="F") || (al>="a" && al<="f") || al==VK_BACK
			.if al>="a" && al<="f"
				sub al,20h
			.endif
			invoke CallWindowProc,EskiPenIslemi,hEdit,uMsg,eax,lParam
			ret
		.else
			invoke MessageBeep,0FFFFFFFFh
		.endif
		ret
	.else
	invoke CallWindowProc,EskiPenIslemi,hEdit,uMsg,wParam,lParam
	.endif
	ret

EditAFKontrolu endp

EditIkiKontrolu proc hEdit:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
.if uMsg==WM_CHAR
	mov eax,wParam
	.if (al>="0" && al<="1") || al==VK_BACK
		invoke CallWindowProc,EskiPenIslemi,hEdit,uMsg,eax,lParam
		ret
	.else
		invoke MessageBeep,0FFFFFFFFh
	.endif
.else
	invoke CallWindowProc,EskiPenIslemi,hEdit,uMsg,wParam,lParam
	ret
.endif
xor eax,eax
ret
EditIkiKontrolu endp

end start
