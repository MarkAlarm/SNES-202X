menu_init:
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
	
	%vram_write(font_generic,$3000,$0800,0)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%wram_write(.init_tilemap,!layer_3_mirror,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	%set_pointer_rom(!main_pointer,menu_main)
	%set_pointer_rom(!nmi_pointer,menu_nmi)
	
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
	dw " > Collision     > Option 9     "
	dw " > 2 Controllers > Option 10    "
	dw " > 4 Controllers > Option 11    "
	dw " > Font Test     > Option 12    "
	dw " > Option 5      > Option 13    "
	dw " > Option 6      > Option 14    "
	dw " > Option 7      > Option 15    "
	dw " > Option 8      > Null         "
	dw "                                "
	dw " Use the d-pad to highlight an  "
	dw " option, then press start to    "
	dw " enter the demo.                "
	dw "                                "
	dw " Most demos will require you to "
	dw " reset the console in order to  "
	dw " return to this menu.           "
	dw "                                "
	dw " Null will intentionally freeze "
	dw " this menu as it functions as a "
	dw " forced test for unhandled      "
	dw " pointers.                      "
	dw "                                "
	dw "                                "
	dw "                                "
