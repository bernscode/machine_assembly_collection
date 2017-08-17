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
; A macro with two parameters
; Implements the sys_read call
	%macro read_string 2
		mov eax, 3  ;sys_write system call number
		mov ebx, 2  ;file descriptor std_in
		mov ecx, %1 ;variable/array to hold data, pass by reference in param 1
		mov edx, %2 ;number of bytes to read passed by value in param 2
		int 0x80
	%endmacro

;;;;;;;;;;;;;;;;;;;;	DATA SEGMENT	;;;;;;;;;;;;;;;;;;;;
section	.data
msg1 db 'Here are the elements: '
lenmsg1 equ $-msg1
msg2 db 'Enter a number to search for: '
lenmsg2 equ $-msg2
msg3 db 'The target value was found at index '
lenmsg3 equ $-msg3
msg4 db 'The target value was NOT found...',0x0a, 0x0d
lenmsg4 equ $-msg4
asciinums db '7','3','2','1','0','5','6','4','8','9'
lenasciinums equ $-asciinums
crlf db 0x0d, 0x0a
lencrlf	equ	$ - crlf
target db 0x00
targetlocation db 0x30

section	.text
	global _start
_start:
    writestring msg1, lenmsg1
	writestring asciinums, lenasciinums
	writestring crlf, lencrlf
    writestring msg2, lenmsg2
	read_string target, 1
	writestring crlf, lencrlf
	mov eax, asciinums					;eax holds base address
	mov ecx, 0					;ecx is index register
getNextElement:
	mov bl, [eax+ecx]				;copy value from asciinums into an 8-bit register
	cmp bl, [target]					;compare the 8-bit register to target value
	je found					;jump if equal to the found label
	inc ecx					;increment index register
	cmp ecx, 10h					;compare index register to decimal 10
	jne getNextElement					;if index register not equal to 10 go to getNextElement

	writestring msg4, lenmsg4
	jmp terminate
found:
	add [targetlocation], ecx
	writestring msg3, lenmsg3
	writestring targetlocation, 1
	writestring crlf, lencrlf
terminate:
	mov	eax, 1			;terminate program
	int	0x80
