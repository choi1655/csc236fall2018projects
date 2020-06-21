;---------------------------------------------------------------------
;
;  Program:      Run Length Coding Driver
;
;  Function:     Test driver for the rlc subroutine
;
;  Owner:        Dana lasher
;
;  Instructions: Start DOSBox and change to the RLC directory
;  1. Assemble the test driver           ->  ml /c /Zi /Fl testdrvr.asm
;  2. Assemble your rlc code             ->  ml /c /Zi /Fl rlc.asm
;  3. Link the test driver and rlc code  ->  link /CO testdrvr rlc;
;  4. Get the CV configuration file      ->  cvset
;  5. Start CV                           ->  cv testdrvr
;  6. Step through the code              ->  use F8 to step through the code
;
;  Changes:
;  Date          Reason
;  ----          ------
;  05/17/2017    Original version ... coded to spec design
;
;
;---------------------------------------------------------------------
         .model    small               ;4 64KB segments
         .8086                         ;only allow 8086 instructions
         .stack    256                 ;create a 236 byte stack
         extrn     _rlc:proc           ;allow linker to access students code


        .data
;---------------------------------------------------------------------
;        This test case draws a staircase     X
;                                             XX
;        - test1  is the compressed data      XXX
;        - output is the decompressed data    XXXX
;                                             XXXXX
;                                             XXXXXX
;                                             XXXXXXX
;                                             XXXXXXXX
;                                             XXXXXXXXX
;                                             XXXXXXXXXX
;---------------------------------------------------------------------
test1    db    001h, 090h, 0f0h, 028h, 00fh, 003h, 070h, 0f0h, 046h, 00fh
         db    005h, 050h, 0f0h, 064h, 00fh, 007h, 030h, 0f0h, 082h, 00fh
         db    009h, 010h, 0f0h, 0afh, 00


output   db        1024 dup('$')
;---------------------------------------------------------------------


;---------------------------------------------------------------------
;        Initialize the ds register
;---------------------------------------------------------------------
         .code                         ;
start:                                 ;
         mov       ax,@data            ;initialize the
         mov       ds,ax               ;ds register
;---------------------------------------------------------------------
;        Call the rlc subroutine
;        In C the calling sequence is ... rlc (test1, output);
;---------------------------------------------------------------------
         mov       ax,offset output    ;push the address of
         push      ax                  ; the output buffer
         mov       ax,offset test1     ;push the address of
         push      ax                  ; the input test case buffer
         call      _rlc                ;call the rlc subroutine
   ;------------------------------------
   ; Your rlc code will now be executed
   ;------------------------------------
;---------------------------------------------------------------------
;        Display the decompressed data
;---------------------------------------------------------------------
         mov       dx,offset output    ;point to the output buffer
         mov       ah,9                ;get the DOS string write command
         int       21h                 ;display the output buffer
;---------------------------------------------------------------------
;        Terminate
;---------------------------------------------------------------------
         mov       ax,4c00h            ;get the DOS code to terminate
         int       21h                 ;terminate the program
         end       start               ;the first instruction is start:
