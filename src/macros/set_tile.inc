.include "constants.inc"

.macro set_tile tile_index, nametable_hb, nametable_lb
  lda PPU_STAT

  lda #nametable_hb
  sta PPU_ADDR

  lda #nametable_lb
  sta PPU_ADDR

  ldx #tile_index
  stx PPU_DATA
.endmacro

