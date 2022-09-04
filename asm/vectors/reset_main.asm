reset_main:
	; initialize stack pointer, direct page, and setup data bank
	REP #$20
	LDA #$1FFF
	TCS
	PHK
	PLB
	LDA #$0000
	TCD
	
	; clear WRAM
	LDA #$8008
	STA DMA[0].settings
	LDA #fixed_bytes
	STA DMA[0].source_word
	LDY.b #fixed_bytes>>16
	STY DMA[0].source_bank
	STZ DMA[0].size
	
	STZ WRAM.address
	LDY #$00
	STY WRAM.high
	
	INY
	STY CPU.enable_dma
	STY CPU.enable_dma
	
	; initialize PPU registers
	LDA #$008F
	STA PPU.screen
	
	STZ PPU.background_mode
	
	STZ PPU.layer_1_2_tilemap
	STZ PPU.layer_3_4_tilemap
	STZ PPU.layer_all_tiledata
	
	; write twice to all of the scroll registers
	LDX #$00
	LDY #$FF
	
	STX PPU.layer_1_scroll_x
	STX PPU.layer_1_scroll_x
	STY PPU.layer_1_scroll_y
	STX PPU.layer_1_scroll_y
	STX PPU.layer_2_scroll_x
	STX PPU.layer_2_scroll_x
	STY PPU.layer_2_scroll_y
	STX PPU.layer_2_scroll_y
	STX PPU.layer_3_scroll_x
	STX PPU.layer_3_scroll_x
	STY PPU.layer_3_scroll_y
	STX PPU.layer_3_scroll_y
	STX PPU.layer_4_scroll_x
	STX PPU.layer_4_scroll_x
	STY PPU.layer_4_scroll_y
	STX PPU.layer_4_scroll_y
	
	STZ PPU.vram_data_high
	
	; write twice to all of the mode 7 registers
	STZ PPU.mode_7_A
	STZ PPU.mode_7_A
	STZ PPU.mode_7_C
	STZ PPU.mode_7_C
	STZ PPU.mode_7_center_x
	STZ PPU.mode_7_center_x
	
	STZ PPU.window_layer_all_settings
	STZ PPU.window_sprite_color_settings
	STZ PPU.window_1
	STZ PPU.window_2
	STZ PPU.window_logic
	
	STZ PPU.screens
	STZ PPU.window_masks
	
	STZ PPU.color_math
	STZ PPU.display_control
	
	; clear VRAM, CGRAM, OAM
	%vram_fill($00,$0000,$0000,0)
	%cgram_fill($00,$00,$0200,0)
	%oam_clear()
	
	%set_pointer_rom(!main_pointer,menu_init)
	%set_pointer_rom(!nmi_pointer,null_pointer)
	%set_pointer_rom(!irq_pointer,null_pointer)
	
	SEP #$30	
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	JML engine
