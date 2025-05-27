.section .entry
.global _start

.data
  // reserved 4 octets to store an adr
  stack_base: .word 0 

_start:
  // alloc 16 octets on the stack
  entry   sp, 16
  .literal_position
  // load 32 bits from literal &stack_base in a2 register
  l32r    a2, stack_base
  // store 32 bits integer from a2 to sp
  s32i    sp, a2, 0
  call4 main
