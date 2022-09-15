init:
	STZ CPU.interrupt_enable
	LDA #$8F
	STA PPU.screen
	
	LDA.b #($6000>>13)|($00<<3)|$00
	STA PPU.sprite_select
	
	LDA #$09
	STA PPU.background_mode
	
	LDA.b #($4000>>9)|$00
	STA PPU.layer_1_tilemap
	LDA.b #($4800>>9)|$00
	STA PPU.layer_2_tilemap
	LDA.b #($5000>>8)|$00
	STA PPU.layer_3_tilemap
	
	LDA #$00
	STA PPU.layer_1_2_tiledata
	LDA #$03
	STA PPU.layer_3_4_tiledata
	
	LDA #$04
	STA PPU.main_screen
	STA PPU.sub_screen
	
	LDA #$01
	STA !lcg_rng_input
	STZ !lcg_rng_output
	
	REP #$20
	STZ !lcg_rng_index
	SEP #$20
	
	%vram_fill($00,$0000,$0000,0)
	%upload_2bpp_gfx(generic_font,$3000)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%wram_write(.init_tilemap,!layer_3_mirror,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	
	%set_pointer_rom(!main_pointer,main)
	%set_pointer_rom(!nmi_pointer,nmi)
	%set_pointer_rom(!irq_pointer,irq)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL

.init_tilemap
	dw "                                "
	dw "     Various Math Functions     "
	dw "                                "
	dw " A: $XXXXXXXX | 4294967295      "
	dw " B: $XXXXXXXX | 4294967295      "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
