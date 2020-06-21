;--------------------------------------------------------------------
;   KEY ***** MASM VERSION *****
;
;
;   KEY.  This program will read ASCII characters from the
;   keyboard (standard input stream).  Each ASCII character will
;   be echoed to standard output stream if it is a letter, space, or
;   a period. If the input letter is lowercase, it will be printed as
;   a uppercase letter. For example the character 'a' will be
;   output as 'A', 'H' will be output as 'H' and every character that is
;   not a letter, space, or a period will be ignored.
;   Some other examples of the conversion are:
;
;       Character       Internal             Output
;       in file         representation       as
;       ------------------------------------------------------
;       A               41h                  41
;       ,               2Ch
;       z               7Ah                  5A
;
;   The program terminates when a period is read.
;
;   To use, type this command:  KEY

;   Author:   John Choi
;
;   Date:     Changes
;   09/22/18  original version
;   09/29/18  Documentations added
;---------------------------------------
         .model     small              ; 64k code and 64k data
         .8086                         ; only allow 8086 instructions
         .stack     256                ; reserve 256 bytes for the stack
;---------------------------------------
         .code
;---------------------------------------
start:                                 ; starting point
        mov ds, ax                     ; for the data segment
        mov bx, 0                      ; clear index register
;---------------------------------------
;Read from the character.
;Terminates when a period is inputted by the user.
;---------------------------------------
getloop:                               ;
        mov ah, 8                      ; read without echo
        int 21h                        ; how: set ah=8 and issue int 21h
        mov dl, al                     ; no, save the character (cl=xy)
;---------------------------------------
; If the character was a period then terminate,
; else loop to read another character.
;---------------------------------------
        mov ah, 2                      ; set up to write the character
        cmp dl, ' '                    ; if character is space
        je  print                      ; yes, loop
        cmp dl, '.'                    ; is the character a period?
        je  printPeriod                ; jump to printPeriod if yes
        cmp dl, 7Ah                    ; is the character 'z'?
        jg  getloop                    ; re run the loop if yes
        cmp dl, 61h                    ; is the character 'a'?
        jge convert                    ; convert to capital
        cmp dl, 5Ah                    ; is the character 'Z'?
        jg  getloop                    ; re run the loop if yes
        cmp dl, 41h                    ; is the character 'A'?
        jge print                      ; print the character if yes
        jmp getloop                    ; re run the loop
;---------------------------------------

;---------------------------------------
; handles the conversion from lowercase to uppercase
;---------------------------------------
convert:                               ;
        sub dl, 20h                    ; to uppercase, subtract 20h
        int 21h                        ; print
        jmp getloop                    ; re run the loop
;---------------------------------------

;---------------------------------------
; handles the printing
;---------------------------------------
print:                                 ;
        int 21h                        ; interrupt and print
        jmp getloop                    ; re run the loop
;---------------------------------------

;---------------------------------------
; handles the period input
;---------------------------------------
printPeriod:                           ;
        int 21h                        ; interrupt and print the period
        jmp exit                       ; and exit
;---------------------------------------

;---------------------------------------
; The user typed a period so terminate.
;---------------------------------------
exit:                                  ;
        mov ax,4c00h                   ; set correct exit code in ax
        int 21h                        ; int 21h will terminate program
        end start                      ; execution begins at the label start
;---------------------------------------

