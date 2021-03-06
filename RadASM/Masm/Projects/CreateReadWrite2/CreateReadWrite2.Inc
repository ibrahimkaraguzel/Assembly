;fonksiyon tan�m dosyalar�
include windows.inc					;windows.inc her zaman en �stte

include masm32.inc
include user32.inc
include msvcrt.inc
include kernel32.inc

;masm32 makrolar�
include \masm32\macros\macros.asm

;fonksiyonlar�n kendilerinin bulundu�u k�t�phaneler
includelib masm32.lib
includelib user32.lib
includelib msvcrt.lib
includelib kernel32.lib

;sabitler
.const
	BELLEKALANI			equ	65535
;de�i�kenlerimiz
.data
	sctGS				db  "        �����������������������������������������������������������������Ŀ",13,10
						db	"      ���                                                                 �Ŀ",13,10
						db	"      �       ����������������             ������         �����������������ܳ",13,10
						db	"      �     ���������   ���������       ���������������   �����������������߳",13,10
						db	"      �     ���������   ���������     ��������   �������        ������      �",13,10
						db	"      �    ���������    ���������     �������    �������         ����       �",13,10
						db	"      �    ���������  �����������    ��������    ��������        ����       �",13,10
						db	"      �     ��������         ����    ��������    �������         ����       �",13,10
						db	"      �       �������                �������   ���               ����       �",13,10
						db	"      �       ���������������        �������                     ����       �",13,10
						db	"      �    ��       ������������     �������         ����        ����       �",13,10
						db	"      �    ���������     �������     �������   ���������         ����       �",13,10
						db	"      �    ���������     ��������    ��������    �������         ����       �",13,10
						db	"      �    ���������     �������      �������    �������         ����       �",13,10
						db	"      �    ��������      �������      �������    ������          ����       �",13,10
						db	"      �      �����������������          ��������������           ����       �",13,10
						db	"      �          ������                   �����                  ����       �",13,10
						db	"      �                                                                     �",13,10
						db	"      �             �����������������������������������������               �",13,10
						db	"      �                  g u r u r l a     s u n a r                        �",13,10
						db	"      �             �����������������������������������������               �",13,10
						db	"      �Ŀ                                                 www.sctzine.com ���",13,10
						db	"        �������������������������������������������������������������������",13,10,0
	konsolBaslik		db	"[SCT]CreateFile ReadFile WriteFile Uygulamasi 2",0 
	strMetin			db	"[ OLDU  ] * Burayi okuyorsan islem basarili",13,10,0
	pDosyaYolu			db	"deneme.txt",0	;exenin oldu�u dizine yaratacak
	szStr				dd	0DEADBEEFh

;veri i�eri�i tan�mlanmayan de�i�kenler
.data?
	hDosya				HANDLE	?
	hBellek				HANDLE	?
	okumaTamponu		DWORD	?
	pTampon				DWORD	?
	intUzunluk			DWORD	?
	NumOfBytesRead		DWORD	?			;ReadFile APIsi bu de�i�keni istiyor,zorunlu,
											;okuma yap�ld�ktan sonra bize okunan yerin uzunlu�unu d�nd�recek,
											;hatta sonunda CRLF yani 13,10 bile varsa onlar�da say�ya katarak
	NumOfBytesWritten	DWORD	?			;WriteFile APIsi bunu istiyor zorunlu
											;yazma yap�ld�ktan sonra bize yaz�lan verinin uzunlu�unu d�nd�recek,
											;hatta sonunda CRLF yani 13,10 bile varsa onlar�da say�ya katarak
	genelTampon 		db 1024 (?)
