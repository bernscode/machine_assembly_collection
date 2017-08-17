;;;;;;;;;;;;;;;;;;;;	MACRO DEFINITIONS	;;;;;;;;;;;;;;;;;;;;
; A macro with two parameters
; Implements the write system call
	%macro write_string 2
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
section .data
	;;;;;;;;;;;;;;;;;;Prompt for number;;;;;;;;;;;;;;;;;;;
	Prompt1	db	'Please enter a number: '	;Ask the user to enter a number
	lenPrompt1	equ	$ - Prompt1				;The length of Prompt1
	;;;;;;;;;;;;;;;;;;The End Message;;;;;;;;;;;;;;;;;;;
	theend	db	'The End'
	lentheend	equ	$ - theend
	;;;;;;;;;;;;;;;;;;Carriage Return/Line Feed;;;;;;;;;;;;;;;;;;;
	crlf db 0x0d, 0x0a
	lencrlf	equ	$ - crlf
	;;;;;;;;;;;;;;;;;;;;;Display Zero;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	showZero	db	'Zero'
	lenZero	equ	$ - showZero
	;;;;;;;;;;;;;;;;;;;;;Display One;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	showOne	db	'One'
	lenOne	equ	$ - showOne
	showTwo db 'Two'
	lenTwo equ $ - showTwo
	showThree db 'Three'
	lenThree equ $ - showThree
	showFour db 'Four'
	lenFour equ $ - showFour
	showFive db 'Five'
	lenFive equ $ - showFive
	showSix db 'Six'
	lenSix equ $ - showSix
	showSeven db 'Seven'
	lenSeven equ $ - showSeven
	showEight db 'Eight'
	lenEight equ $ - showEight
	showNine db 'Nine'
	lenNine equ $-showNine
	;;;;;;;;;;;;;;;;;;num variable;;;;;;;;;;;;;;;;;;;
	num db 0xff

;;;;;;;;;;;;;;;;;;;;	TEXT SEGMENT	;;;;;;;;;;;;;;;;;;;;
section	.text
	global _start
	_start:
	write_string crlf, lencrlf      ;output carriage return and line feed
	write_string Prompt1, lenPrompt1;User Prompt1 - 'Please enter a number: '
    read_string	num, 1             ;Read and store 1-byte of the user input
	write_string crlf, lencrlf      ;output carriage return and line feed
	mov ah, [num]					;put received character in AH register

	cmp ah, '0'						;check if 0 was entered
	jne cmp1						;if not 0 then go to check if 1 was entered
		write_string showZero, lenZero	;Display 'Zero'
		jmp _start                  ;restart program
cmp1:
	cmp ah, '1'
	jne cmp2
		write_string showOne, lenOne
		jmp _start
cmp2:
    cmp ah, '2'
    jne cmp3
        write_string showTwo, lenTwo
        jmp _start
cmp3:
    cmp ah, '3'
    jne cmp4
        write_string showThree, lenThree
        jmp _start
cmp4:
    cmp ah, '4'
    jne cmp5
        write_string showFour, lenFour
        jmp _start
cmp5:
    cmp ah, '5'
    jne cmp6
        write_string showFive, lenFive
        jmp _start
cmp6:
    cmp ah, '6'
    jne cmp7
        write_string showSix, lenSix
        jmp _start
cmp7:
    cmp ah, '7'
    jne cmp8
        write_string showSeven, lenSeven
        jmp _start
cmp8:
    cmp ah, '8'
    jne cmp9
        write_string showEight, lenEight
        jmp _start
cmp9:
    cmp ah, '9'
    jne cmp10
        write_string showNine, lenNine
        jmp _start
cmp10:
    jmp _default



	;...
	;fill in missing code to check for digit 2,3,4,5,6,7,8,9
	;...

_default:
	write_string theend, lentheend	;show 'The End'
	write_string crlf, lencrlf      ;output carriage return and line feed

	;Exit to operating system
	mov eax, 1
	mov ebx, 0
	int 0x80
;;;;;;;;;;;;;;;;;;;;	END OF PROGRAM	;;;;;;;;;;;;;;;;;;;;
