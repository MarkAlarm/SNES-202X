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
	dw $5080,$50A0,$50C0,$50E0,$5100,$5120,$5140,$5160
	dw $5090,$50B0,$50D0,$50F0,$5110,$5130,$5150,$5170
	
.option_mirror_offsets
	dw $0100,$0140,$0180,$01C0,$0200,$0240,$0280,$02C0
	dw $0120,$0160,$01A0,$01E0,$0220,$0260,$02A0,$02E0
