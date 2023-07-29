.segment "CODE"

.proc nmi_handler
  RTI
.endproc

.proc reset_handler
.endproc

.proc irq_handler
  RTI
.endproc
