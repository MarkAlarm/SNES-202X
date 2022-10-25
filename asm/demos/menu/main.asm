main:
	PHB
	PHK
	PLB
	
	; use dpad to select an option
	LDA !menu_current_option
	STA !menu_previous_option
	AND #$01
	STA !scratch_0
	LDA !menu_previous_option
	AND #$0E
	STA !scratch_1

	LDA controller[0].low_pressed
	AND #$03
	BEQ +
	CMP #$03
	BEQ +
	
	LDA !scratch_0
	EOR #$01
	STA !scratch_0
	
	+
	LDA controller[0].low_pressed
	AND #$0C
	BEQ ++
	CMP #$0C
	BEQ ++
	
	CMP #$08
	BEQ +

	LDA !scratch_1
	CLC : ADC #$02
	AND #$0E
	STA !scratch_1
	BRA ++
	
	+
	LDA !scratch_1
	SEC : SBC #$02
	AND #$0E
	STA !scratch_1
	
	++
	LDA !scratch_0
	CLC : ADC !scratch_1
	STA !menu_current_option
	
	; clear previous highlight
	LDA !menu_previous_option
	ASL
	TAX
	
	REP #$20
	LDA .option_offset_bottom,x
	STA !scratch_0
	LDA .option_offset_top,x
	STA !scratch_2
	SEP #$20
	
	REP #$10
	LDX !scratch_2
	LDA #$00
	
	-
	STA !layer_3_mirror,x
	DEX #2
	CPX !scratch_0
	BPL -
	
	SEP #$10
	
	; set current highlight
	LDA !menu_current_option
	ASL
	TAX
	
	REP #$20
	LDA .option_offset_bottom,x
	STA !scratch_0
	LDA .option_offset_top,x
	STA !scratch_2
	SEP #$20
	
	REP #$10
	LDX !scratch_2
	LDA #$04
	
	-
	STA !layer_3_mirror,x
	DEX #2
	CPX !scratch_0
	BPL -
	
	SEP #$10
	
	; if start pressed, execute the selected option
	LDA controller[0].low_pressed
	AND #$10
	BNE +
	
	PLB
	RTL
	
	+
	LDA !menu_current_option
	ASL
	CLC : ADC !menu_current_option
	TAX
	
	REP #$20
	LDA .option_main_pointers,x
	STA !scratch_0
	SEP #$20
	
	LDA .option_main_pointers+2,x
	STA !scratch_2
	
	%set_pointer_ram(!main_pointer,!scratch_0)
	%set_pointer_rom(!nmi_pointer,empty_pointer)
	%set_pointer_rom(!irq_pointer,empty_pointer)

	PLB
	RTL

.option_offset_bottom
	dw $0100,$0120,$0140,$0160,$0180,$01A0,$01C0,$01E0
	dw $0200,$0220,$0240,$0260,$0280,$02A0,$02C0,$02E0

.option_offset_top
	dw $011F,$013F,$015F,$017F,$019F,$01BF,$01DF,$01FF
	dw $021F,$023F,$025F,$027F,$029F,$02BF,$02DF,$02FF
	
.option_main_pointers
	dl collision_init,dual_controllers_init
	dl font_test_init,four_controllers_init
	dl stardew_clock_init,menu_init
	dl gfx_demo_1_init,math_init
	dl menu_init,top_down_collision_init
	dl brainfuck_init,menu_init
	dl menu_init,menu_init
	dl menu_init,null_pointer
