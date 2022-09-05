menu_nmi:
	PHB
	PHK
	PLB
	
	; update the previous option (clear highlight)
	LDA !menu_previous_option
	ASL
	TAX

	PHP
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	
	LDA .option_vram_strips,x
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #!layer_3_mirror
	CLC : ADC .option_mirror_offsets,x
	STA DMA[0].source_word
	LDY.b #!layer_3_mirror>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	PLP
	
	; update the current option (highlight it)
	LDA !menu_current_option
	ASL
	TAX

	PHP
	REP #$20
	SEP #$10
	
	LDY #$80
	STY PPU.vram_control
	
	LDA .option_vram_strips,x
	STA PPU.vram_address
	
	LDA #$1801
	STA DMA[0].settings
	LDA #!layer_3_mirror
	CLC : ADC .option_mirror_offsets,x
	STA DMA[0].source_word
	LDY.b #!layer_3_mirror>>16
	STY DMA[0].source_bank
	LDA #$0020
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	PLP
	
	; display description
	REP #$20
	LDA #.empty_description
	STA !scratch_0
	SEP #$20
	
	LDY #.empty_description>>16
	STY !scratch_2
	
	LDA controller[0].low_held
	AND #$20
	BEQ +
	
	LDA !menu_current_option
	ASL
	TAX
	
	REP #$20
	LDA .description_pointers,x
	STA !scratch_0
	SEP #$20
	
	+
	REP #$20
	
	LDY #$80
	STY PPU.vram_control
	
	LDA #$5260
	STA PPU.vram_address
	LDA #$1801
	STA DMA[0].settings
	LDA !scratch_0
	STA DMA[0].source_word
	LDY !scratch_2
	STY DMA[0].source_bank
	LDA #$0100
	STA DMA[0].size
	
	LDY #$01
	STY CPU.enable_dma
	SEP #$20
	
	PLB
	RTL

.option_vram_strips
	dw $5080,$5090,$50A0,$50B0,$50C0,$50D0,$50E0,$50F0
	dw $5100,$5110,$5120,$5130,$5140,$5150,$5160,$5170
	
.option_mirror_offsets
	dw $0100,$0120,$0140,$0160,$0180,$01A0,$01C0,$01E0
	dw $0200,$0220,$0240,$0260,$0280,$02A0,$02C0,$02E0
	
.empty_description
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "

.description_pointers
	dw ..collision_description,..dual_controllers_description
	dw ..font_test_description,..four_controllers_description
	dw ..stardew_clock_description,..inventory_description
	dw ..unused_option_description,..unused_option_description
	dw ..unused_option_description,..unused_option_description
	dw ..unused_option_description,..unused_option_description
	dw ..unused_option_description,..unused_option_description
	dw ..unused_option_description,..null_description
	
..collision_description
	dw " A simple collision test with   "
	dw " an 8x8 sprite and a static     "
	dw " test chamber.                  "
	dw "                                "
	
..dual_controllers_description
	dw " Controller demo that displays  "
	dw " their inputs rolling up the    "
	dw " screen line by line.           "
	dw "                                "
	
..font_test_description
	dw " A very basic font test, which  "
	dw " just displays all of the       "
	dw " possible characters that may   "
	dw " be used or needed in a font.   "
	
..four_controllers_description
	dw " Moreso a multitap demo, which  "
	dw " processes up to four           "
	dw " controllers simultaenously,    "
	dw " each with a separate display.  "
	
..stardew_clock_description
	dw " A basic clone of the Stardew   "
	dw " Valley clock/time system,      "
	dw " along with a display and means "
	dw " to change its processing rate. "
	
..inventory_description
	dw " Placeholder for an inventory   "
	dw " system, will probably take     "
	dw " inspiration from Pokemon or    "
	dw " Minecraft.                     "
	
..unused_option_description
	dw " An unused option that as of    "
	dw " right now, does nothing.       "
	dw " Selecting this will leave you  "
	dw " in this menu.                  "
	
..null_description
	dw " An intentional option that     "
	dw " freezes this menu by setting   "
	dw " the engine's main pointer to a "
	dw " null/empty routine.            "
