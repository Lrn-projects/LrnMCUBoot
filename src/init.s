ldi R16,low(RAMEND)
; Load the low byte of the stack pointer in R16
out SPL,R16
; Output the value to the stack pointer
ldi R16,high(RAMEND)
 ; Load the high byte of the stack pointer in R16
out SPH,R16
; Comment out if the AVR have <256 bytes SRAM
  .section text
  .org 0
  .global init

  rjmp main


