.include "constants.inc"

.segment "ZEROPAGE"

.import state

.segment "CODE"

.import draw_cells
.import compute_neighborhoods

.macro OAM_DMA_TRANSFER
  lda #$00
  sta OAM_ADDR
  lda #$02
  sta OAM_DMA
.endmacro

.proc nmi_handler
  OAM_DMA_TRANSFER

  lda state
  cmp DRAWING_CELLS_STATE
  bne calculate_neighborhoods

  jsr draw_cells

calculate_neighborhoods:
  jsr compute_neighborhoods

  lda #$00
  sta PPU_SCROLL
  sta PPU_SCROLL

  rti
.endproc

.export nmi_handler

