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
	
	; update vram
	%vram_fill($00,$0000,$0000,0)
	
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
