.macro OAM_DMA_TRANSFER
  LDA #$00
  STA OAM_ADDR
  LDA #$02
  STA OAM_DMA
.endmacro

.proc nmi_handler
  OAM_DMA_TRANSFER

  RTI
.endproc
