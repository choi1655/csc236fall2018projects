;--------------------------------------------------------------------
;   LINKHLL ***** MASM VERSION *****
;
;
;   LINKHLL.  The linkhll subroutine is a C/C++ subroutine
;   and will be linked with a C/C++ main program. The linkhll
;   subroutine will be passed four unsigned words on the stack
;   (these are passed by value). Linkhll is to find the two largest
;   unsigned values and multiply them creating a 32 bit unsigned
;   product.
;
;
;       Input:
;             v1, v2, v3, v4 16-bit unsigned values from driver program.
;       Output:
;             Product of max value and min value in 32-bit, dx:ax pair
;             register
;
;   Author:   John Choi
;
;   Date:     Changes
;   09/22/18  original version
;---------------------------------------
         .model     small              ; 64k code and 64k data
         .8086                         ; only allow 8086 instructions
         public     _linkhll           ; allow external programs to call
;---------------------------------------
         .code                         ; start the code segment
;---------------------------------------
; Starting point of this subroutine.
; Save bp register and initialize ax and bx values
; to param1 and param2
;---------------------------------------
_linkhll:
        push bp                        ; save caller's bp
        mov  bp, sp                    ; init bp so we can get the arguments
        mov  ax, [bp + 4]              ; assign param1 to max
        mov  bx, [bp + 6]              ; assign param2 to secondMax
        cmp  ax, bx                    ; if ax is less than bx
        ja   firstCmp                  ; jump to else statement
        mov  ax, [bp + 6]              ; swap if
        mov  bx, [bp + 4]              ; else
;---------------------------------------
; Portion of the code where first comparison
; happens.
; Compares if param3 is greater than ax, first maximum
;---------------------------------------
firstCmp:
        cmp  [bp + 8], ax              ; if param3 is greater than ax
        jb   secondCmp                 ; (if param3 is less than ax)
        mov  bx, ax                    ; go here and assign bx to ax and
        mov  ax, [bp + 8]              ; assign ax to param3
        jmp  fifthCmp                  ; compare param4 if param4 is greater than ax
;---------------------------------------
; Portion of the code where second comparison
; happens.
; This is the else if part of the if-else
; statement.
;---------------------------------------
secondCmp:                             ; (go here)
        cmp  [bp + 8], ax              ; else if param3 is less than ax and
        ja   fifthCmp                  ; (if param3 is greater than ax)
        cmp  [bp + 8], bx              ; param3 is greater than bx
        jb   fifthCmp                  ; <if param3 is less than bx>
        mov  bx, [bp + 8]              ; assign param3 to bx
;---------------------------------------
; Portion of the code where if-else statement
; happens.
; This part handles the case where param3 is
; less than bx.
;---------------------------------------
fifthCmp:                              ; (<go here>)
        cmp  [bp + 10], ax             ; if param4 is greater than ax
        jb   seventhCmp                ; (if param4 is less than ax)
        mov  bx, ax                    ; go here and assign bx to ax and
        mov  ax, [bp + 10]             ; assign ax to param4
        jmp  calculate                 ; jump to calculate if param4 is greater than ax
;---------------------------------------
; Portion of the code where if-else statement
; happens.
; This part handles the case where
; param4 is greater than ax.
; Contains else statement.
;---------------------------------------
seventhCmp:                            ; (go here)
        cmp  [bp + 10], ax             ; else if param4 is less than ax and
        ja   calculate                 ; (if param4 is greater than ax)
        cmp  [bp + 10], bx             ; param4 is greater than bx
        jb   calculate                 ; <if param4 is less than bx>
        mov  bx, [bp + 10]             ; assign bx to param4
;---------------------------------------
; Portion of the code where the actual
; calculation happens.
; AX register is first max value, BX register
; holds the second max value.
; Stores the result in dx:ax register
;---------------------------------------
calculate:                             ; (<go here>)
        mul  bx                        ; multiply max and min and store in dx:ax
;---------------------------------------
; Restore registers and return.
;---------------------------------------
exit:
        pop  bp                        ; restore bp
        ret                            ; return
;---------------------------------------
; End the subroutine and return to main program
;---------------------------------------
        end                            ; finish the program
;---------------------------------------
