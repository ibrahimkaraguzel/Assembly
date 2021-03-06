;fonksiyon tan�m dosyalar�
include windows.inc
include user32.inc
include kernel32.inc
include comctl32.inc
include comdlg32.inc
include shell32.inc
include advapi32.inc
Include AniGIF.inc
include ufmod.inc

;makrolar
include \masm32\macros\macros.asm

;fonksiyonlar�n kendilerinin bulundu�u k�t�phaneler
includelib winmm.lib
includelib user32.lib
includelib kernel32.lib
includelib comctl32.lib
includelib comdlg32.lib
includelib shell32.lib
includelib advapi32.lib
IncludeLib AniGIF.lib
includelib ufmod.lib

;prototipler
PencereIslemi			PROTO	:HWND,:UINT,:WPARAM,:LPARAM
ImlecYukle				PROTO	:HWND,:UINT,:WPARAM,:LPARAM;imle�y�kle i�lemi prototipi ile linke imle� y�kl�yoruz
SaydamPencere			PROTO 	:DWORD,:DWORD
SerialUret				PROTO	:DWORD

;sabitler
.const
pencere				equ 101
muzik				equ 500
logoGif				equ	501
MAXSIZE				equ	512

rsmLOGO				equ 1001
grpAdSerial			equ 1002
lblAd				equ 1003
lblSerial			equ 1004
edtAd				equ 1005
edtSerial			equ 1006
lblLink				equ 1007
btnKapat			equ 1008
btnHakkinda			equ 1009
btnKopyala			equ 1010
btnUret				equ 1011
aniLogo				equ	1012

TransparanDerece	equ 200 ;Transparanl�k derecesi ( en fazla 254 )

PUBLIC hInstance

;de�i�kenlerimiz
.data
msgBaslik		db "Hakk�nda",0
msgHakkinda		db "[SCT]Keygen Template for SCTZine 2017",13,10,13,10
				db "Esen!",13,10
				db "Rnd0M bug�n benden keygen projelerinde, Bitmap",13,10
				db "yerine hareketli GIF kullanabilir miyiz diye",13,10
				db "mesaj g�ndermi�. Tabi k�ramad�m ve bir taslak",13,10
				db "haz�rlad�m. Rnd0M karde�im art�k bir kahve �smarlars�n =)",13,10,13,10
				db "Assembly i�erisinde GIF kullanmak ger�ekten s�k�nt�.",13,10
				db "Harici ibr k�t�phane buldum onu kullanarak bu",13,10
				db "keygen tasla��n� haz�rlad�m. GIF kullanmak ile ilgili",13,10
				db "lisans sorunlar� varm�� ama ��z�lm�� galiba neyse..",13,10,13,10
				db "�zellikler:",13,10
				db "M�zik, saydaml�k, link ve haz�r �al��an butonlar.",13,10
				db "Ayr�ca hareketli canl� kanl� bir GIF!",13,10,13,10
				db "Yazan:",9,"BlueDeviL // SCT",13,10
				db "Tester:",9,"Rnd0M // Decompile.us",13,10
				db "Tarih:",9,"17.05.2017",13,10
				db "E-Posta:",9,"bluedevil@sctzine.com",13,10,13,10
				db "Te�ekk�rler",13,10
				db "Errorinside, Infexia, Yakuter, Rnd0M",13,10
				db "[SCT] 2017",0

TarayiciyaGit  	db "open", 0
SCTweb			db "http://www.sctzine.com/",0

;verib�y�kl��� belli olmayan de�i�kenler
.data?
hInstance		dd ?
hSerial			dd ?;serialimizin handle'�
hImlec			dd ?
hWAGif			HWND		?
hLib			DWORD		?
szName      	db  MAXSIZE	dup(?)
szSerial      	db  MAXSIZE	dup(?)
szHash			db  MAXSIZE	dup(?)
szHash2			db  MAXSIZE	dup(?)
szHashMD5		db  MAXSIZE	dup(?)
szLenH1			db  MAXSIZE	dup(?)
szBuff1			db  MAXSIZE	dup(?)
szBuff2			db  MAXSIZE	dup(?)
