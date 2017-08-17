;;;;;;;;;;;;;;;;;;;;	MACRO DEFINITIONS	;;;;;;;;;;;;;;;;;;;;
; A macro with two parameters
; Implements the write system call
	%macro writestring 2
		mov eax, 4  ;sys_write system call number
		mov ebx, 1  ;file descriptor std_out
		mov ecx, %1 ;message to write from parameter 1
		mov edx, %2 ;message length from parameter 2
		int 0x80
	%endmacro

;;;;;;;;;;;;;;;;;;;;	DATA SEGMENT	;;;;;;;;;;;;;;;;;;;;
section	.data
msg1 db 'Before sorting: '
lenmsg1 equ $-msg1
msg2 db 'After sorting: '
lenmsg2 equ $-msg2
asciinums db '7','3','2','1','0','5','6','4','8','9'
lenasciinums equ $-asciinums
crlf db 0x0d, 0x0a
lencrlf	equ	$ - crlf

section	.text
	global _start
_start:
    writestring msg1, lenmsg1
	writestring asciinums, lenasciinums
	writestring crlf, lencrlf
label2:
    mov cl, 09H
	mov esi, asciinums
label1:
    mov al, [esi]
    mov bl, [esi+1]
    cmp al, bl
	jl down
	mov dl, [esi+1]
	mov dh, [esi]
	mov [esi], dl
	mov [esi+1], dh
down:
	inc esi
    dec cl
    jnz label1
    dec ch
    jnz label2
    writestring msg2, lenmsg2
	writestring asciinums, lenasciinums
	writestring crlf, lencrlf

	mov	eax, 1			;terminate program
	int	0x80
