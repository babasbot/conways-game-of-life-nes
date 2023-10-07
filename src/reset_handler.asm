.include "constants.inc"

.macro LOAD_PPU_PALETTES
  ldx PPU_STAT

  ldx #$3f
  stx PPU_ADDR

  ldx #$00
  stx PPU_ADDR

  .repeat $20
    lda ppu_palettes, X
    sta PPU_DATA

    inx
  .endrepeat
.endmacro

.macro LOAD_PPU_ATTR_TABLE HB, LB
  lda PPU_STAT

  lda HB
  sta PPU_ADDR

  lda LB
  sta PPU_ADDR

  ldx #%00000000

  .repeat $20
    stx PPU_DATA
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

.segment "RODATA"

.import ppu_palettes

.segment "CODE"

.import main
.import init_zeropage

.proc reset_handler
  sei
  cld

  ldx #$00

  stx PPU_CTRL
  stx PPU_MASK

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

  lda #%10010000
  sta PPU_CTRL

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

  lda #%00011110
  sta PPU_MASK

  jsr init_zeropage

await_vblank:
  bit PPU_STAT
  bpl await_vblank

  jmp main
.endproc

.export reset_handler
