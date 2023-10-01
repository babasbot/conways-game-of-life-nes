.segment "ZEROPAGE"

.import cells_vector_0

.segment "CODE"

.proc init_cells_vectors
  lda %11111111
  sta cells_vector_0

  rts
.endproc

.export init_cells_vectors
