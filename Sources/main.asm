;*                       McMaster University                         *
;*********************************************************************               
;*                      2DP4 Microcontrollers                        *
;*                            Tutorial 3                             *
;*                          Omar Boursalie                           *
;*                           Jan 25, 2016                            *
;*********************************************************************
;*********************************************************************
;*                       Tutorial 3 Companion Code                         
; BEFORE YOU START!!!!!!!!!!!!! READ THIS!!!!!!!!!!!!!!!!
;
; Read Tutorial 3
; This code will access memory that will have random numbers (since this code does not assign any value to them)
; Make sure you check each memroy location (select memory window, select window and address) to verify the value was copied over
; Only look at the HNZVC bits in the CCR. 
; This codes uses Register X which we have not discussed in tutorial yet.
;
; Follow along using Tutorial 3 to trace the code as it executes                                                          
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
		        
ROMStart    EQU  $0400  ; absolute address to place my code/constant data

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
			
      ;Inherent Mode II: No operand (T3 p19)
            NOP ;
            
      ;Inherent Mode II: All operand are internal CPU register (T3 p19)
            INCA ;  LOOK THIS UP IN THE INSTRUCTION SET! What does it do? What mode? What is the machine code?
      
      ;Immediate Mode: Operand IS the number (T3 p20)
            LDAA #$20       ;hex number, notice proceeding #
            LDAA #%00100001 ;binary number, notice proceeding #
            
      ;Direct Mode: Address is only 8 bits long (T3 p21-22) 
            LDAA $20 ; notice nothing in front of number. In this case whatever is loaded in $20 will be copied to Accumulator A
            
      ;Extended Mode: Address is 16 bits long (T3 p21-22)
            LDAA $1600; notice nothing in front of number. In this case whatever is loaded in $1600 will be copied to Accumulator A           

      ;Indexed Addressing: Constant Offset (T3 p23-27)
            LDX #$1600 ; this uses register x which we have not discussed in tutorial. We will!
            LDAA 2,X
            
      ;Indexed Addressing: Offset in Accumulator (T3 p23-27)
            LDAB #$04
            LDAA B,X

      ;Assembler Directive (T3 p29-30)
            ;WAI; UNCOMMENT TO USE. notice that this will not take any space in memory since it is an instruction to the assembler
            
      ;CCR (T3 p41-42)
            LDAA #$79
            LDAB #$34
            
            SBA ; LOOK THIS UP IN THE INSTRUCTION SET! What does it do? What mode? What CCR bits should be effected? Check only HNZVC
            
      ;CCR (T3 p41-42)
            LDAA #$34
            LDAB #$79
            
            SBA ; LOOK THIS UP IN THE INSTRUCTION SET! What does it do? What mode? What CCR bits should be effected? Check only HNZVC                  
     
            WAI

;*********************************************************************
;*                Interrupt Vectors (Don't Change)                   *
;*********************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector           