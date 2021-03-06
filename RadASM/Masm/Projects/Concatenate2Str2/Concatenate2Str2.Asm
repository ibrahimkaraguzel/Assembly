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
; Concatenate2Str2 Uygulamas� Tasla��
; _______________________________________________________________________________
; Yazar		: BlueDeviL <bluedevil@sctzine.com>
; Tester	: ErrorInside <errorinside@sctzine.com>
; IDE		: RADAssembler v2.2.2.2 <http://masm32.com/board/index.php?board=24.0>
; Taslak	: BlueDeviL // SCT
; Tarih  	: 05.05.2017
; �������������������������������������������������������������������������������
;																  www.sctzine.com
TITLE  [SCT]RadASM Konsol Uygulamasi Taslagi	 				  (main.asm)
.386					;kulland���m�z opcodelar�n hangi i�lemci setine ba�l� oldu�u
.model flat, stdcall	;32 bit haf�za modeli
option casemap :none	;b�y�k k���k harfe duyarl�


include Concatenate2Str2.Inc

.code
start:
	call main
	invoke subStrBirlestir, addr strBirlesmis, addr strBirinci, addr strIkinci
	print offset strBirlesmis
	print chr$(13,10)
	invoke subStrYerDegistir,addr strYerDegismis, addr strBirlesmis, addr strBulunacak, addr strDegistirilecek
	print offset strYerDegismis
	print chr$(13,10)
	inkey				;��kmadan �nce bekle
	exit
	
main proc
	invoke SetConsoleTitle,addr konsolBaslik		;Konsolumuza ba�l�k koyal�m
	invoke ClearScreen								;ekran� temizler
	print offset sctGS	
	ret

main endp
subStrBirlestir proc concatStr: ptr, str1 : ptr, str2 : ptr
	mov edi,0
	mov esi, str1
	mov edi, concatStr
	mov al, byte ptr [esi]
	.while al!=0
		mov byte ptr [edi], al
		inc esi
		inc edi
		mov al, byte ptr [esi]
	.endw
	mov al, " "
	mov byte ptr [edi], al
	inc edi
	mov esi,str2
	mov al, byte ptr [esi]
	.while al!=0
		mov byte ptr [edi], al
		inc esi
		inc edi
		mov al, byte ptr [esi]
	.endw
	ret
subStrBirlestir endp

subStrYerDegistir proc replacedStr : ptr, origStr:ptr, findStr:ptr, substStr:ptr
	LOCAL curPosOrigStr : ptr
	LOCAL curPosReplaceStr : ptr

	mov esi, replacedStr
	mov curPosReplaceStr, esi

	mov esi, origStr
	mov curPosOrigStr, esi
	
	mov edi, findStr	
@search:	
	mov al, [edi]
	cmp al,0
	je @match
	cmp byte ptr [esi],0
	je @end
	
	cmp byte ptr [esi], al
	jne @mismatch
	inc esi
	inc edi
	jmp @search

@match:
	mov curPosOrigStr, esi
	dec curPosOrigStr
	mov edi, substStr
@replace:
	mov al, byte ptr [edi]
	cmp al, 0
	je @next
	mov esi, curPosReplaceStr
	mov byte ptr [esi], al
	inc curPosReplaceStr
	inc edi
	jmp @replace
@mismatch:	
	; append to replacedStr
	mov esi, curPosOrigStr
	mov edi, curPosReplaceStr
	mov al, byte ptr [esi]
	mov byte ptr [edi], al
	inc curPosReplaceStr
@next:
	mov edi, findStr
	inc curPosOrigStr
	mov esi, curPosOrigStr
	cmp byte ptr [esi],0
	jne @search
@end:	
	ret
subStrYerDegistir endp
end start
