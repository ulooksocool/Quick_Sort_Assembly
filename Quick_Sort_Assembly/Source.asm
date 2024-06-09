TITLE TEMPLATE
INCLUDE Irvine32.inc

.data

array SDWORD 10, 7, 8, 9, 1, -5, 18, 32, 3, 0 ; dhmiourgia pinaka proshmasmenwn arithmwn
msgold BYTE "THE FIRST ARRAY : ",0
msg BYTE "QUICK SORTED ARRAY : ",0
space BYTE ", ",0

.code
; a-> [ebp+8]
; b-> [ebp+12]
;void swap(int *a,int *b)
;{
;	int t=*a;
;	*a=*b;
;	*b=t;
;}
; -- Swap function --
; Description : This function swaps the values of two integers given as pointers.
; Input : EBP+8 -> Pointer to the first integer
;         EBP+12 -> Pointer to the second integer
; Output : The values of the two integers are swapped.
swap PROC
push ebp
mov ebp,esp
pushad

mov edi ,[ebp+8]
mov eax , [edi]  ; eax <- *a

mov esi ,[ebp+12]
mov ebx , [esi]  ; ebx <- *b

mov [esi],eax    ; *b <- *a
mov [edi],ebx    ; *a <- *b

popad
mov esp,ebp
pop ebp
ret 8
swap ENDP

;int partition(int arr[],int low,int high)
Partition proc
PUSH EBP
MOV EBP, ESP
PUSH EAX
PUSH EBX
PUSH ECX
PUSH EDX
PUSH EDI
PUSH ESI



; int i=(low-1) 
MOV EAX , [EBP + 12] ; METAFERW STON EAX THN TIMH TO LOW (i)
MOV EBX , EAX ; METAFERW STON EBX THN TIMH TOY LOW TO XREIAZOMAI STHN FOR (j)
DEC EAX ; MEIWSH KATA 1 (i)


;for(int j=low;j<=high-1;j++)

MOV ECX,[EBP + 16] ; PAIRNW THN TIMH TOU HIGH
DEC ECX

;int pivot=arr[high]
MOV EDX, [EBP + 8] ; O PINAKAS
INC ECX
MOV EDI, [EDX + ECX *4]  ; EIMAI TWRA STO TELEYTAIO SHMEIO TOY PINAKA
DEC ECX


JMP conditionFor ; Elegxos sunthukhs gia prvth fora
lp: 
	 
 
 MOV  ESI , [EDX + EBX *4] 

	;if(arr[j]<pivot)
	conditionIF:
				CMP ESI, EDI
				JGE TheEndIf

	INC EAX ;i++


	; swap(arr[i],arr[j])
	LEA ESI, [EDX + EBX *4] ; PAIRNW THN DIEYUTHINSH TOY ARR[J]
	PUSH ESI
	LEA  ESI , [EDX + EAX *4] ; PAIRNW THN DIEYTHINSH TOY ARR[I]
	PUSH ESI
	call swap

	TheEndIf: 
		  INC EBX  ; AUKSHSH KATA 1 STO J (j++)

conditionFor:	
			 CMP EBX , ECX
			 JLE lp

; swap(arr[i+1],arr[high]);
INC ECX
LEA ESI, [EDX + ECX *4] ; PAIRNV THN DIEYUTHINSH TOY ARR[HIGH]
DEC ECX
PUSH ESI

INC EAX
LEA ESI, [EDX + EAX *4] ; PAIRNW THN DIEYUTHYNSH TOY ARR [I+1]
PUSH ESI

CALL swap


; den kanw pop ton eax gia na metaferw thn timh toy sthn QuickSort
POP ESI
POP EDI
POP EDX
POP ECX
POP EBX
MOV ESP, EBP
POP EBP

ret 12

Partition endp


QuickSort proc
PUSH EBP
MOV EBP, ESP
PUSH ESI
PUSH EDI
PUSH EBX
PUSH ECX
PUSH EDX
PUSH EAX

;partition(arr,low,high);
MOV ESI , [EBP + 16] ; STELNV TO HIGH
MOV EDI, [EBP + 12] ; STELNW TO LOW
MOV EBX , [EBP + 8] ; STELNV TON PINAKA



;  if(low<high)
condition:
		  CMP EDI, ESI ; sugkrish low  high
		  JGE theend ; an low > = high phgaine sto theeend (petama)
PUSH ESI
PUSH EDI
PUSH EBX
call Partition


;POP EAX ; ETSI LAMBANW THN TIMH POY STELENEI H PARTITION (pi)


;quickSort(arr,low,pi-1)
DEC EAX
PUSH EAX
PUSH EDI
PUSH EBX
call QuickSort


; quickSort(arr,pi+1,high);
 PUSH ESI
 ADD EAX, 2 ; GIA NA FTASW STO PI+1 APO TO PI-1 POY HMOYN
 PUSH EAX
 PUSH EBX
 call QuickSort

theend: ; kane tipota


POP EAX
POP EDX
POP ECX
POP EBX
POP EDI
POP ESI		
MOV ESP, EBP
POP EBP


ret 12
QuickSort endp

;print(array, msg, size)
; output: message : 1,2,3,4,5 
Print proc
PUSH EBP
MOV EBP,ESP
PUSH EDX
PUSH EDI
PUSH ESI
PUSH ECX

MOV ECX, [EBP + 16] ; METAFERW STON ECX TO MHKOS TOY PINAKA
MOV EDX, [EBP + 12]; METAFERW STON EDX TO MSG
MOV EDI, [EBP + 8] ; METAFERW STON EDI TON PINAKA

;MOV EDX, OFFSET EDX
call WriteString

MOV ESI,0 ; DHMIOYRGIA COUNTER (i)
lp:
	MOV EAX,[EDI + ESI * 4]; METAFERW STON EAX TO ARR[i]
	CALL WriteInt

	MOV EDX, OFFSET space
	CALL WriteString

	INC ESI ;  i++

condition:
		CMP ESI, ECX
		JLE lp

call Crlf
call Crlf

POP ECX
POP ESI
POP EDI
POP EDX
MOV ESP, EBP
POP EBP

ret 12
Print endp


main proc

PUSH EBP
MOV EBP, ESP
MOV EAX, LENGTHOF array; pairnw to mhkos toy pinaka 
MOV [EBP - 4], EAX ; apothikeuo to mikos tou pinaka stin topiki metabliti [ebp-4]
SUB ESP, 4 ; metakinw ton esp kata 4 bytes (1 keli) 


; stelnw to n-1
MOV EBX, [EBP - 4] ; metakinhsh ston kataxwrhth ebx , to mhkos toy pinaka
DEC EBX ; meiwsh kata 1 kai etsi exw n-1
PUSH EBX ;KANVW METAKINHSH

; stelno to minima
PUSH OFFSET msgold

;stelnw array
MOV EDX, OFFSET array ; metakinhsh ston kataxwrhth edx , ton pinaka 
PUSH EDX
call Print ; ataksinomitos pinakas

; quickSort(arr,0,n-1);
MOV EBX, [EBP - 4] ; metakinhsh ston kataxwrhth ebx , to mhkos toy pinaka
DEC EBX ; meiwsh kata 1 kai etsi exw n-1
PUSH EBX ;KANVW METAKINHSH


;stelnw 0
MOV ECX,SDWORD PTR 0
PUSH ECX

;stelnw array
MOV EDX, OFFSET array ; metakinhsh ston kataxwrhth edx , ton pinaka 
PUSH EDX
call QuickSort 


; stelnw to n-1
MOV EBX, [EBP - 4] ; metakinhsh ston kataxwrhth ebx , to mhkos toy pinaka
DEC EBX ; meiwsh kata 1 kai etsi exw n-1
PUSH EBX ;KANVW METAKINHSH

; stelno to minima
PUSH OFFSET msg

;stelnw array
MOV EDX, OFFSET array ; metakinhsh ston kataxwrhth edx , ton pinaka 
PUSH EDX
call Print ; taxinomimenos pinakas


MOV ESP, EBP
POP EBP

exit
main endp
END main