.segment "RODATA"

ppu_palettes:
  .byte $0d, $30, $2a, $0d ; background palette 0
  .byte $0d, $30, $0d, $0d ; background palette 1
  .byte $0d, $30, $0d, $0d ; background palette 2
  .byte $0d, $30, $0d, $0d ; background palette 3

  .byte $0d, $0d, $0d, $0d ; sprite palette 0
  .byte $0d, $0d, $0d, $0d ; sprite palette 1
  .byte $0d, $0d, $0d, $0d ; sprite palette 2
  .byte $0d, $0d, $0d, $0d ; sprite palette 3

.export ppu_palettes

