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
  .repeat $20
    STX PPU_DATA
  .endrepeat

  ; 76 54 32 10
  ; -- --  - --   See: https://www.nesdev.org/wiki/PPU_attribute_tables
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

  ; 7654 3210  PPU CTRL
  ; ---- ----
  ; VPHB SINN  See: https://www.nesdev.org/wiki/PPU_registers#PPUCTRL
  ; |||| ||||
  ; |||| ||++- Base nametable address
  ; |||| ||    (0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00)
  ; |||| |+--- VRAM address increment per CPU read/write of PPUDATA
  ; |||| |     (0: add 1, going across; 1: add 32, going down)
  ; |||| +---- Sprite pattern table address for 8x8 sprites
  ; ||||       (0: $0000; 1: $1000; ignored in 8x16 mode)
  ; |||+------ Background pattern table address (0: $0000; 1: $1000)
  ; ||+------- Sprite size (0: 8x8 pixels; 1: 8x16 pixels – see PPU OAM#Byte 1)
  ; |+-------- PPU master/slave select
  ; |          (0: read backdrop from EXT pins; 1: output color on EXT pins)
  ; +--------- Generate an NMI at the start of the
  ;            vertical blanking interval (0: off; 1: on)

  LDA #%10010000
  STA PPU_CTRL

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

  LDA #%00011110
  STA PPU_MASK

await_vblank:
  BIT PPU_STAT
  BPL await_vblank

  JMP main
.endproc
