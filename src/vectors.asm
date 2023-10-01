.segment "CODE"

.import nmi_handler
.import reset_handler
.import irq_handler

.segment "VECTORS"

.word nmi_handler
.word reset_handler
.word irq_handler
