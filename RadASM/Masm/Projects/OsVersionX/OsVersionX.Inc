;fonksiyon tan�m dosyalar�
include windows.inc					;windows.inc her zaman en �stte

include ntdll.inc
include masm32.inc
include user32.inc
include msvcrt.inc
include advapi32.inc
include kernel32.inc


;masm32 makrolar�
include \masm32\macros\macros.asm

;fonksiyonlar�n kendilerinin bulundu�u k�t�phaneler
includelib ntdll.lib
includelib masm32.lib
includelib user32.lib
includelib msvcrt.lib
includelib advapi32.lib
includelib kernel32.lib

;prototipler


RTL_OSVERSIONINFOEXW STRUCT
  dwOSVersionInfoSize	DWORD ?
  dwMajorVersion		DWORD ?
  dwMinorVersion		DWORD ?
  dwBuildNumber			DWORD ?
  dwPlatformId			DWORD ?
  szCSDVersion			WORD  128  dup (?)
  wServicePackMajor		WORD ?
  wServicePackMinor		WORD ?
  wSuiteMask			WORD ?    
  wProductType			BYTE ?
  wReserved				BYTE ?
RTL_OSVERSIONINFOEXW ENDS

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
	konsolBaslik		db	"[SCT]OsVersionX Application ",0 
	szRegPath			db	"SOFTWARE\Microsoft\Windows NT\CurrentVersion",0
	szRegWin10Maj		db	"CurrentMajorVersionNumber",0
	szRegWin10Min		db	"CurrentMinorVersionNumber",0
	szRegWinCV			db	"CurrentVersion",0
	szProductName		db	"ProductName",0
	szRegKey			db	"CurrentVersion",0
	szLibraryPath		db	"msvcrt.dll",0
	szMajorVersion		db	"_get_winmajor",0
	szMinorVersion		db	"_get_winminor",0
	szWinVer			db	"_get_winver",0
	format				db	"%d",0
	formatS				db	"%hs",0
	szBufferProductN	dd	32
	szBufferMajor		dd	32
	szBufferMinor		dd	32
	dwMajorVersion		dd	0
	dwMinorVersion		dd	0
	dwWinVer			dd	0

;verib�y�kl��� belli olmayan de�i�kenler
.data?
	genelTampon 		db	32		(?)
	bufferProductN		db	32		(?)
	bufferMajor			db	32		(?)
	bufferMinor			db	32		(?)
	binBuff   			db	17	dup	(?)
	osv					OSVERSIONINFO			<>
	osvx				OSVERSIONINFOEX			<>
	osvxa				OSVERSIONINFOEXA		<>
	rtlOsvx				RTL_OSVERSIONINFOEXW	<>
	hKey				dd	?










