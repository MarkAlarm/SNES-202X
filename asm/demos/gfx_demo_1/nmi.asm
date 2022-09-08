nmi:
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
	
	; water animation
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
	
	LDA !frame_counter_low
	LSR #4
	AND #$03
	ASL
	TAX
	
	REP #$20
	
	; player up animation
	LDA #$0710
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #gfx_demo_1_player
	CLC : ADC .player_up_offsets,x
	STA DMA[0].source_word
	LDY.b #gfx_demo_1_player>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	
	; player down animation
	LDA #$0720
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #gfx_demo_1_player
	CLC : ADC .player_down_offsets,x
	STA DMA[0].source_word
	LDY.b #gfx_demo_1_player>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	
	; player left animation
	LDA #$0730
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #gfx_demo_1_player
	CLC : ADC .player_left_offsets,x
	STA DMA[0].source_word
	LDY.b #gfx_demo_1_player>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	
	; player right animation
	LDA #$0740
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #gfx_demo_1_player
	CLC : ADC .player_right_offsets,x
	STA DMA[0].source_word
	LDY.b #gfx_demo_1_player>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	
	SEP #$30
	
	LDA !frame_counter_low
	LSR #4
	AND #$0F
	ASL
	TAX
	
	REP #$20
	
	; player all animation
	LDA #$0750
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #gfx_demo_1_player
	CLC : ADC .player_all_offsets,x
	STA DMA[0].source_word
	LDY.b #gfx_demo_1_player>>16
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
	
.player_up_offsets
	dw $0000,$0200,$0400,$0200
	
.player_down_offsets
	dw $0020,$0220,$0420,$0220
	
.player_left_offsets
	dw $0040,$0240,$0440,$0240
	
.player_right_offsets
	dw $0060,$0260,$0460,$0260
	
.player_all_offsets
	dw $0000,$0200,$0400,$0200
	dw $0040,$0240,$0440,$0240
	dw $0020,$0220,$0420,$0220
	dw $0060,$0260,$0460,$0260
