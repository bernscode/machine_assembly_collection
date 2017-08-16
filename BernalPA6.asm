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
	;;;;;;;;;;;;;;;;;;Prompt for numbers;;;;;;;;;;;;;;;;;;;
	Prompt1	db	'Enter numeric digits: '
	lenPrompt1	equ	$ - Prompt1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	msg1	db	'The sum of digits < 9'
	lenmsg1	equ	$ - msg1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	msg2	db	'The sum of digits is: '
	lenmsg2	equ	$ - msg2
	;;;;;;;;;;;;;;;;;;Insert carriage return and line feed;;;;;;;;;;;;;;;;;;;
	crlf db 0x0d, 0x0a
	lencrlf	equ	$ - crlf				;The length of Prompt2
	;;;;;;;;;;;;;;;;;;num variable;;;;;;;;;;;;;;;;;;;
	num db 0xff
	;;;;;;;;;;;;;;;;;;sum variable;;;;;;;;;;;;;;;;;;;
	sum db 0x00

;;;;;;;;;;;;;;;;;;;;	TEXT SEGMENT	;;;;;;;;;;;;;;;;;;;;
section	.text
	global _start
	_start:
	write_string crlf, lencrlf
	write_string Prompt1, lenPrompt1
	dowhile:
		read_string num, 1			;read a character from standard input to num variable
		mov al, [num]					;put num variable value into register AL
		cmp al, 10					;compare the value in AL to constant value 10 (enter key)
		je EnterKeyPressed					;jump if equal to the label EnterKeyPressed
		and al, 0x0f					;remove ascii encoding from AL by using bitwise AND
		add [sum], al					;add AL to sum variable
		;write_string crlf, lencrlf					;output a newline to standard output
		jmp dowhile					;jump to the dowhile label
    EnterKeyPressed:
		mov al, [sum]					;put sum variable value into register AL
		cmp al, 9					;compare AL to constant value 9
		jle sumle9					;jump if less or equal to label sumle9
		write_string crlf, lencrlf					;write newline to standard output
		write_string msg1, lenmsg1					;write msg1 to standard output
		write_string crlf, lencrlf					;write newline to standard output
		jmp terminate			;jump to the terminate label
    sumle9:
        write_string crlf, lencrlf
		write_string msg2, lenmsg2					;write msg2 to standard output
		mov al, [sum]					;put sum variable value into register AL
		or al, 0x30					;put ascii encoding onto the value in register AL
		mov [sum], al					;put register AL value into sum variable
		write_string sum, 1			;write sum to standard output
		write_string crlf, lencrlf					;write newline to standard output
	terminate:
	;Exit to operating system
	mov eax, 1
	mov ebx, 0
	int 0x80
;;;;;;;;;;;;;;;;;;;;	END OF PROGRAM	;;;;;;;;;;;;;;;;;;;;
