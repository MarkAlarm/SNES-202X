menu_nmi:
	PHB
	PHK
	PLB
	
	; update the previous option (clear highlight)
	LDA !menu_previous_option
	ASL
	TAX

	PHP
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	
	LDA .option_vram_strips,x
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #!layer_3_mirror
	CLC : ADC .option_mirror_offsets,x
	STA DMA[0].source_word
	LDY.b #!layer_3_mirror>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	PLP
	
	; update the current option (highlight it)
	LDA !menu_current_option
	ASL
	TAX

	PHP
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	
	LDA .option_vram_strips,x
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #!layer_3_mirror
	CLC : ADC .option_mirror_offsets,x
	STA DMA[0].source_word
	LDY.b #!layer_3_mirror>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	PLP

	PLB
	RTL

.option_vram_strips
	dw $5080,$5090,$50A0,$50B0,$50C0,$50D0,$50E0,$50F0
	dw $5100,$5110,$5120,$5130,$5140,$5150,$5160,$5170
	
.option_mirror_offsets
	dw $0100,$0120,$0140,$0160,$0180,$01A0,$01C0,$01E0
	dw $0200,$0220,$0240,$0260,$0280,$02A0,$02C0,$02E0
