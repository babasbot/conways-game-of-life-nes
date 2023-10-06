.include "constants.inc"

.segment "CODE"

.proc main
@loop:
  jmp @loop
.endproc

.export main

