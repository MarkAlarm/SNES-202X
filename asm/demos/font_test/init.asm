init:
	PHB
	PHK
	PLB
	
	STZ CPU.interrupt_enable
	LDA #$8F
	STA PPU.screen
	
	LDA.b #($6000>>13)|($00<<3)|$00
	STA PPU.sprite_select
	
	LDA #$09
	STA PPU.background_mode
	
	LDA.b #($4000>>8)|$00
	STA PPU.layer_1_tilemap
	LDA.b #($4800>>8)|$00
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

	%upload_2bpp_gfx(generic_font,$3000)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%wram_write(.init_tilemap,$7E2000,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	%set_pointer_rom(!main_pointer,font_test_main)
	%set_pointer_rom(!nmi_pointer,font_test_nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	PLB
	RTL

.init_tilemap
	dw "+------------------------------+"
	dw "| 0123456789 69 420 1337 80085 |"
	dw "| ~!@#$%^&*()_+-=              |"
	dw "| {}[]|\/?:;<,>.               |"
	dw "|                              |"
	dw "| QWERTYUIOPASDFGHJKLZXCVBNM   |"
	dw "| qwertyuiopasdfghjklzxcvbnm   |"
	dw "|                              |"
	dw "| The quick brown fox jumps    |"
	dw "| over the lazy dog.           |"
	dw "| Hello World!                 |"
	dw "|                              |"
	dw "| You may return to the main   |"
	dw "| menu by pressing start.      |"
	dw "+------------------------------+"
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
