.segment "HEADER"

.byte 'N', 'E', 'S', $1A             ; iNES magic number
.byte $02                            ; 16 KB PRG-ROM
.byte $01        	                   ; 08 KB CHR-ROM
.byte $00000001                      ; Vertical mirroring
.byte $0                             ; NROM
.byte $0, $0, $0, $0, $0, $0, $0, $0 ; Unused padding
