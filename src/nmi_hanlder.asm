.include "constants.inc"

.segment "CODE"

.import draw_cells

.macro OAM_DMA_TRANSFER
  lda #$00
  sta OAM_ADDR
  lda #$02
  sta OAM_DMA
.endmacro

.proc nmi_handler
  OAM_DMA_TRANSFER

  jsr draw_cells

  lda #$00
  sta PPU_SCROLL
  sta PPU_SCROLL

  rti
.endproc

.export nmi_handler

