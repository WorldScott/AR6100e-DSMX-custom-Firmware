;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME:   SleepTimer_1INT.asm
;;  Version: 1.0, Updated on 2015/3/4 at 22:26:59
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION:  SleepTimer Interrupt Service Routine.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "SleepTimer_1.inc"
include "memory.inc"
include "m8c.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  _SleepTimer_1_ISR


export  SleepTimer_1_fTick
export _SleepTimer_1_fTick
export  SleepTimer_1_bTimerValue
export _SleepTimer_1_bTimerValue
export  SleepTimer_1_bCountDown
export _SleepTimer_1_bCountDown
export  SleepTimer_1_TickCount
export _SleepTimer_1_TickCount

;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------
AREA InterruptRAM (RAM, REL, CON)

 SleepTimer_1_fTick:
_SleepTimer_1_fTick:        BLK  1

 SleepTimer_1_bTimerValue:
_SleepTimer_1_bTimerValue:  BLK  1

 SleepTimer_1_bCountDown:
_SleepTimer_1_bCountDown:   BLK  1

 SleepTimer_1_TickCount:
_SleepTimer_1_TickCount:    BLK  SleepTimer_1_TICK_CNTR_SIZE



;@PSoC_UserCode_INIT@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom declarations below this banner
;---------------------------------------------------

;------------------------
;  Includes
;------------------------


;------------------------
;  Constant Definitions
;------------------------


;------------------------
; Variable Allocation
;------------------------


;---------------------------------------------------
; Insert your custom declarations above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)


AREA UserModules (ROM, REL, CON)

;-----------------------------------------------------------------------------
;  FUNCTION NAME: _SleepTimer_1_ISR
;
;  DESCRIPTION:
;      interrupt handler for instance SleepTimer_1.
;
;     This is a place holder function.  If the user requires use of an interrupt
;     handler for this function, then place code where specified.
;-----------------------------------------------------------------------------

_SleepTimer_1_ISR:

   or   [SleepTimer_1_fTick],0x01           ; Set tick flag
 
                                                ; Decrement CountDown (Sync counter)
   tst  [SleepTimer_1_bCountDown],0xFF
   jz   .DoTimer
   dec  [SleepTimer_1_bCountDown]

.DoTimer:                                       ; Decrement TimerValue, if required
   tst  [SleepTimer_1_bTimerValue],0xFF
   jz   .IncBigCounter
   dec  [SleepTimer_1_bTimerValue]

.IncBigCounter:                                 ; Increment big tick counter
IF (SleepTimer_1_TICK_CNTR_SIZE & 0x04)
   inc  [SleepTimer_1_TickCount+3]
   jnc  SleepTimer_1_SLEEP_ISR_END

   inc  [SleepTimer_1_TickCount+2]
   jnc  SleepTimer_1_SLEEP_ISR_END
ENDIF

IF (SleepTimer_1_TICK_CNTR_SIZE & (0x04|0x02))
   inc  [SleepTimer_1_TickCount+1]
   jnc  SleepTimer_1_SLEEP_ISR_END
ENDIF

   inc  [SleepTimer_1_TickCount+0]

SleepTimer_1_SLEEP_ISR_END:

   ;@PSoC_UserCode_BODY_1@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom assembly code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers.
   
   ;---------------------------------------------------
   ; Insert your custom assembly code above this banner
   ;---------------------------------------------------
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function below this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   
   ;PRESERVE_CPU_CONTEXT
   ;ljmp _Sleep_Timer_Interrupt
   ;RESTORE_CPU_CONTEXT
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function above this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   reti

; end of file SleepTimer_1INT.asm

