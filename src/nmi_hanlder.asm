.include "constants.inc"

.segment "CODE"

.macro OAM_DMA_TRANSFER
  lda #$00
  sta OAM_ADDR
  lda #$02
  sta OAM_DMA
.endmacro

.proc nmi_handler
  OAM_DMA_TRANSFER

  rti
.endproc

.export nmi_handler

