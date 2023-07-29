.segment "CODE"

.include "../vectors/nmi_handler.inc"

.proc reset_handler
.endproc

.proc irq_handler
  RTI
.endproc
