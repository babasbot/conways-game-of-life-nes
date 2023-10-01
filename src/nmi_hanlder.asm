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

  lda #$00
  sta PPU_SCROLL
  sta PPU_SCROLL

  lda #%00011110
  sta PPU_MASK

  ; 7654 3210  PPU MASK
  ; ---- ----
  ; BGRs bMmG  See: https://www.nesdev.org/wiki/PPU_registers#PPUMASK
  ; |||| ||||
  ; |||| |||+- Greyscale (0: normal color, 1: produce a greyscale display)
  ; |||| ||+-- 1: Show background in leftmost 8 pixels of screen, 0: Hide
  ; |||| |+--- 1: Show sprites in leftmost 8 pixels of screen, 0: Hide
  ; |||| +---- 1: Show background
  ; |||+------ 1: Show sprites
  ; ||+------- Emphasize red
  ; |+-------- Emphasize green
  ; +--------- Emphasize blue

  rti
.endproc

.export nmi_handler

