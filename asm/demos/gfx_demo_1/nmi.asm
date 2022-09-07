gfx_demo_1_nmi:
	PHB
	PHK
	PLB
	
	LDA !frame_counter_low
	LSR #3
	AND #$07
	ASL
	TAX
	
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	LDA #$0700
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #gfx_demo_1_water_anim
	CLC : ADC .water_anim_offsets,x
	STA DMA[0].source_word
	LDY.b #gfx_demo_1_water_anim>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	
	SEP #$30
	
	PLB
	RTL

.water_anim_offsets
	dw $0000,$0020,$0040,$0060,$0080,$00A0,$00C0,$00E0
