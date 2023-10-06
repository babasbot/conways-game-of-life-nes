.segment "ZEROPAGE"

.import cells_vector_0
.import current_cell_vector
.import nametable_lb
.import nametable_hb

.segment "CODE"

.proc init_cells_vectors
  lda #$20
  sta nametable_lb
  sta nametable_hb

  lda %00000000
  sta current_cell_vector

  lda %10100101
  sta cells_vector_0

  rts
.endproc

.export init_cells_vectors
