;--------------------------------------------------------------------
;
;   NEXTVAL SUBROUTINE    ***** MASM VERSION *****
;
;
;   NEXTVAL.  Find next mouse move in an array 15 by 30.
;            We can move into a position if its contents is blank ( 20h ).
;
;   Input:     Calling sequence is:
;                  x    pointer   si
;                  y    pointer   di
;                  dir  pointer   bx
;                  maze pointer   bp
;
;   Output:    x,y,dir modified in caller's data segment
;
;   To use, type this command:  NEXTVAL
;
;   Author:    John Choi, Eric McAllister
;
;   Date       Reason
;   ----       ------
; 10/22/2018   Original version
;
;---------------------------------------
         .model    small               ; 64k code and 64k data
         .8086                         ; only allow 8086 instructions
         public    nextval             ; allow extrnal programs to call
;---------------------------------------
         .data
;---------------------------------------
thirty   db 30                         ; variable constant thirty
;---------------------------------------
         .code                         ; start the code segment
;---------------------------------------
; Save any modified registers
; Calculates offset and saves it in ax
;---------------------------------------
nextval:
        push bp                        ; save bp register
        push ax                        ; save ax register
        push cx                        ; save cx register
        mov ax, 0                      ; This is
        mov cl, [si]                   ; part of
        mov ch, [di]                   ; offset
        mov al, ch                     ; calculation
        sub al, 1                      ; code
;---------------------------------------
; Finalizes the step to calculating
; result for offset
;---------------------------------------
        mul [thirty]                   ; multiply y-1 to 30
        mov ch, 0                      ; get cx ready for addition
        sub al, 1                      ; handle the memory access issue
        add ax, cx                     ; add ch to offset
        add bp, ax                     ; add bp by the offset
;---------------------------------------
; This part determines behaviors for
; current direction
;---------------------------------------
        cmp byte ptr[bx], 1            ; If direction is 1
        je testn                       ; jump to testn
        cmp byte ptr[bx], 2            ; If direction is 2
        je teste                       ; jump to teste
        cmp byte ptr[bx], 3            ; If direction is 3
        je tests                       ; jump to tests
        cmp byte ptr[bx], 4            ; If direction is 4
        je testw                       ; jump to testw
;---------------------------------------
; Code to make 1 move in the maze
; Handles north movement
;---------------------------------------
testn:
        cmp byte ptr ds:[bp - 30], 20h ; if location is empty
        jne teste                      ; if not empty space, goto teste
        sub byte ptr[di], 1            ; decrement y
        mov byte ptr[bx], 4            ; set direction of travel to north
        jmp exit                       ; jump to exit
;---------------------------------------
; Handles east movement
;---------------------------------------
teste:
        cmp byte ptr ds:[bp + 1], 20h  ; if not empty space
        jne tests                      ; goto tests
        add byte ptr[si], 1            ; increment x
        mov byte ptr[bx], 1            ; set direction of travel to east
        jmp exit                       ; jump to exit
;---------------------------------------
; Handles south movement
;---------------------------------------
tests:
        cmp byte ptr ds:[bp + 30], 20h ; if not empty space
        jne testw                      ; goto testw
        add byte ptr[di], 1            ; increment y
        mov byte ptr[bx], 2            ; set direction of travel to south
        jmp exit                       ; jump to exit
;---------------------------------------
; Handles west movement
;---------------------------------------
testw:
        cmp byte ptr ds:[bp - 1], 20h  ; if not empty space
        jne testn                      ; goto testn
        sub byte ptr[si], 1            ; decrement x value
        mov byte ptr[bx], 3            ; set direction of travel to west
        jmp exit                       ; jump to exit
;---------------------------------------
; Restore registers and return
;---------------------------------------
exit:
        pop cx                         ; restore cx register
        pop ax                         ; restore ax register
        pop bp                         ; restore bp register
        ret                            ; return
;---------------------------------------
; End the subroutine and return to main program
;---------------------------------------
        end                            ; finish the program
;---------------------------------------
