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
	
	STZ !menu_current_option
	STZ !menu_previous_option
	
	%upload_2bpp_gfx(generic_font,$3000)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%wram_write(.init_tilemap,!layer_3_mirror,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	%set_pointer_rom(!main_pointer,main)
	%set_pointer_rom(!nmi_pointer,nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	PLB
	RTL

.init_tilemap
	dw "                                "
	dw " Various SNES Tech Demos - 202X "
	dw "          By MarkAlarm          "
	dw "                                "
	dw " > Collision     > 2 Controllers"
	dw " > Font Test     > 4 Controllers"
	dw " > Stardew Clock > Inventory    "
	dw " > GFX Demo 1    > Math         "
	dw " > Option 9      > T-D Collision"
	dw " > Option 11     > Option 12    "
	dw " > Option 13     > Option 14    "
	dw " > Template      > Null         "
	dw "                                "
	dw " Use the d-pad to highlight an  "
	dw " option, then press start to    "
	dw " enter the demo. Hold select to "
	dw " display a brief description    "
	dw " about the highlighted demo.    "
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
