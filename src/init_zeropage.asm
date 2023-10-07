.segment "ZEROPAGE"

.include "includes/import_all_vectors.inc"

.import current_vector
.import current_vector_addr_offset

.import nametable_lb
.import nametable_hb

.segment "CODE"

.proc init_zeropage
  lda #$20
  sta nametable_lb
  sta nametable_hb

  lda #%00000000
  sta current_vector
  sta current_vector_addr_offset

  lda #%00000000

  sta vector_00
  sta vector_01
  sta vector_02
  sta vector_03
  sta vector_04
  sta vector_05
  sta vector_06
  sta vector_07
  sta vector_08
  sta vector_09
  sta vector_0a
  sta vector_0b
  sta vector_0c
  sta vector_0d
  sta vector_0e
  sta vector_0f

  sta vector_10
  sta vector_11
  sta vector_12
  sta vector_13
  sta vector_14
  sta vector_15
  sta vector_16
  sta vector_17
  sta vector_18
  sta vector_19
  sta vector_1a
  sta vector_1b
  sta vector_1c
  sta vector_1d
  sta vector_1e
  sta vector_1f

  sta vector_20
  sta vector_21
  sta vector_22
  sta vector_23
  sta vector_24
  sta vector_25
  sta vector_26
  sta vector_27
  sta vector_28
  sta vector_29
  sta vector_2a
  sta vector_2b
  sta vector_2c
  sta vector_2d
  sta vector_2e
  sta vector_2f

  sta vector_30
  sta vector_31
  sta vector_32
  sta vector_33
  sta vector_34
  sta vector_35
  sta vector_36
  sta vector_37
  sta vector_38
  sta vector_39
  sta vector_3a
  sta vector_3b
  sta vector_3c
  sta vector_3d
  sta vector_3e
  sta vector_3f

  sta vector_40
  sta vector_41
  sta vector_42
  sta vector_43
  sta vector_44
  sta vector_45
  sta vector_46
  sta vector_47
  sta vector_48
  sta vector_49
  sta vector_4a
  sta vector_4b
  sta vector_4c
  sta vector_4d
  sta vector_4e
  sta vector_4f

  sta vector_50
  sta vector_51
  sta vector_52
  sta vector_53
  sta vector_54
  sta vector_55
  sta vector_56
  sta vector_57
  sta vector_58
  sta vector_59
  sta vector_5a
  sta vector_5b
  sta vector_5c
  sta vector_5d
  sta vector_5e
  sta vector_5f
  sta vector_60
  sta vector_61
  sta vector_62
  sta vector_63
  sta vector_64
  sta vector_65
  sta vector_66
  sta vector_67
  sta vector_68
  sta vector_69
  sta vector_6a
  sta vector_6b
  sta vector_6c
  sta vector_6d
  sta vector_6e
  sta vector_6f

  rts
.endproc

.export init_zeropage
