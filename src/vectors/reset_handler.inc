.macro LOAD_PPU_PALETTES
  LDX PPU_STAT

  LDX #$3f
  STX PPU_ADDR

  LDX #$00
  STX PPU_ADDR

.repeat $20
  LDA ppu_palettes, X
  STA PPU_DATA
  INX
.endrepeat
.endmacro

.macro LOAD_PPU_ATTR_TABLE HB, LB
  LDA PPU_STAT

  LDA HB
  STA PPU_ADDR

  LDA LB
  STA PPU_ADDR

  LDX #%00000000
  ; 76 54 32 10
  ; || || || ||
  ; || || || ++-- top left palette
  ; || || ++----- top right palette
  ; || ++-------- bottom left palette
  ; ++----------- bottom right palette
  ;
  ; with:
  ;   - %00 → palette 0
  ;   - %01 → palette 1
  ;   - %10 → palette 2
  ;   - %11 → palette 3
  ;
  ; See: https://www.nesdev.org/wiki/PPU_attribute_tables

  .repeat $20
    STX PPU_DATA
  .endrepeat
.endmacro

.proc reset_handler
  SEI
  CLD

  LDX #$00

  STX PPU_CTRL
  STX PPU_MASK

  LOAD_PPU_PALETTES

  LOAD_PPU_ATTR_TABLE #$23, #$e0 ; namespace 0
  LOAD_PPU_ATTR_TABLE #$27, #$e0 ; namespace 1

await_vblank:
  BIT PPU_STAT
  BPL await_vblank

  JMP main
.endproc
