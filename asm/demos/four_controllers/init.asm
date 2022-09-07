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
	
	STZ PPU.cgram_address
	LDA #$80
	STA PPU.cgram_data
	LDA #$5D
	STA PPU.cgram_data
	
	%vram_fill($00,$0000,$0000,0)
	%upload_2bpp_gfx(generic_font,$3000)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%wram_write(.init_tilemap,!four_controllers_hud,$0700,0)
	%set_pointer_rom(!main_pointer,four_controllers_main)
	%set_pointer_rom(!nmi_pointer,four_controllers_nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	PLB
	RTL
	
.init_tilemap
	dw "                                "
	dw "    < Raw Controller Input >    "
	dw "                                "
	dw "  Controller 1    Controller 2  "
	dw "                                "
	dw "  +----------+    +----------+  "
	dw "  | -  --  - |    | -  --  - |  "
	dw "  |- -    - -|    |- -    - -|  "
	dw "  | -  --  - |    | -  --  - |  "
	dw "  +----------+    +----------+  "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "  Controller 3    Controller 4  "
	dw "                                "
	dw "  +----------+    +----------+  "
	dw "  | -  --  - |    | -  --  - |  "
	dw "  |- -    - -|    |- -    - -|  "
	dw "  | -  --  - |    | -  --  - |  "
	dw "  +----------+    +----------+  "
	dw "                                "
	dw "                                "
	dw "                                "
	dw " If you do not have a multitap  "
	dw " plugged in, this will not      "
	dw " display the inputs correctly.  "
	dw " Be sure to plug one in first.  "
	dw "                                "
