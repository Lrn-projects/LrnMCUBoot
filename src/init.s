.equ RAMEND, 0x8ff
.equ SPL, 0x3d
.equ SPH, 0x3e

init:
  ldi r16,lo8(RAMEND)
  out SPL,r16
  ldi r16,hi8(RAMEND)
  out SPH,r16

main:
  rjmp main
