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
	mov al, [asciinums]		;7
	mov ah, [asciinums+1]	;3
	mov bl, [asciinums+2]	;2
	mov bh, [asciinums+3]	;1
	mov cl, [asciinums+4]	;0
	mov ch, [asciinums+5]	;5
	mov dl, [asciinums+6]	;6
	mov dh, [asciinums+7]	;4

	mov [asciinums], cl	;0
	mov [asciinums+1], bh	;1
	mov [asciinums+2], bl	;2
	mov [asciinums+3], ah	;3
	mov [asciinums+4], dh	;4
	mov [asciinums+5], ch	;5
	mov [asciinums+6], dl	;6
	mov [asciinums+7], al	;7

    writestring msg2, lenmsg2
	writestring asciinums, lenasciinums
	writestring crlf, lencrlf

	mov	eax, 1			;terminate program
	int	0x80
