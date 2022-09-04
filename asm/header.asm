warnpc $00FFB0
org $00FFB0
	db "MA"							; Maker Code					| $FFB0
	db "202X"						; Game Code						| $FFB2
	db $00,$00,$00,$00,$00,$00		; Unused						| $FFB6
	db $00							; Expansion FLASH Size			| $FFBC
	db $00							; Expansion RAM Size			| $FFBD
	db $00							; Special Version				| $FFBE
	db $00							; Chipset Sub-type				| $FFBF
	
	db "SNES HOMEBREW - 202X "		; Cartridge Title				| $FFC0
	db $30							; Mapping Mode					| $FFD5
	db $02							; Chipset						| $FFD6
	db $09							; ROM Size						| $FFD7
	db $02							; SRAM Size						| $FFD8
	db $01							; Country						| $FFD9
	db $33							; Developer ID					| $FFDA
	db $00							; Version Number				| $FFDB
	dw $0000						; Checksum Complement			| $FFDC
	dw $0000						; Checksum						| $FFDE
	
	dw $0000						; Unused						| $FFE0
	dw $0000						; Unused						| $FFE2
	dw cop_init						; Native COP					| $FFE4
	dw brk_init						; Native BRK					| $FFE6
	dw $0000						; Native Abort (unused)			| $FFE8
	dw nmi_init						; Native NMI					| $FFEA
	dw reset_init					; Unused						| $FFEC
	dw irq_init						; Native IRQ					| $FFEE
	
	dw $0000						; Unused						| $FFF0
	dw $0000						; Unused						| $FFF2
	dw cop_init						; Emulation COP					| $FFF4
	dw brk_init						; Unused						| $FFF6
	dw $0000						; Emulation Abort (unused)		| $FFF8
	dw nmi_init						; Emulation NMI					| $FFFA
	dw reset_init					; Emulation Reset				| $FFFC
	dw irq_init						; Emulation IRQ/BRK				| $FFFE
