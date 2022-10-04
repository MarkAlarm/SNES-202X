macro set_pointer_rom(pointer, destaddr)
	PHP
	
	REP #$20
	LDA #<destaddr>
	STA <pointer>
	SEP #$30
	LDY.b #<destaddr>>>16
	STY <pointer>+2
	
	PLP
endmacro

macro set_pointer_ram(pointer, destaddr)
	PHP
	
	REP #$20
	LDA <destaddr>
	STA <pointer>
	SEP #$30
	LDY <destaddr>+2
	STY <pointer>+2
	
	PLP
endmacro

macro upload_2bpp_gfx(source, destaddr)
	%vram_write(<source>,<destaddr>,$0800,0)
endmacro

macro upload_4bpp_gfx(source, destaddr)
	%vram_write(<source>,<destaddr>,$1000,0)
endmacro

macro upload_palette(source)
	%cgram_write(<source>,$00,$0200,0)
endmacro

macro brk()
	BRK #$00
endmacro

macro cop()
	COP #$02
endmacro

macro wdm()
	WDM #$42
endmacro
