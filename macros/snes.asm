macro vram_write(source, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	LDA #<destaddr>
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[<channel>].settings
	LDA #<source>
	STA DMA[<channel>].source_word
	LDY.b #<source>>>16
	STY DMA[<channel>].source_bank
	LDA #<datasize>
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma
	
	PLP
endmacro

macro cgram_write(source, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDY #<destaddr>
	STY PPU.cgram_address
	
	LDA #$2202
	STA DMA[<channel>].settings
	LDA #<source>
	STA DMA[<channel>].source_word
	LDY.b #<source>>>16
	STY DMA[<channel>].source_bank
	LDA #<datasize>
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma
	
	PLP
endmacro

macro wram_write(source, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDA #$0000|<destaddr>
	STA WRAM.address
	LDY.b #$7E|<destaddr>>>16
	STY WRAM.high
	
	LDA #$8000
	STA DMA[<channel>].settings
	LDA #<source>
	STA DMA[<channel>].source_word
	LDY.b #<source>>>16
	STY DMA[<channel>].source_bank
	LDA #<datasize>
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma

	PLP
endmacro

macro vram_fill(value, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	LDA #<destaddr>
	STA PPU.vram_address
	
	LDA #$1809
	STA DMA[<channel>].settings
	LDA #fixed_bytes+<value>
	STA DMA[<channel>].source_word
	LDY.b #(fixed_bytes+<value>)>>16
	STY DMA[<channel>].source_bank
	LDA #<datasize>
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma
	
	PLP
endmacro

macro cgram_fill(value, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDY #<destaddr>
	STY PPU.cgram_address
	
	LDA #$220A
	STA DMA[<channel>].settings
	LDA #fixed_bytes+<value>
	STA DMA[<channel>].source_word
	LDY.b #(fixed_bytes+<value>)>>16
	STY DMA[<channel>].source_bank
	LDA #<datasize>
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma
	
	PLP
endmacro

macro wram_fill(value, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDA #$0000|<destaddr>
	STA WRAM.address
	LDY.b #$7E|<destaddr>>>16
	STY WRAM.high
	
	LDA #$8008
	STA DMA[<channel>].settings
	LDA #fixed_bytes+<value>
	STA DMA[<channel>].source_word
	LDY.b #(fixed_bytes+<value>)>>16
	STY DMA[<channel>].source_bank
	LDA #<datasize>
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma
	
	PLP
endmacro

macro oam_clear()
	PHP
	
	REP #$20
	SEP #$10
	
	LDX #$00
	LDY #$F0
	LDA #$0000
	STZ PPU.oam_address
	
	?-
	STX PPU.oam_data
	STY PPU.oam_data
	STX PPU.oam_data
	STX PPU.oam_data
	
	CLC : ADC #$0004
	CMP #$0200
	BNE ?-
	
	?-
	STX PPU.oam_data
	INC
	CMP #$0220
	BNE ?-
	
	PLP
endmacro

macro oam_mirror_clear()
	PHP
	
	SEP #$30
	
	LDX #$1F
	
	?-
	STZ !OAM_bit_size,x
	DEX
	BPL ?-
	
	REP #$10
	LDX #$01FF
	LDA #$F0
	
	?-
	STZ !OAM_start,x
	DEX
	STZ !OAM_start,x
	DEX
	STA !OAM_start,x
	DEX
	STZ !OAM_start,x
	DEX
	
	BPL ?-
	
	PLP
endmacro

macro oam_update(channel)
	PHP
	
	STZ PPU.oam_address
	
	REP #$20
	
	LDA #$0400
	STA DMA[<channel>].settings
	LDA #!OAM_start
	STA DMA[<channel>].source_word
	LDY.b #!OAM_start>>16
	STY DMA[<channel>].source_bank
	LDA #$0220
	STA DMA[<channel>].size
	
	LDY #$01<<(<channel>)
	STY CPU.enable_dma
	
	PLP
endmacro
