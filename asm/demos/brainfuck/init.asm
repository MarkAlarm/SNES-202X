init:
	PHB
	PHK
	PLB
	
	%wdm()
	
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
	
	%vram_fill($00,$0000,$0000,0)
	%cgram_fill($00,$00,$0200,0)
	%upload_2bpp_gfx(font,$3000)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	
	%wram_write(.init_ins_disp,!bf_ins_disp,$0400,0)
	%wram_write(.init_dat_disp,!bf_dat_disp,$0080,0)
	%wram_write(.init_out_disp,!bf_out_disp,$0100,0)
	
	%vram_write(!bf_ins_disp,$5080,$0400,0)
	%vram_write(!bf_dat_disp,$52A0,$0080,0)
	%vram_write(!bf_out_disp,$5300,$0100,0)
	
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
	dw "  Brainfuck Editor/Interpreter  "
	dw "                                "
	dw "------------ <Code> ------------"
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
	dw "------------ <Data> ------------"
	dw "                                "
	dw "                                "
	dw "----------- <Output> -----------"
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "

.init_ins_disp
	dw "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "i                              i"
	dw "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
	
.init_dat_disp
	dw "dddddddddddddddddddddddddddddddd"
	dw "d                              d"
	
.init_out_disp
	dw "oooooooooooooooooooooooooooooooo"
	dw "o                              o"
	dw "o                              o"
	dw "oooooooooooooooooooooooooooooooo"