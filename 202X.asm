optimize dp always
optimize address mirrors
math pri on
lorom

padbyte $00

; defines, registers, etc (dummy org)
org $008000
	incsrc "registers/apu.asm"
	incsrc "registers/cpu.asm"
	incsrc "registers/dma.asm"
	incsrc "registers/dsp.asm"
	incsrc "registers/ppu.asm"
	incsrc "registers/spc.asm"
	incsrc "registers/wram.asm"
	
	incsrc "defines/global_ram_map.asm"
	
	incsrc "macros/snes.asm"
	incsrc "macros/spc.asm"
	incsrc "macros/misc.asm"

; SNES header and initial vector pointers
org $008000
	reset bytes
	
	incsrc "asm/vectors/brk_init.asm"
	incsrc "asm/vectors/cop_init.asm"
	incsrc "asm/vectors/irq_init.asm"
	incsrc "asm/vectors/nmi_init.asm"
	incsrc "asm/vectors/nmi_main.asm"
	incsrc "asm/vectors/reset_init.asm"
	incsrc "asm/vectors/reset_main.asm"
	
	incsrc "asm/engine.asm"
	incsrc "asm/fixed_bytes.asm"
	
	print "Bytes inserted in bank 0: ", bytes, "/32768"
	
	incsrc "asm/header.asm"

; graphics and palettes
org $018000
	reset bytes
	
	generic_font: incbin "graphics/global/fonts/generic.bin"
	
	collision_tileset: incbin "graphics/collision/tileset.bin"
	collision_sprites: incbin "graphics/collision/sprites.bin"
	
	gfx_demo_1_tileset: incbin "graphics/gfx_demo_1/tileset.bin"
	gfx_demo_1_player: incbin "graphics/gfx_demo_1/player.bin"
	gfx_demo_1_water_anim: incbin "graphics/gfx_demo_1/water.bin"
	
	smw_palette: incbin "palettes/smw.mw3"
	generic_palette: incbin "palettes/generic.mw3"
	
	print "Bytes inserted in bank 1: ", bytes, "/32768"
	
	pad $01FFFF
	
org $028000
	reset bytes
	
	incsrc "asm/demos/menu/menu.asm"
	incsrc "asm/demos/font_test/font_test.asm"
	
	print "Bytes inserted in bank 2: ", bytes, "/32768"
	
	pad $02FFFF
	
org $038000
	reset bytes
	
	incsrc "asm/demos/collision/collision.asm"
	
	print "Bytes inserted in bank 3: ", bytes, "/32768"
	
	pad $03FFFF
	
org $048000
	reset bytes
	
	incsrc "asm/demos/dual_controllers/dual_controllers.asm"
	incsrc "asm/demos/four_controllers/four_controllers.asm"
	
	print "Bytes inserted in bank 4: ", bytes, "/32768"
	
	pad $04FFFF
	
org $058000
	reset bytes
	
	incsrc "asm/demos/stardew_clock/stardew_clock.asm"
	
	print "Bytes inserted in bank 5: ", bytes, "/32768"
	
	pad $05FFFF
	
org $068000
	reset bytes
	
	incsrc "asm/demos/gfx_demo_1/gfx_demo_1.asm"
	
	print "Bytes inserted in bank 6: ", bytes, "/32768"
	
	pad $06FFFF
	
org $078000
	reset bytes
	
	print "Bytes inserted in bank 7: ", bytes, "/32768"
	
	pad $07FFFF
	
org $088000
	pad $08FFFF
	
org $098000
	pad $09FFFF
	
org $0A8000
	pad $0AFFFF

org $0B8000
	pad $0BFFFF
	
org $0C8000
	pad $0CFFFF
	
org $0D8000
	pad $0DFFFF
	
org $0E8000
	pad $0EFFFF
	
org $0F8000
	pad $0FFFFF
