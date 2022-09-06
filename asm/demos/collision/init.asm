collision_init:
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
	LDA #$8000
	STA !collision_player_x_pos
	LDA #$4000
	STA !collision_player_y_pos
	
	STZ !collision_player_x_spd
	STZ !collision_player_y_spd
	SEP #$20
	
	%wram_write(.init_fg_collision,!collision_interaction_table,!collision_map_size,0)
	
	%vram_fill($00,$0000,$0000,0)
	%upload_4bpp_gfx(collision_tileset,$0000)
	%vram_write(.init_fg_tilemap,$3000,$0700,0)
	%upload_4bpp_gfx(collision_sprites,$6000)
	%upload_palette(smw_palette)
	%oam_clear()
	%oam_mirror_clear()
	
	STZ PPU.cgram_address
	LDA #$80
	STA PPU.cgram_data
	LDA #$5D
	STA PPU.cgram_data

	%set_pointer_rom(!main_pointer,collision_main)
	%set_pointer_rom(!nmi_pointer,collision_nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL
	
.init_fg_tilemap
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "GGGGEEEEEEEEEEEEEEEEEEEEEEEEGGGG"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEESSEEEEESSEEEEEEEESSEEEEESSEEE"
	dw "EEEGGGGGGGGGEEEEEEEEGGGGGGGGGEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEGEEEEEEEEEEEEEEEEGEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEGGGGGGGGEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	dw "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	
.init_fg_collision
	db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "ggggeeeeeeeeeeeeeeeeeeeeeeeegggg"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeesseeeeesseeeeeeeesseeeeesseee"
    db "eeegggggggggeeeeeeeegggggggggeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeegeeeeeeeeeeeeeeeegeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeggggggggeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    db "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"