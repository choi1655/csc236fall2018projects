;---------------------------------------------------------------------
; File:     armkey.s
;
; Function: The program then a reads a line of ASCII text with printable
;           characters and control characters (00h-7Fh) from the file key.in into
;           an input string. The read string ARM SWI will remove any end of line
;           indication or characters and replace them with a single
;           binary 0. If there are no more lines the read string ARM SWI
;           will return a count of zero for the number of bytes read.
;
; Author:   John Choi, Chang Lee
;
; Changes:  Date        Reason
;           ----------------------------------------------------------
;           11/11/2018  Original version
;           11/12/2018  Fix the logic for better efficiency
;---------------------------------------------------------------------

;---------------------------------------------------------------------
; Software Interrupt Values
;---------------------------------------------------------------------
				.equ SWI_Open, 0x66                                         ; Open a file
        .equ SWI_Close, 0x68																				; Close a file
        .equ SWI_PrStr, 0x69																				; Write a null-ending string
        .equ SWI_RdStr, 0x6a																				; Read a string and terminate with null
        .equ SWI_Exit, 0x11																					; Stop execution
;---------------------------------------------------------------------
				.global _start
        .text
;---------------------------------------------------------------------
; Open input file
; - r0 points to the file name
; - r1 0 for input
; - the open swi is 66h
; - after the open r0 will have the file handle
;---------------------------------------------------------------------
_start:                                                             ;
        ldr r0, =InFileName                                         ; r0 points to the input file
        ldr r1, =0                                                  ; r1 = 0 specifies the file is input
        swi SWI_Open                                                ; open the file ... r0 will be the file handle
        ldr r1, =InFileHandle                                       ; r1 points to handle location
        str r0, [r1]                                                ; store the file handle
;---------------------------------------------------------------------

;---------------------------------------------------------------------
; Open output file
; - r0 poins to the file name
; - r1 1 for output
; - the open swi is 66h
; - after the open r0 will have the file handle
;---------------------------------------------------------------------
        ldr r0, =OutFileName                                        ; r0 points to the output file
        ldr r1, =1                                                  ; r1 = 1 specifies the file is output
        swi SWI_Open                                                ; open the file ... r0 will be the file handle
        ldr r1, =OutFileHandle                                      ; r1 points to the handle location
        str r0, [r1]                                                ; store the file handle
;---------------------------------------------------------------------

;---------------------------------------------------------------------
; read a string from the input file
; - r0 contains the file handle
; - r1 points to the input string buffer
; - r2 contains the max number of characters to read
; - the read swi is 6ah
; - the input string will be terminated with 0
;---------------------------------------------------------------------
read:                                                               ;
        ldr r0, =InFileHandle                                       ; r0 points to the input file handle
        ldr r0, [r0]                                                ; r0 has the input file handle
        ldr r1, =InString                                           ; r1 points to the input string
        ldr r2, =80                                                 ; allocate 80 bytes for single string
        swi SWI_RdStr                                               ; read a string from the input file
				cmp r0, #00
				beq _exit
;---------------------------------------------------------------------
; Store pointers to input string and output string
;---------------------------------------------------------------------
        ldr r0, =InString                                           ; r0 points to the input string
        ldr r1, =OutString                                          ; r1 points to the output string
;---------------------------------------------------------------------
; Continue getting single string/line from the input file until
; it hits eof
;---------------------------------------------------------------------
loop:
			  ldrb r3, [r0], #1                                           ; store whats in r0 to r3 and increment pointer
;---------------------------------------------------------------------
; filter the character using substraction to check it is upper case alphabet or not.
;---------------------------------------------------------------------
cal:
			 	 cmp  r3, #0x5A                                             ;compare input chacter with 5Ah, 'Z' in acii
     	   ble keep                                                   ;if character is less or equal to 'Z', jump to keep.
     	   sub  r3, r3, #0x20                                         ;Substract 20h from the character so lower case can become uppercase
     	   bal cal                                                    ;Once subtraction is done, back to check so that I do not need to write another instruction
;---------------------------------------------------------------------
; This checks special characters besides alphabet, blank, null, and check alphabet at the end
;---------------------------------------------------------------------
keep:
			   cmp r3, #0x20                                              ;compare character if it's 20h which is space in ascii
			 	 beq buffer                                                 ;If a character is space, jump to buffer which is a section to fill the buffer
         cmp r3, #0x00                                              ;compare character if it's 00h which is period in ascii
         beq buffer                                                 ;If a character is 00, jump to buffer which is a section to fill the buffer
         cmp r3, #0x41                                              ;compare character if it's 41h which is A in ascii
         bge buffer                                                 ;If a character is bigger than or equal to 41h, jump to print which is a section to fill the buffer
         bal loop                                                   ;otherwise check another character
;---------------------------------------------------------------------
; At this point, letter is valid so store it to the output string
;---------------------------------------------------------------------
buffer:
				strb r3, [r1], #1																						; Store it to the output string
        cmp r3, #0x00																								; Is it end of file signal?
        bne loop																										; If not, get another letter
;---------------------------------------------------------------------
; Write the outputs string
;---------------------------------------------------------------------
_write:																															;
        ldr r0, =OutFileHandle																			; r0 points to the output file handle
        ldr r0, [r0]																								; r0 has the output file handle
        ldr r1, =OutString																					; r1 points to the output string
				swi SWI_PrStr																								; write the null terminated string
        ldr r1, =CRLF																								; load CRLF to r1
        swi SWI_PrStr																								; print CRLF
        bal read																										; read another line/string
;---------------------------------------------------------------------
; Close input and output files
; Terminate the program
;---------------------------------------------------------------------
_exit:																														  ;
        ldr r0, =InFileHandle																				; r0 points to the input file handle
        ldr r0, [r0]																								; r0 has the input file handle
        swi SWI_Close																								; close the file
																																		;
        ldr r0, =OutFileHandle																			; r0 points to the output file handle
        ldr r0, [r0]																								; r0 has the output file handle
        swi SWI_Close																								; close the file
																																		;
        swi SWI_Exit																								; terminate the program

        .data
;---------------------------------------------------------------------
InFileHandle: .skip 4																								; 4 byte field to hold the input file handle
OutFileHandle: .skip 4																							; 4 byte field to hold the output file handle
InFileName: .asciz "KEY.IN"																					; Input file name, null terminated
InString: .skip 128																									; reserve 128 byte string for the input
OutString: .skip 128																								; reserve 128 byte string for the output
CRLF: .byte 13, 10, 0																								; CR LF
OutFileName: .asciz "KEY.OUT"																				; Output file name, null terminated
;---------------------------------------------------------------------

				.end
