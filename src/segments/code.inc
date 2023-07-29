.segment "CODE"

.include "../vectors/nmi_handler.inc"
.include "../vectors/reset_handler.inc"

.proc irq_handler
  RTI
.endproc
