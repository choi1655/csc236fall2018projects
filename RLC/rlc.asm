;---------------------------------------------------------------------
;  Program:      Run Length Coding
;
;  Function:     Decompresses 1 dimensional run lengths
;                This subroutine links with a C main program
;
;                Add your additional functional comments
;
;  Owner:       John Choi, Eric McAllister
;
;  Changes:
;  Date          Reason
;  ----          ------
;  11/05/2018    Original version ... coded to spec design
;---------------------------------------------------------------------
         .model    small
         .8086
         public    _rlc
;---------------------------------------
         .data                         ; start the data segment
;---------------------------------------
pels_left       db      80             ; data segment
boolean         db      2
hold            dw      ?
;---------------------------------------
         .code                         ; start the code segnment
;---------------------------------------
; Save the registers ... 'C' requires (bp,si,di)
; Access the input and output lists
;---------------------------------------
_rlc:                                   ;
        push      bp                    ; save 'C' register
        mov       bp,sp                 ; set bp to point to stack
        push      si                    ; save 'C' register
        push      di                    ; save 'C' register
        mov       si,[bp+4]             ; si points to the input compressed data
        mov       di,[bp+6]             ; di points to the empty output buffer
        mov       dx, 20DBh             ; values for printing colors
;---------------------------------------
; Actual starting point of the subroutine.
; Gets left digit and right digits out of byte.
;---------------------------------------
        mov     ax, ds
        mov     es, ax
        cld                             ; execute so indices increase

start:                                  ;
        mov     bx, 2                   ; boolean value to make sure we run loop 2 times
        mov     cl, 4                   ; bit shift value 4 bits to get High/Low digit
        ;cld                             ; execute so indices increase

        lodsb                           ; move si into al and inc si
        cmp     al, 00h                 ; if value is 0,
        je      _exit                   ; exit subroutine
        mov     ah, al                  ; copy data into another reg
        shr     al, cl                  ; shift bits to get high bit
        and     ah, 0Fh                 ; mask to get low bits
;---------------------------------------
; Check pels_left is 0.
; If it is, reset it to 80.
; Set color to white.
;---------------------------------------
_loop:                                  ;
        cmp     bx, 0                   ; if boolean value is 0
        je      start                   ; we stop running loop
        cmp     [pels_left], 0          ; if not, see if pels_left is 0
        jne     over                    ; if not, jump to over
        mov     [pels_left], 80         ; if 0, reset pels_left to 80
        mov     dx, 20DBh               ; and reset current color
;---------------------------------------
; Check if ah is 15.
; Print the rest of the pels as white for F input.
;---------------------------------------
over:                                   ;
        cmp     al, 15                  ; see if current digit is Fh
        jne     skip                    ; if not, skip to label "skip"
        mov     dx, 20DBh               ; if F, reset current color
        mov     cx, word ptr[pels_left] ; set cx to pels_left for looping
        jmp     cmpcx                   ; and jump to cmpcx
;---------------------------------------
; Label that gets called if current digit
; is not F.
;---------------------------------------
skip:                                   ;
        mov     byte ptr[hold], al      ; set current digit to variable "hold"
        mov     cx, [hold]              ; set cx to the value of hold - have to do this because of size
;---------------------------------------
; Gets called to skip the "skip" block of
; the code.
;---------------------------------------
cmpcx:                                  ;
        cmp     cl, 0                   ; if the value of cl is 0
        je      cxzero                  ; jump to cxzero
;---------------------------------------
; Block of the code that gets called to clear
; the high bit of cx register.
;---------------------------------------
clear:                                  ;
        mov     ch, 0                   ; clear the high bit of cx register
;---------------------------------------
; Block of code that handles the while loop.
; Writes to the output stream until pels_left is 0.
;---------------------------------------
x:                                      ;
        mov     [di], dh                ; while loop
        inc     di                      ; that writes to output stream, di and increases di
        dec     pels_left               ; and decrement pels_left
        loop    x                       ; and loop until cx is 0

        ; mov       al, dh
        ; sub       [pels_left], al
        ; rep       stosb
;---------------------------------------
; Block of code that handles swapping of ax
; register and dx register.
; Ax register holds the upper digit and lower digit
; in a byte and dx register holds the current color
;---------------------------------------
cxzero:                                 ;
        xchg    al, ah                  ; swap values to read different digit in byte
        xchg    dl, dh                  ; swap colors
;loop with new values one more time
        dec     bx                      ; decrement boolean value to ensure loop runs 2 times
        jmp     _loop                   ; re run loop
;---------------------------------------
; Restore registers and return
;---------------------------------------
_exit:                                  ;
        pop       di                    ; restore 'C' register
        pop       si                    ; restore 'C' register
        pop       bp                    ; restore 'C' register
        ret                             ; return
;---------------------------------------
        end                             ; end program

