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

;prototipler
EyiBas					PROTO
UyariBas				PROTO
HataBas					PROTO
SetConsoleTextColor		PROTO :DWORD, :DWORD

;sabitler
.const

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
	konsolBaslik		db	"[SCT]SetConsoleText Uygulamasi",0 
	ileti01				db	"E�er olumlu sonu� var ise ye�il rengi kullanal�m!",13,10,0
	ileti02				db	"Eger sorun yok ama uyarmak gerekiyorsa sari yazalim",13,10,0
	ileti03				db	"Demek Hata oldu kizil ile gosterelim!",13,10,0


;verib�y�kl��� belli olmayan de�i�kenler
.data?
	;genelTampon 		db 1024 (?)











