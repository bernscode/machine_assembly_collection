
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
	;;;;;;;;;;;;;;;;;;Prompt for 1st number;;;;;;;;;;;;;;;;;;;
	Prompt1	db	'Please enter a number: '	;Ask the user to enter a number
	lenPrompt1	equ	$ - Prompt1				;The length of Prompt1
	;;;;;;;;;;;;;;;;;;Prompt for 2nd number;;;;;;;;;;;;;;;;;;;
	Prompt2	db	'Please enter another number: '	;Ask the user to enter a number
	lenPrompt2	equ	$ - Prompt2				;The length of Prompt2
	;;;;;;;;;;;;;;;;;;Insert carriage return and line feed;;;;;;;;;;;;;;;;;;;
	Prompt3 db 'Please enter third number: '
	lenPrompt3 equ $ - Prompt3
	crlf db 0x0d, 0x0a
	lencrlf	equ	$ - crlf				;The length of Prompt2
	;;;;;;;;;;;;;;;;;;Output Sum;;;;;;;;;;;;;;;;;;;
	dispSum	db	'The sum of the entered numbers is: '		;Message for sum
	lenDispSum	equ	$ - dispSum				;Length of Message for echo
	;;;;;;;;;;;;;;;;;;num1 variable;;;;;;;;;;;;;;;;;;;
	num1 db 0xff
	;;;;;;;;;;;;;;;;;;num2 variable;;;;;;;;;;;;;;;;;;;
	num2 db 0xff
	;;;;;;;;;;;;;;;;;;num3 variable;;;;;;;;;;;;;;;;;;;
	num3 db 0xff
	;;;;;;;;;;;;;;;;;;sum variable;;;;;;;;;;;;;;;;;;;
	sum db 0xff
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;	TEXT SEGMENT	;;;;;;;;;;;;;;;;;;;;
section	.text
	global _start
	_start:
	write_string Prompt1, lenPrompt1;User Prompt1 - 'Please enter a number: '
    read_string	num1, 1             ;Read and store 1-byte of the user input
	write_string crlf, lencrlf      ;output carriage return and line feed

	write_string Prompt2, lenPrompt2;User Prompt2 - 'Please enter another number: '
    read_string	num2, 1             ;Read and store 1-byte of the user input
	write_string crlf, lencrlf      ;output carriage return and line feed

	write_string Prompt3, lenPrompt3
	read_string num3, 1
	write_string crlf, lencrlf

    mov bl, [num1]  ;put num1 value into bl register
    and bl, 0x0F    ;remove ascii encoding from num1 value
    mov al, [num2]  ;put num2 value into al register
    and al, 0x0F    ;remove ascii encoding num2 value
    add al, bl      ;perform num1 + num2, sum will be in al register
    mov bl, [num3]
    and bl, 0x0F
    add al,bl
    or al, 0x30     ;put ascii encoding on sum
    mov [sum], al   ;put ascii encoded sum into sum variable


	write_string dispSum, lenDispSum;Announce sum output message
	write_string sum, 1            ;output sum
	write_string crlf, lencrlf      ;output carriage return and line feed

	;Exit to operating system
	mov eax, 1
	mov ebx, 0
	int 0x80
;;;;;;;;;;;;;;;;;;;;	END OF PROGRAM	;;;;;;;;;;;;;;;;;;;;
