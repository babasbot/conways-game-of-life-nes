.macro LOAD_PPU_PALETTES
  LDX PPU_STAT

  LDX #$3f
  STX PPU_ADDR

  LDX #$00
  STX PPU_ADDR

write_palettes:
  LDA ppu_palettes, X
  STA PPU_DATA
  INX
  CPX #$20
  BNE write_palettes
.endmacro

.proc reset_handler
  SEI
  CLD

  LDX #$00

  STX PPU_CTRL
  STX PPU_MASK

  LOAD_PPU_PALETTES

await_vblank:
  BIT PPU_STAT
  BPL await_vblank

  JMP main
.endproc
