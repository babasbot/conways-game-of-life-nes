.segment "ZEROPAGE"

nametable_hb:        .res 1
nametable_lb:        .res 1
current_cell_vector: .res 1
current_cell_bit:    .res 1
cells_vector_0:      .res 1

.export nametable_hb
.export nametable_lb
.export current_cell_vector
.export current_cell_bit
.export cells_vector_0
