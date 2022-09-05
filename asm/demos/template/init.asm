template_init:
	; get rid of the comments after copy/pasted
	STZ CPU.interrupt_enable
	LDA #$8F
	STA PPU.screen
	
	; this   vvvv is the vram address to use
	LDA.b #($0000>>13)|($00<<3)|$00
	STA PPU.sprite_select
	
	LDA #$09
	STA PPU.background_mode
	
	LDA.b #($0000>>8)|$00
	STA PPU.layer_1_tilemap
	LDA.b #($0000>>8)|$00
	STA PPU.layer_2_tilemap
	LDA.b #($0000>>8)|$00
	STA PPU.layer_3_tilemap
	
	; first digit is 2/4, second digit is 1/3
	LDA #$21
	STA PPU.layer_1_2_tiledata
	LDA #$43
	STA PPU.layer_3_4_tiledata
	
	LDA #$00
	STA PPU.main_screen
	STA PPU.sub_screen
	
	; insert any other init stuff here
	
	
	
	; put the main address here
	%set_pointer_rom(!main_pointer,template_main)
	%set_pointer_rom(!nmi_pointer,template_nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL
