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
; Diyalog Animasyonlar� 0.1
; _______________________________________________________________________________
; Author	: BlueDeviL <bluedevil@sctzine.com>
; Tester	: ErrorInside <errorinside@hotmail.com>
; IDE		: RADAssembler v2.2.2.0 <radasm.cherrytree.at>
; Template	: BlueDeviL // SCT
; Date		: 03/11/2012
; �������������������������������������������������������������������������������
;																  www.sctzine.com
.386					;kulland���m�z opcodelar�n hangi i�lemci setine ba�l� oldu�u
.model flat, stdcall	;32 bit haf�za modeli
option casemap :none	;b�y�k k���k harfe duyarl�

include AnimateDiyalog.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax
	invoke LoadCursor,NULL,IDC_HAND;linke y�kleyece�imiz imlecin handle'�n� al
	mov 	hImlec,eax				;hImlec de�i�kenine y�kle
    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,pencere,NULL,addr PencereIslemi,NULL
	invoke ExitProcess,0

ImlecYukle proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
;bu i�lem ile linkin �zerine gelindi�inde imle� de�i�ecek
  .if uMsg==WM_SETCURSOR
    invoke SetCursor, hImlec
  .else
    invoke GetWindowLong, hWin, GWL_USERDATA
    invoke CallWindowProc, eax, hWin, uMsg, wParam, lParam
    ret
  .endif

  xor eax, eax
  ret
ImlecYukle endp

PencereIslemi proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	
	mov eax,hWin
	mov hMain,eax
	push hMain;ana pencerenin handle�n� y���na at�yoruz, sonra ikinci penceredeyken �a��raca��z
	mov		eax,uMsg
	.if eax==WM_INITDIALOG
		invoke LoadIcon,hInstance,5001		;ikonumuzu ekledik
											;ancak prog. �al���nca sol �stte ikon yok
											;bunu gidermek i�in ise:
		mov hIkon,eax
		invoke SendMessage,hWin,WM_SETICON,ICON_SMALL,hIkon;ile pencereye de ikon ekliyoruz
		
		invoke CheckDlgButton,hWin,1004,BST_CHECKED		;ilk a��l��ta her grubun ba��ndaki
		invoke CheckDlgButton,hWin,1022,BST_CHECKED		;radyobutonlar� i�aretliyoruz
		
		;�mlecYukle i�lemini lblLINK ile ili�kilendir
		invoke GetDlgItem,hWin,lblLINK
		push eax
		invoke SetWindowLong,eax,GWL_WNDPROC,ADDR ImlecYukle
		pop edx
		invoke SetWindowLong,edx,GWL_USERDATA,eax
		
	.elseif eax==WM_COMMAND
		mov eax,wParam
		mov edx,wParam
		shr edx,16
		
		.if dx==BN_CLICKED
			.if ax==lblLINK				;web adresimizin oldu�u yeremi t�kland�??
				invoke ShellExecute,hWin,ADDR TarayiciyaGit,ADDR SCTweb,NULL,NULL,0
			.endif
		.endif
		.if ax==btnTest					;e�er kullan�c� "Ayarlar� Dene" tu�una basarsa
			invoke CloseWindow,hWin		;Ana pencereyi minimize eder
			invoke Sleep,500;ana pencere a�a�� insin sonra test penceremiz a��ls�n arada biraz zaman olsun
			;CreateDialogParam ile yeni penceremizi yarat�yoruz (DialogBoxParam da kullan�labilir)
			invoke CreateDialogParam,hInstance,testpencere,hWin,ADDR TestPenceresi,0
			
			ret
		.endif
		.if ax==btnKapat				;e�er kullan�c� ��k�� tu�una basarsa
			
			invoke IsDlgButtonChecked,hWin,1014					;Sa�dan kayd�r
			cmp eax,0
			jz _Sonraki
		    mov ebx,AW_HIDE or AW_SLIDE or AW_HOR_NEGATIVE
			jmp _Son
			_Sonraki:
			invoke IsDlgButtonChecked,hWin,1015					;Soldan Kayd�r
			cmp eax,0
			jz _Sonraki0
			mov ebx,AW_HIDE or AW_SLIDE or AW_HOR_POSITIVE
			jmp _Son
			_Sonraki0:
			invoke IsDlgButtonChecked,hWin,1016					;Sa� k��eden sola
			cmp eax,0
			jz _Sonraki1
			mov ebx,AW_HIDE or AW_HOR_NEGATIVE or AW_VER_POSITIVE
			jmp _Son
			_Sonraki1:
			invoke IsDlgButtonChecked,hWin,1017					;Sol k��eden sa�a
			cmp eax,0
			jz _Sonraki2
			mov ebx,AW_HIDE or AW_HOR_POSITIVE or AW_VER_POSITIVE
			jmp _Son
			_Sonraki2:
			invoke IsDlgButtonChecked,hWin,1018					;Kaybolarak (Blending ya da fading)
			cmp eax,0
			jz _Sonraki3
			mov ebx,AW_HIDE or AW_BLEND
			jmp _Son
			_Sonraki3:
			invoke IsDlgButtonChecked,hWin,1019					;Merkeze do�ru
			cmp eax,0
			jz _Sonraki4
			mov ebx,AW_HIDE or AW_CENTER
			jmp _Son
			_Sonraki4:
			invoke IsDlgButtonChecked,hWin,1020					;A�a��dan Yukar�ya
			cmp eax,0
			jz _Sonraki5
			mov ebx,AW_HIDE or AW_VER_NEGATIVE
			jmp _Son
			_Sonraki5:
			invoke IsDlgButtonChecked,hWin,1021					;Yukar�dan A�a��ya
			cmp eax,0
			jz _Sonraki6
			mov ebx,AW_HIDE or AW_VER_POSITIVE
			jmp _Son
			_Sonraki6:
			invoke IsDlgButtonChecked,hWin,1022					;Sa�dan Sola
			cmp eax,0
			jz _Sonraki7
			mov ebx,AW_HIDE or AW_HOR_NEGATIVE
			jmp _Son
			_Sonraki7:
			mov ebx,AW_HIDE or AW_HOR_POSITIVE					;Soldan Sa�a
			
			_Son:
			
			invoke AnimateWindow,hWin,600,ebx
			invoke EndDialog,hWin,0								;penceri kapat
			ret
		.endif
		
		.if ax==btnHakkinda				;hakk�nda butonuna bas�ld�ysa
			invoke MessageBox,hWin,ADDR msgHakkinda,ADDR msgBaslik,MB_OK
			ret
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

TestPenceresi proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	
	
	.if uMsg==WM_INITDIALOG
	
		invoke LoadIcon,hInstance,5001		;ikonumuzu ekledik
											;ancak prog. �al���nca sol �stte ikon yok
											;bunu gidermek i�in ise:
		mov hIkon,eax
		invoke SendMessage,hWin,WM_SETICON,ICON_SMALL,hIkon;ile
		;pencereye de ikon ekliyoruz
		
		;A��l��ta Radyo Buton Kontrol�:

			invoke IsDlgButtonChecked,hMain,1013
			cmp eax,0
			jz _Digeri
			mov ebx,AW_ACTIVATE or AW_SLIDE or AW_HOR_NEGATIVE
			jmp _Sonn
			_Digeri:
			invoke IsDlgButtonChecked,hMain,1012
			cmp eax,0
			jz _Digeri0
			mov ebx,AW_ACTIVATE or AW_SLIDE or AW_HOR_POSITIVE
			jmp _Sonn
			_Digeri0:
			invoke IsDlgButtonChecked,hMain,1011
			cmp eax,0
			jz _Digeri1
			mov ebx,AW_ACTIVATE or AW_HOR_NEGATIVE or AW_VER_POSITIVE
			jmp _Sonn
			_Digeri1:
			invoke IsDlgButtonChecked,hMain,1010
			cmp eax,0
			jz _Digeri2
			mov ebx,AW_ACTIVATE or AW_HOR_POSITIVE or AW_VER_POSITIVE
			jmp _Sonn
			_Digeri2:
			invoke IsDlgButtonChecked,hMain,1009
			cmp eax,0
			jz _Digeri3
			mov ebx,AW_ACTIVATE or AW_BLEND
			jmp _Sonn
			_Digeri3:
			invoke IsDlgButtonChecked,hMain,1008
			cmp eax,0
			jz _Digeri4
			mov ebx,AW_ACTIVATE or AW_CENTER
			jmp _Sonn
			_Digeri4:
			invoke IsDlgButtonChecked,hMain,1007
			cmp eax,0
			jz _Digeri5
			mov ebx,AW_ACTIVATE or AW_VER_NEGATIVE
			jmp _Sonn
			_Digeri5:
			invoke IsDlgButtonChecked,hMain,1006
			cmp eax,0
			jz _Digeri6
			mov ebx,AW_ACTIVATE or AW_VER_POSITIVE
			jmp _Sonn
			_Digeri6:
			invoke IsDlgButtonChecked,hMain,1005
			cmp eax,0
			jz _Digeri7
			mov ebx,AW_ACTIVATE or AW_HOR_NEGATIVE
			jmp _Sonn
			_Digeri7:
			mov ebx,AW_ACTIVATE or AW_HOR_POSITIVE
			
			_Sonn:
        	invoke AnimateWindow,hWin,600,ebx
        	invoke SetFocus,hWin
                    
	.elseif uMsg==WM_COMMAND
		mov eax,wParam
		.if eax==btnKKapat				;kullan�c� Kapat butonuna basarsa
			KapanmaKontrolu:
			invoke IsDlgButtonChecked,hMain,1014					
			cmp eax,0
			jz _Sonraki
		    mov ebx,AW_HIDE or AW_SLIDE or AW_HOR_NEGATIVE
			jmp _Son
			_Sonraki:
			invoke IsDlgButtonChecked,hMain,1015				
			cmp eax,0
			jz _Sonraki0
			mov ebx,AW_HIDE or AW_SLIDE or AW_HOR_POSITIVE
			jmp _Son
			_Sonraki0:
			invoke IsDlgButtonChecked,hMain,1016					
			cmp eax,0
			jz _Sonraki1
			mov ebx,AW_HIDE or AW_HOR_NEGATIVE or AW_VER_POSITIVE
			jmp _Son
			_Sonraki1:
			invoke IsDlgButtonChecked,hMain,1017				
			cmp eax,0
			jz _Sonraki2
			mov ebx,AW_HIDE or AW_HOR_POSITIVE or AW_VER_POSITIVE
			jmp _Son
			_Sonraki2:
			invoke IsDlgButtonChecked,hMain,1018				
			cmp eax,0
			jz _Sonraki3
			mov ebx,AW_HIDE or AW_BLEND
			jmp _Son
			_Sonraki3:
			invoke IsDlgButtonChecked,hMain,1019					
			cmp eax,0
			jz _Sonraki4
			mov ebx,AW_HIDE or AW_CENTER
			jmp _Son
			_Sonraki4:
			invoke IsDlgButtonChecked,hMain,1020					
			cmp eax,0
			jz _Sonraki5
			mov ebx,AW_HIDE or AW_VER_NEGATIVE
			jmp _Son
			_Sonraki5:
			invoke IsDlgButtonChecked,hMain,1021					
			cmp eax,0
			jz _Sonraki6
			mov ebx,AW_HIDE or AW_VER_POSITIVE
			jmp _Son
			_Sonraki6:
			invoke IsDlgButtonChecked,hMain,1022				
			cmp eax,0
			jz _Sonraki7
			mov ebx,AW_HIDE or AW_HOR_NEGATIVE
			jmp _Son
			_Sonraki7:
			mov ebx,AW_HIDE or AW_HOR_POSITIVE						
			
			_Son:
			
			invoke AnimateWindow,hWin,600,ebx
			invoke EndDialog,hWin,0								;Test penceremizi kapat�yoruz sonrada
			invoke ShowWindow,hMain,SW_RESTORE					;Ana pencereyi bununla eski haline getiriyoruz
			ret
		.endif
	.elseif uMsg==WM_CLOSE
		;kullan�c� sa� �stteki tu�a basarsa yukar�daki kapanma kontrol�ne dallan
		;Ayn� kodu tekrar yazmaya gerek yok de�il mi?
		jmp KapanmaKontrolu
	.endif
	xor eax,eax
	ret

TestPenceresi endp

end start
