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
	HEAP_START 			equ 2000000 ; 2 MByte
	HEAP_MAX 			equ 400000000 ; 400 MByte
	BLOCK_SIZE 			equ 500000 ; .5 MByte
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
	konsolBaslik		db	"[SCT]MemoryAllocation Uygulamasi",0 
	dosyaAdi			db	"filename.exe",0

;verib�y�kl��� belli olmayan de�i�kenler
.data?
	hDosya				HANDLE	?
	hHeap				HANDLE	?
	hMemory				HANDLE	?
	pMemory				DWORD	?
	hGMemory			HANDLE	?
	pGMemory			DWORD	?
	hLMemory			HANDLE	?
	pLMemory			DWORD	?
	hVMemory			HANDLE	?
	pVMemory			DWORD	?
	dosyaBoyutu			DWORD	?
	numBytesRead		DWORD	?
	Comment @ Bu kadar �ok de�i�ken tan�mlamaya gerek yoktu
			Sadece yordamlardaki kullan�mlar� daha belirgin olsun istedim@
