.286
.model	tiny
.stack
.code
	org	100h
start:	jmp	main
vold	dd	?

handl	proc	far
	push	cs
	pop	ds
	pusha
;====================================	
	mov	ah,6
	mov	dl,7                   ;������� DOS:������ �����
	int	21h
;====================================
	mov	ah,07h                 ;�������� ������ ���������� ��������� ��������� ����
	int	1ah
;====================================
	lds	dx,vold
	mov	ah,25h
	mov	al,4ah                 ;���������� ������� �������� ����������
	int	21h
	popa
;====================================
	mov	al,20h
	out	0ah,al                 ;������������� �� ������, ���� �������� �����
	out	20h,al
	iret
;====================================
fin	equ	$
handl	endp
;====================================
main:	push	cs
	pop	ds
	pusha
;====================================
	mov	ah,07h                 ;��������
	int	1ah
;====================================
	mov	ch,00100011b
	mov	cl,01000101b
	mov	dh,00110101b           ;����� ����
	mov	ah,06h
	int	1ah
	jc	erro
;====================================
	mov	ah,35h
	mov	al,4ah
	int	21h
	mov	word ptr vold,bx       ;���������� ������ ������� ��������� ����������
	mov	word ptr vold+2,es
	push	ds
;====================================
	mov	dx,offset handl
	mov	al,4ah
	mov	ah,25h                 ;����� ��������
	int	21h       
;====================================
	pop	ds
	popa
	lea	dx,fin
	int	27h
;====================================
erro:	mov	bh,0
	mov	cx,3
	mov	al,'e'                 ;���� ����������� ��� �������
	mov	ah,0ah
	int	10h
	ret
	end	start