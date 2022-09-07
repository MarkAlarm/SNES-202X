gfx_demo_1_init:
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
	
	%vram_fill($00,$0000,$0000,0)
	%upload_4bpp_gfx(gfx_demo_1_tileset,$0000)
	%upload_4bpp_gfx(gfx_demo_1_player,$6000)
	%vram_write(.init_fg_tilemap,$3000,$0700,0)
	%upload_palette(generic_palette)
	
	STZ PPU.cgram_address
	LDA #$80
	STA PPU.cgram_data
	LDA #$5D
	STA PPU.cgram_data
	
	%set_pointer_rom(!main_pointer,gfx_demo_1_main)
	%set_pointer_rom(!nmi_pointer,gfx_demo_1_nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL

; yxpccctt tttttttt
.init_fg_tilemap
	incbin "init_tilemap.map"
	