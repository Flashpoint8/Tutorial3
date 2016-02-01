;*                       McMaster University                         *
;*********************************************************************               
;*                      2DP4 Microcontrollers                        *
;*                            Tutorial 3                             *
;*                           Jan 31, 2016                            *
;*********************************************************************
;*********************************************************************
;*                       Tutorial 4 Companion Code                         
; BEFORE YOU START!!!!!!!!!!!!! READ THIS!!!!!!!!!!!!!!!!
;
; Read Tutorial 4
;
; Follow along using Tutorial 4 to trace the code as it executes                                                          
;*********************************************************************
;*********************************************************************
;*                            References                             
;* Tutorial 3                                                                  
;* HCS12/9S12 Textbook                                                                   
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
; Read Tutorial 3
; This code will access memory that will have random numbers (since this code does not assign any value to them)
; Make sure you check each memroy location (select memory window, select memory from menubar and address) to verify the value was copied over
; Only look at the HNZVC bits in the CCR. 
; This codes uses Register X which we have not discussed in tutorial yet. 
;*********************************************************************

; Your code will be stored starting at address $0400 (you can change it at line 31)

; Heartbeat LED Code 	
            LDS   #RAMEnd+1       ; initialize the stack pointer

            LDAA #$01
            STAA DDRJ             ; turn on uC LED to show "I'm alive!"
            STAA PTJ     ;

; Tutorial 3 Code 
			
      
;*********************************************************************
;*                Interrupt Vectors (Don't Change)                   *
;*********************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector           