;*                       McMaster University                         *
;*********************************************************************               
;*                      2DP4 Microcontrollers                        *
;*                            Tutorial 4                             *
;*                           Jan 31, 2016                            *
;*********************************************************************
;*********************************************************************
;*                       Tutorial 4 Companion Code                         
; BEFORE YOU START!!!!!!!!!!!!! READ THIS!!!!!!!!!!!!!!!!
;
; Read Tutorial 4
; The memory cells used will not correspond to the tutorial
; This is due to setup overhead and lighting the heartbeat LED
; This code does not contain any I/O beyond heatbeat LED
; Challenge 3/4 handle input/ output on the Esduino
;
; Follow along using Tutorial 4 to trace the code as it executes                                                          
;*********************************************************************
;*********************************************************************
;*                            References                             
;* Tutorial 4                                                              
;* HCS12/9S12 Textbook               
;* Instruction Set                                                    
;*                                                                   
;*********************************************************************
;*********************************************************************
;*                   Setup Code (Don't Change)                       
;*********************************************************************
; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry                  ; for absolute assembly: mark this as application entry point

; Include derivative-specific definitions 
		        INCLUDE 'derivative.inc' 
		        
ROMStart    EQU  $1500  ; absolute address to place my code/constant data

; variable/data section

            ORG RAMStart
 ; Insert here your data definition.


            ORG   ROMStart
_Startup
Entry
   
;*********************************************************************
;*                        CODE STARTS HERE                           *
;*********************************************************************
;*********************************************************************		        
;*                         ASSEMBLY FORMAT                           *
;*                                                                   *
;*                  LABEL OPERATION OPERAND COMMENT                  *
;*                                                                   *
;* LABEL: Must start in column 1 (check bottom corner to see col #)  *
;* OPERATION is a command to CPU/ Directive is a command to assembler*
;* OPERAND: Addressing Mode must be indicated in front of operand    *
;* COMMENT: Semi colon begins a comment. Makes code easier ot read   *
;*********************************************************************

;*********************************************************************
; BEFORE YOU START!!!!!!!!!!!!! READ THIS!!!!!!!!!!!!!!!!
;
; Read Tutorial 4
; This code is plug and play (all values are hardcoded)
; Have the instruction set open and look up all the instructions. How many clock cycles does each line need?
; Only look at the HNZVC bits in the CCR. 
; This codes uses Register X/Y which we have not discussed in tutorial yet. 
;*********************************************************************

; Your code will be stored starting at address $0400 (you can change it at line 31)

; Heartbeat LED Code 	
            LDS   #RAMEnd+1       ; initialize the stack pointer

            LDAA #$01
            STAA DDRJ             ; turn on uC LED to show "I'm alive!"
            STAA PTJ     ;

; Tutorial 3 Code 

;ORG 1500 is already done in Setup Code section

; Tutorial 4 Page 33
BRANCH LDAA #$02
       SUBA #$01
       TBEQ A, BRANCH
       LDAA #$9
       ;We can't have WAI here since there is more code to follow	

; Tutorial 4 Page 41
; WARNING: THIS WILL STICK YOU IN AN INFINITE LOOP!
; YOU WILL NEED TO COMMENT OUT THIS SECTION TO CONTINUE WITH THE TUTORIAL 

BRANCHS LDAA #$01
        SUBA #$01
        TBEQ A, BRANCHS
        LDAA #$9  ; This branch will never load Accumulator A with the value 9!
        
        
; Tutorial 4 Page 50
     LDY #10 ; Notice it appears as A in the register- why?

LOOP NOP 
     NOP
     NOP
     NOP
     NOP
     DBNE Y, LOOP

; Tutorial 4 Page 53
            LDY #2    ; set Y=10 as our outer loop
LOOPOFF_OUT LDX #2 ;set X=50000 as our inner loop
LOOPOFF_IN  NOP
            NOP
            NOP
            NOP
            NOP 
		        DBNE x,LOOPOFF_IN	     ;decrement x, if x is not zero go to label         
		        DBNE y,LOOPOFF_OUT    ;decrement y, if y is not zero go to label 
           
           
	          WAI 
      
;*********************************************************************
;*                Interrupt Vectors (Don't Change)                   *
;*********************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector           