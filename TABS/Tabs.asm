;--------------------------------------------------------------------
;
;   TABS ***** MASM VERSION *****
;
;
;   TABS.  This program reads in a file through standard input and
;   generates columns based on the user argument, 10 spaces if none
;   inputted. It will ignore characters from 00h to 1Fh, except 09h, 0Ah,
;   0Dh, and 1Ah. It will read all characters from 20h to 7Fh. All lines will
;   terminate with DOS carriage return and line feed pair (0D0Ah). Files will
;   terminate with DOS End of File (EOF) character (1Ah). The EOF will only appear
;   after a DOS carriage return and line feed pair (0D0Ah) or as the only
;   character in a null file.
;
;   To use, type this command:  TABS
;
;   Author:    John Choi
;
;   Date       Reason
;   ----       ------
; 10/09/2018   Original version
;
;---------------------------------------
         .model small                  ; 64k data and 64k code
         .8086                         ; only allow 8086 instructions
         .stack 256                    ; stack size is 256 bytes
;---------------------------------------
         .data
;---------------------------------------
counter   db 0                         ; Initialize character counter to 0
argument  db 10                        ; initialize default spacing to 10
;---------------------------------------
         .code
;---------------------------------------
; Establish addressability to the data segment.
; Initialize the work register.
; - bx is cleared to zero and will be used as
;   an index register in the conversion process
;---------------------------------------
start:
        mov ax, @data                  ; establish addressability
        mov ds, ax                     ; for the data segment
        mov bx, 0                      ; clear index register
;---------------------------------------
; Try to read from standard input.
; - program terminates if it hits EOF.
;---------------------------------------
        cmp byte ptr es:[80h], 0       ; access the CLP count 80h bytes into the extra segment
        je  getloop                    ; no parameter ... continue with the program
        mov al, byte ptr es:[82h]      ; parameter entered ... load al with the CLP character
        mov [argument], al             ; initialize argument with input value
        sub [argument], 48             ; subtract 48 to get the correct number
;---------------------------------------
; Point where the program keeps looping to
; get a new character
;---------------------------------------
getloop:
        mov ah, 8                      ; read from standard input
        int 21h                        ; set ah=8 and issue 21h and saves
        mov dl, al                     ; input character to al
;---------------------------------------
; If the character was a tab, replace with spaces.
; else, loop to read another character.
;---------------------------------------
        mov ah, 2                      ; set up to write the character
        cmp dl, 0Ah                    ; is the character line feed?
        je  linechange                 ; yes, jump to linechange
;---------------------------------------
; Point where code comes back from linechange
;---------------------------------------
return:
        cmp dl, 1Ah                    ; if character is EOF
        je  terminate                  ; jump to terminate
        mov ch, [counter]              ; assign counter to ch
        mov cl, [argument]             ; assign argument to cl
        cmp ch, cl                     ; compare
        jne notTen                     ; jump if false
        mov [counter], 0               ; reset to 0 if 10
;---------------------------------------
; if statement where the program jumps to
; if ch is not equal to cl
;---------------------------------------
notTen:
        inc [counter]                  ; add one to the character counter
        cmp dl, 09h                    ; if the character was tab
        je  isTab                      ; yes, jump
        jmp print                      ; print
;---------------------------------------
; Block where program uses to print the character
;---------------------------------------
print:
        int 21h                        ; print character
        jmp getloop                    ; re run the program
;---------------------------------------
; Block of code where the program comes to
; if the character is a tab
;---------------------------------------
isTab:
        mov dl, ' '                    ; assign space to print
        mov ch, [counter]              ; assign counter to dh
        mov cl, [argument]             ; assign argument to dl
        sub ch, cl                     ; subtract argument from counter: 4-10=-6
        neg ch                         ; set counter to 6: 0-(-6) = 6
        mov cl, ch                     ; set counter to cx for loop
        mov [counter], 0               ; reset counter to 0
        inc cl                         ; to adjust cl value
;---------------------------------------
; For loop that runs for the number of spaces
; it needs to close the 10 character gap
;---------------------------------------
repit:
        int 21h                        ; print space
        mov dl, ' '                    ; reassign dl to space
        dec cl                         ; loop until counter is 0
        cmp cl, 0                      ; if cl is not 0
        jne repit                      ; repeat
        jmp getloop                    ; re run the program
;---------------------------------------
; Block of code that handles the line change
;---------------------------------------
linechange:
        mov [counter], -1              ; reset the character counter
        jmp return                     ; return to previous location
;---------------------------------------
; The program read a EOF
;---------------------------------------
terminate:
        int 21h
        mov ax, 4c00h                  ; set correct exit code in ax
        mov dl, 1Ah
        mov dh, dl
        int 21h
        end start                      ; execution begins at the label start
;---------------------------------------
