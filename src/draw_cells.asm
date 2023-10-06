.include "constants.inc"

.macro draw_tile TILE_INDEX
  lda PPU_STAT

  lda nametable_hb
  sta PPU_ADDR

  lda nametable_lb
  sta PPU_ADDR

  lda #TILE_INDEX
  sta PPU_DATA
.endmacro

.segment "ZEROPAGE"

.import nametable_hb
.import nametable_lb
.import current_vector
.import current_vector_bit

.segment "CODE"

.proc draw_dead_cell_tile
  draw_tile DEAD_CELL_TILE

  rts
.endproc

.proc draw_live_cell_tile
  draw_tile LIVE_CELL_TILE

  rts
.endproc

.proc inc_nametable_hb
  ; if nametable_hb == $23:
  ;   nop
  ; else:
  ;   inc nametable_hb

  lda nametable_hb
  cmp #$23
  bcc inc_hb

  jmp done

inc_hb:
  inc nametable_hb

done:
  rts
.endproc

.proc inc_nametable_lb
  ; if nametable_hb == $23 && nametable_lb == $9f:
  ;   nop
  ; else:
  ;   inc nametable_lb

  lda nametable_hb
  cmp #$23
  bne @inc_lb

  lda nametable_lb
  cmp #$9f
  bne @inc_lb

  jmp @done

@inc_lb:
  inc nametable_lb

@done:
  rts
.endproc

.proc increment_nametable_addr
  ; if nametable_lb == $ff:
  ;   jsr inc_nametable_hb
  ; else:
  ;   inc nametable_lb

  lda nametable_lb
  cmp #$ff
  bcc inc_lb

  jsr inc_nametable_hb

inc_lb:
  jsr inc_nametable_lb

  rts
.endproc

.proc draw_cells_vector
  lda #$00
  sta current_vector_bit

loop:
  clc
  asl current_vector
  bcc dead_cell_branch

  jsr draw_live_cell_tile
  jmp next_bit

dead_cell_branch:
  jsr draw_dead_cell_tile

next_bit:
  jsr increment_nametable_addr
  inc current_vector_bit

  lda current_vector_bit
  cmp #$08
  bcc loop

  rts
.endproc

.proc draw_cells
  lda #%11111111
  sta current_vector
  jsr draw_cells_vector

  rts
.endproc

.export draw_cells
