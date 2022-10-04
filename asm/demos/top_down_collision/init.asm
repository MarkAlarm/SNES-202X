init:
	STZ CPU.interrupt_enable
	LDA #$8F
	STA PPU.screen
	
	LDA.b #($6000>>13)|($00<<3)|$00
	STA PPU.sprite_select
	
	LDA #$09
	STA PPU.background_mode
	
	LDA.b #($3000>>8)|$00
	STA PPU.layer_1_tilemap
	LDA.b #($4000>>8)|$00
	STA PPU.layer_2_tilemap
	LDA.b #($4800>>8)|$00
	STA PPU.layer_3_tilemap
	
	LDA #$00
	STA PPU.layer_1_2_tiledata
	LDA #$04
	STA PPU.layer_3_4_tiledata
	
	LDA #$17
	STA PPU.main_screen
	STA PPU.sub_screen
	
	; initialize player stuff
	REP #$20
	
	LDA #$7C00
	STA !player_x_pos
	LDA #$8000
	STA !player_y_pos
	
	STZ !player_x_spd
	STZ !player_y_spd
	
	SEP #$20
	
	STZ !player_dir_move
	STZ !player_dir_face
	STZ !player_blocked
	
	; initialize map
	%wram_write(.init_fg_collision,!collision_interaction_table,$0380,0)
	
	; update vram
	%vram_fill($00,$0000,$0000,0)
	%upload_4bpp_gfx(tileset,$0000)
	%upload_4bpp_gfx(player,$6000)
	%vram_write(.init_fg_tilemap,$3000,$0700,0)
	
	; update cgram
	%cgram_fill($00,$00,$0200,0)
	%upload_palette(generic_palette)
	
	STZ PPU.cgram_address
	LDA #$00
	STA PPU.cgram_data
	LDA #$22
	STA PPU.cgram_data
	
	; update oam
	%oam_clear()
	%oam_mirror_clear()
	
	; setup pointers
	%set_pointer_rom(!main_pointer,main)
	%set_pointer_rom(!nmi_pointer,nmi)
	%set_pointer_rom(!irq_pointer,irq)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL

table "graphics_table.txt"
.init_fg_tilemap
	dw "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
	dw "SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES"
	dw "SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES"
	dw "SEESSSSSEEEEEEEEEEEEEEEESSSSSEES"
	dw "SEESEEEEEEEEEEEEEEEEEEEEEEEESEES"
	dw "SEESECEEEEEEEEEEEEEEEEEEEECESEES"
	dw "SEESEEEEEEEEEEEEEEEEEEEEEEEESEES"
	dw "SEESEEEKEEEEESEEEESEEEEEKEEESEES"
	dw "SEEEEEEEEEEEEREEEELEEEEEEEEEEEES"
	dw "SEEEEEEEEEEEEREEEELEEEEEEEEEEEES"
	dw "SEEEEEEEEESUUSDDDDSUUSEEEEEEEEES"
	dw "SEEEEEEEEEEEELEEEEREEEEEEEEEEEES"
	dw "SEEEEEEEEEEEELEEEEREEEEEEEEEEEES"
	dw "SEEEEEEEEEEEESEEEESEEEEEEEEEEEES"
	dw "SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES"
	dw "SEESESEEEEPEEEEEEEEEEPEEEESESEES"
	dw "SEESESEEEEEEEEEEEEEEEEEEEESESEES"
	dw "SEESESEEEEEEEEEEEEEEEEEEEESESEES"
	dw "SEESESEEEEKKKKKKKKKKKKEEEESESEES"
	dw "SEESESEEEEEEEEEEEEEEEEEEEESESEES"
	dw "SEESESEEEEEEEEEEEEEEEEEEEESESEES"
	dw "SEESESEEEEEEEEEEEEEEEEEEEESESEES"
	dw "SEESESEEEESSSSSSSSSSSSEEEESESEES"
	dw "SEESCSEEEEEEEEEEEEEEEEEEEESCSEES"
	dw "SEESSSEEEESSSSSSSSSSSSEEEESSSEES"
	dw "SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES"
	dw "SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES"
	dw "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
cleartable

table "collision_table.txt"
.init_fg_collision
	db "ssssssssssssssssssssssssssssssss"
	db "seeeeeeeeeeeeeeeeeeeeeeeeeeeeees"
	db "seeeeeeeeeeeeeeeeeeeeeeeeeeeeees"
	db "seessssseeeeeeeeeeeeeeeesssssees"
	db "seeseeeeeeeeeeeeeeeeeeeeeeeesees"
	db "seeseceeeeeeeeeeeeeeeeeeeecesees"
	db "seeseeeeeeeeeeeeeeeeeeeeeeeesees"
	db "seeseeekeeeeeseeeeseeeeekeeesees"
	db "seeeeeeeeeeeereeeeleeeeeeeeeeees"
	db "seeeeeeeeeeeereeeeleeeeeeeeeeees"
	db "seeeeeeeeesuusddddsuuseeeeeeeees"
	db "seeeeeeeeeeeeleeeereeeeeeeeeeees"
	db "seeeeeeeeeeeeleeeereeeeeeeeeeees"
	db "seeeeeeeeeeeeseeeeseeeeeeeeeeees"
	db "seeeeeeeeeeeeeeeeeeeeeeeeeeeeees"
	db "seeseseeeepeeeeeeeeeepeeeesesees"
	db "seeseseeeeeeeeeeeeeeeeeeeesesees"
	db "seeseseeeeeeeeeeeeeeeeeeeesesees"
	db "seeseseeeekkkkkkkkkkkkeeeesesees"
	db "seeseseeeeeeeeeeeeeeeeeeeesesees"
	db "seeseseeeeeeeeeeeeeeeeeeeesesees"
	db "seeseseeeeeeeeeeeeeeeeeeeesesees"
	db "seeseseeeesssssssssssseeeesesees"
	db "seescseeeeeeeeeeeeeeeeeeeescsees"
	db "seessseeeesssssssssssseeeesssees"
	db "seeeeeeeeeeeeeeeeeeeeeeeeeeeeees"
	db "seeeeeeeeeeeeeeeeeeeeeeeeeeeeees"
	db "ssssssssssssssssssssssssssssssss"
cleartable
