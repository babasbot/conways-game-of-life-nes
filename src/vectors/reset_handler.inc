.proc reset_handler
  SEI
  CLD

  LDX #$00

  STX PPU_CTRL
  STX PPU_MASK

await_vblank:
  BIT PPU_STAT
  BPL await_vblank

  JMP main
.endproc
