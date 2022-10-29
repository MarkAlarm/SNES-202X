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
	
	REP #$20
	STZ !bf_ins_edit_index
	STZ !bf_dat_edit_index
	STZ !bf_ins_run_index
	STZ !bf_arr_run_index
	SEP #$20
	
	STZ !bf_inp_run_index
	STZ !bf_out_run_index
	
	STZ !bf_edit_mode
	
	%wram_fill($00,!bf_ins_raw,$0200,0)
	%wram_fill($00,!bf_dat_raw,$0040,0)
	%wram_fill($20,!bf_out_raw,$0080,0)
	%wram_fill($00,!bf_array,$0400,0)
	
	%wram_write(.init_program,!bf_ins_raw,(.init_program_end-.init_program),0)
	
	%vram_fill($00,$0000,$0000,0)
	%cgram_fill($00,$00,$0200,0)
	%vram_write(font,$3000,$1000,0)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	
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

pushtable
table "bf-table.txt"
.init_program
;	db " "

	db "++++++++++[>+>+++>+++++++>++++++"
	db "++++<<<<-]>>>++.>+.+++++++..+++."
	db "<<++.>+++++++++++++++.>.+++.----"
	db "--.--------.<<+.<"
	
	; db "++++[>+++++<-]>[<+++++>-]+<+["
    ; db ">[>+>+<<-]++>>[<<+>>-]>>>[-]++>[-]+"
    ; db ">>>+[[-]++++++>>>]<<<[[<++++++++<++>>-]+<.<[>----<-]<]"
    ; db "<<[>>>>>[>>>[-]+++++++++<[>-<-]+++++++++>[-[<->-]+[<<<]]<[>+<-]>]<<-]<<-]"
..end
pulltable

