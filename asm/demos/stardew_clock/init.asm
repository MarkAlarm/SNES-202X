init:
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
	
	; initialize graphics
	%upload_2bpp_gfx(generic_font,$3000)
	%vram_write(.init_tilemap,$5000,$0700,0)
	%wram_write(.init_tilemap,!layer_3_mirror,$0700,0)
	%cgram_write(smw_palette,$00,$0200,0)
	
	STZ PPU.cgram_address
	LDA #$00
	STA PPU.cgram_data
	LDA #$02
	STA PPU.cgram_data
	
	; initialize clock stuff
	
	REP #$20
	STZ !stardew_clock_tick
	LDA #$01A4
	STA !stardew_clock_tick_rate
	LDA #$0001
	STA !stardew_clock_days
	SEP #$20
	
	LDA #$01
	STA !stardew_clock_day_in_season
	STA !stardew_clock_years
	
	STZ !stardew_clock_time
	STZ !stardew_clock_am_pm
	STZ !stardew_clock_day_in_week
	
	STZ !stardew_clock_season
	STZ !stardew_clock_weather
	
	; put the main address here
	%set_pointer_rom(!main_pointer,stardew_clock_main)
	%set_pointer_rom(!nmi_pointer,stardew_clock_nmi)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL

.init_tilemap
	dw "                                "
	dw "  Stardew Valley Clock System   "
	dw "                                "
	dw " Tick: ----                     "
	dw " Tick Rate: ----                "
	dw "                                "
	dw " Time: -- / ----- -m            "
	dw " Day of Week: -- / ---          "
	dw " Day of Season: -- / ------     "
	dw "                                "
	dw " Total Days: ---- / ----        "
	dw " Total Years: -- / --           "
	dw "                                "
	dw " Weather: -- / -------          "
	dw "                                "
	dw "                                "
	dw "                                "
	dw " Press start to return to the   "
	dw " main menu.                     "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	
	; dw " </> = dec/inc tick rate        "
	; dw " ^/v = double/halve tick rate   "
	; dw " A = reset tick rate            "
	; dw "                                "
	; dw " L/R = change weather [TODO]    "
	; dw "                                "
	; dw " Select = pause [TODO]          "
	; dw " Start = return to main menu    "