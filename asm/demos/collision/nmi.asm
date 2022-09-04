collision_nmi:
	; update OAM
	STZ PPU.oam_address
	
	REP #$20
	
	LDA #$0400
	STA DMA[0].settings
	LDA #!OAM_start
	STA DMA[0].source_word
	LDY.b #!OAM_start>>16
	STY DMA[0].source_bank
	LDA #$0220
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	
	SEP #$20
	
	RTL