; �����������������������������������������������
; ��|�����������������������������������������|��
; ��| �����������   �����������   ����������� |��
; ��| �����������   �����������   ����������� |��
; ��| ��            ���               ���     |��
; ��| ��            ��                ���     |��
; ��| �����������   ��                ���     |��
; ��| �����������   ��                ���     |��
; ��|          ��   ��                ���     |��
; ��|          ��   ���               ���     |��
; ��| �����������   �����������       ���     |��
; ��| �����������   �����������       ���     |��
; ��|                                         |��
; ��|                home of secret reversers�|��
; ��|_________________________________________|��
; CreateFile ReadFile WriteFile Uygulamas� 2
; _______________________________________________________________________________
; Yazar		: BlueDeviL <bluedevil@sctzine.com>
; Tester	: ErrorInside <errorinside@sctzine.com>
; IDE		: RADAssembler v2.2.2.2 <http://masm32.com/board/index.php?board=24.0>
; Taslak	: BlueDeviL // SCT
; Tarih  	: 05.05.2017
; �������������������������������������������������������������������������������
;																  www.sctzine.com
TITLE  [SCT]CreateFile ReadFile WriteFile Uygulamasi 1			  (CreateReadWrite.asm)
.386
.model flat,stdcall
option casemap:none

include CreateReadWrite.Inc

.code
start:
	call main
	exit
	
main proc
	invoke SetConsoleTitle,offset konsolBaslik		;Konsolumuza ba�l�k koyal�m
	invoke ClearScreen								;ekran� temizler
	print offset sctGS
	
	push 0						;HANDLE hTemplateFile			NULL olabilir
								;								GENERIC_READ olarak a��ld���nda bi template handle verilebilir
								;								b�ylece yarat�l�rken geni�letilmi� �zelliklerle yarat�labilir
	push 0						;DWORD	dwFlagsAndAttributes	0x80FILE_ATTRIBUTE_NORMAL
	push 2						;DWORD	dwCreationDisposition	1 ->CREATE_NEW			yeni yarat�r zaten yarat�lm��sa hata verir
								;								2 ->CREATE_ALWAYS		yeni yarat�r ve �zerine yazar
								;								3 ->OPEN_EXISTING		ayg�tlar i�in genelde bu kullan�l�r
								;								4 ->OPEN_ALWAYS			varolan bir dosyay� a�ar, bulamazsa hata d�nd�r�r
								;								5 ->TRUNCATE_EXISTING	varolan dosyay� a�ar ve s�f�rlar,GENERIC_WRITE set edilmelidir
	push 0						;LPSECURITY_ATTRIBUTES
	push 3						;DWORD	dwShareMode				0 ->Di�er process'les a��lan bu dosya �zerinde i�lem yapamazlar
								;								1 ->FILE_SHARE_READ		di�er processlerde okuyabilir
								;								2 ->FILE_SHARE_WRITE	yazabilir
								;								3						hem okuyup hem yazabilir
								;								4 ->FILE_SHARE_DELETE	silebilir
	push 0C0000000h				;DWORD	dwDesiredAccess			GENERIC_READ | GENERIC_WRITE
	push offset dosyaYolu		;LPCTSTR	lpFileName
	call CreateFile
								;invoke CreateFile, offset dosyaYolu,GENERIC_READ | GENERIC_WRITE,NULL,NULL,CREATE_ALWAYS,NULL,NULL
								;Ba�ar�l� -> dosya, ayg�t, named pipe, mail slot ne a��ld�ysa onun handle'� d�nd�r�r
								;Ba�ar�s�z-> INVALID_HANDLE_VALUE d�nd�r�r.
	cmp eax, INVALID_HANDLE_VALUE
	je _acilamadi
	mov hDosya,eax				;ac�lan�n HANDLE de�eri
	print cfm$("\t01. Yazmak icin sorunsuz acildi",13,10)
	
	push offset dosyaMetin
	call lstrlen				;yaz�lacak metnin uzunlu�u
								;invoke lstrlen,offset dosyaMetin ;bu da yukar�daki iki sat�r�n ayn�s�
	
	push 0
	push offset NumOfBytesWritten;LPDWORD	lpNumberOfBytesWritten-senkron dosya handle'ndan gelen okunan bayt uzunlu�u g�stergecidir.
																;Asenkron ise NULL yap�labilir
	push eax					;DWORD		nNumberOfBytesToWrite-ayg�t veya dosyaya yaz�lacak verinin b�y�kl���
	push offset dosyaMetin		;LPCVOID	lpBuffer			ne yaz�lacaksa bu g�sterge� onu sakl�yor
	push hDosya					;HANDLE		hFile				CreateFile ile a��lan dosya/ayg�t/pipe handle de�eri
	call WriteFile
								;invoke WriteFile,hDosya,offset dosyaMetin,eax,offset NumOfBytesWritten,0
	print cfm$("\t02. WriteFile txt dosyasina yazdi",13,10)
	push hDosya
	call CloseHandle
	
	invoke CreateFile, offset dosyaYolu,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
	mov hDosya,eax
	print cfm$("\t03. Okumak icin sorunsuz acildi",13,10)
	invoke GlobalAlloc,GMEM_MOVEABLE or GMEM_ZEROINIT, BELLEKALANI
	mov hBellek,eax
	invoke GlobalLock,hBellek
	mov dosyaOkunan,eax
	
	push 0						;LPOVERRLAPPED	lpOverlapped	OVERLAPPED yap�s�na g�sterge�-pointer
	push offset NumOfBytesRead	;LPDWORD	lpNumberOfBytesRead	senkron dosya handle'ndan gelen okunan bayt uzunlu�u g�stergecidir.Asenkron ise NULL yap�labilir
	push BELLEKALANI-1			;DWORD		nNumberOfBytesToRead-okunabilecek max bayt b�y�kl���
	push dosyaOkunan			;LPVOID		lpBuffer			dosya ya da ayg�ttan okunan bu g�stergecin g�sterece�i alana yaz�lacak
	push hDosya					;HANDLE		hFile				CreateFile ile a��lan dosya/ayg�t/pipe handle de�eri
	call ReadFile			
								;invoke ReadFile,hDosya,offset dosyaOkunan,15,offset NumOfBytesRead,0
	;invoke StdOut, dosyaOkunan
	print chr$(9)				;9-> sekme
	print dosyaOkunan
	
	invoke GlobalUnlock,hBellek
	invoke GlobalFree,hBellek
	push hDosya
	call CloseHandle
	;invoke CloseHandle,hDosya
	print cfm$("\t04. Uygulamadan cikiyoruz...",13,10)
	jmp _cikis
	
	_acilamadi:
	print cat$(cfm$("\tDosya bulunamad�: "), str$(eax), chr$(13,10))
	
	_cikis:
	inkey
	ret

main endp

end start