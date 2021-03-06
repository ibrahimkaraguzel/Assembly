;fonksiyon tan�m dosyalar�
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc
include gdi32.inc
include masm32.inc		;nseed ve nrandom i�lemlerinin buradan �a��r�yoruz
include fpu.inc
include uxtheme.inc


;fonksiyonlar�n kendilerinin bulundu�u k�t�phaneler
includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib
includelib gdi32.lib
includelib masm32.lib
includelib fpu.lib
includelib uxtheme.lib


;prototipler
PencereIslemi	PROTO	:HWND,:UINT,:WPARAM,:LPARAM;diyalog i�lemi prototipi
ImlecYukle		PROTO	:HWND,:UINT,:WPARAM,:LPARAM;imle�y�kle i�lemi prototipi ile linke imle� y�kl�yoruz
RassalReelUret	PROTO	:DWORD
Rastgele01		PROTO	:DWORD
Rastgele110		PROTO	:DWORD

;sabitler
.const
pencere			equ 101
ikon			equ 5001

lst0dan1e		equ 1003
lst1den10a		equ 1004
btnKapat		equ 1005
btnHakkinda		equ 1006
btnUret			equ 1007
lblLINK			equ 1008

;de�i�kenlerimiz
.data
msgBaslik		db "Hakk�nda",0
msgHakkinda		db "Rastgele Reel Say� �reteci",13,10,13,10
				db "RDTSC(Time Stamp Counter) kullanarak rastgele say� �retmek:",13,10,13,10
				db "Pentium i�lemcilerle beraber gelen bu komut �a�r�ld���nda i�lemcinin",13,10
				db "devrini bize d�nd�r�r.64bit yazma� kullan�r bunun i�in i�in d���k �ncelikli",13,10
				db "32biti EAX yazmac�na y�ksek �ncelikli 32biti EDX yazmac�na yazar.RDTSC bize",13,10
				db "zaman de�il i�lemcinin devrini d�nd�r�r. Ayr�ca ayr�nt�l� bilgi i�in web",13,10
				db "sayfam�za bak�n�z.",13,10,13,10
				db "nrandom Fonksiyonunu kullanarak rastgele say� �retmek:",13,10,13,10
				db "MASM32.lib k�t�phanesinde bulunan bir fonksiyondur. MASM kendi i�lemidir.",13,10
				db "H�zl� ve kullan��l�d�r. nseed i�lemi ile de nrandomun her a��l���nda farkl�",13,10
				db "bir say�y� d�nd�rmesini sa�lar�z.",13,10,13,10
				db "FPU komutlar�:",13,10,13,10
				db "RDTSC ve nrandom ile �retti�imiz tamsay� rassal say�y�",13,10
				db "pi say�s� ile �arparak reel hale getiryoruz.FPU komutlar�ndan",13,10
				db "fldpi pi say�s�n� d�nd�r�r.fldl2e komutu ise e sabitini d�nd�r�r.",13,10
				db "Bu ikisini kullanmak zorunda de�ilsiniz, bir de�i�kene reel bir say�",13,10
				db "atayarakda kendi rassal say� fonksiyonunuzu olu�turabilirsiniz.",13,10
				db "FPU i�in ayr�nt�l� bilgi i�in Raymond Filiatreault taraf�ndan haz�rlanm��",13,10
				db "bir a� sayfas� var oray� ziyaret ediniz.",13,10,13,10
				db "Yazan:",9,"BlueDeviL // SCT",13,10
				db "Tarih:",9,"04.08.2012",13,10
				db "E-Posta:",9,"bluedevil@sctzine.com",13,10,13,10
				db "Te�ekk�rler",13,10
				db "MASM32 Forumlar�,Emektar bilgisayar�m",13,10
				db "[SCT] 2012",0
				
TarayiciyaGit  	db "open", 0
SCTweb			db "http://www.sctzine.com/",0
format			db "%u",0

tampon2			dd 345d
on				db 10d
.data?

hInstance			dd ?;penceremizin handle'�
hIkon				dd ?;ikonumuzun handle'�
hListeKutusu		dd ?;serialimizin handle'�
hListeKutusu2		dd ?;serialimizin handle'�
hImlec				dd ?;linke y�kledi�imiz imlecin handle'�

rastsayi			dd ?
tampon				db ?
tampon3				db ?

;#########################################################################
