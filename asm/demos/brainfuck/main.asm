main:
	PHB
	PHK
	PLB
	
	JSR .process_buttons
	JSR .prep_disp
	
	PLB
	
	RTL
	
.process_buttons
	; handle moving the index around the code/data menus
	LDA controller[0].low_pressed
	STA !scratch_0

	LDA !bf_edit_mode
	BNE ++
	
	LDA !scratch_0
	AND #$08
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	SEC : SBC #$0020
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$04
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	CLC : ADC #$0020
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$02
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	DEC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$01
	BEQ +++
	
	REP #$20
	LDA !bf_ins_edit_index
	INC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	BRA +++
	
	++
	LDA !scratch_0
	AND #$08
	BEQ +
	
	REP #$20
	LDA !bf_dat_edit_index
	SEC : SBC #$0020
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$04
	BEQ +
	
	REP #$20
	LDA !bf_dat_edit_index
	CLC : ADC #$0020
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$02
	BEQ +
	
	REP #$20
	LDA !bf_dat_edit_index
	DEC
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$01
	BEQ +++
	
	REP #$20
	LDA !bf_dat_edit_index
	INC
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+++
	; handle changing instructions/data values
	LDA !bf_edit_mode
	BNE +++
	
	LDA controller[0].high_pressed
	AND #$10
	BEQ ++
	
	REP #$10
	LDX !bf_ins_edit_index
	LDA !bf_ins_raw,x
	INC
	CMP #$09
	BCC +
	LDA #$00
	+
	STA !bf_ins_raw,x
	SEP #$10
	
	++
	LDA controller[0].high_pressed
	AND #$20
	BEQ ++++
	
	REP #$10
	LDX !bf_ins_edit_index
	LDA !bf_ins_raw,x
	DEC
	BPL +
	LDA #$08
	+
	STA !bf_ins_raw,x
	SEP #$10
	BRA ++++
	
	+++
	LDA controller[0].high_pressed
	AND #$10
	BEQ +
	
	REP #$10
	LDX !bf_dat_edit_index
	LDA !bf_dat_raw,x
	INC
	STA !bf_dat_raw,x
	SEP #$10
	
	+
	LDA controller[0].high_pressed
	AND #$20
	BEQ ++++
	
	REP #$10
	LDX !bf_dat_edit_index
	LDA !bf_dat_raw,x
	DEC
	STA !bf_dat_raw,x
	SEP #$10
	
	++++
	; handle menu swap and code execution
	LDA !scratch_0
	AND #$20
	BEQ +
	LDA !bf_edit_mode
	EOR #$01
	STA !bf_edit_mode
	
	+
	LDA !scratch_0
	AND #$10
	BEQ +
	JMP .execute_code
	
	+
	RTS

.prep_disp
	REP #$30
	
	LDX #$0000
	
	-
	LDA !bf_ins_raw,x
	AND #$00FF
	ASL
	TAY
	
	LDA ..ins_chars,y
	STA !scratch_0
	
	PHX
	TXA
	ASL
	TAX
	LDA !scratch_0
	STA !bf_ins_disp,x
	PLX
	
	INX
	CPX #$0200
	BCC -
	
	LDX #$0000
	
	-
	LDA !bf_dat_raw,x
	AND #$00FF
	STA !scratch_0
	
	PHX
	TXA
	ASL
	TAX
	LDA !scratch_0
	STA !bf_dat_disp,x
	PLX
	
	INX
	CPX #$0040
	BCC -
	
	LDX #$0000
	
	-
	LDA !bf_out_raw,x
	AND #$00FF
	STA !scratch_0
	
	PHX
	TXA
	ASL
	TAX
	LDA !scratch_0
	STA !bf_out_disp,x
	PLX
	
	INX
	CPX #$0080
	BCC -
	
	SEP #$30
	
	; now highlight the currently edited thing
	
	LDA !bf_edit_mode
	REP #$30
	BNE +
	
	LDA !bf_ins_edit_index
	ASL
	TAX
	INX
	
	SEP #$20
	LDA #$04
	STA !bf_ins_disp,x
	
	SEP #$30
	RTS
	
	+
	REP #$30
	
	LDA !bf_dat_edit_index
	ASL
	TAX
	INX
	
	SEP #$20
	LDA #$04
	STA !bf_dat_disp,x
	
	SEP #$30
	RTS
	
..ins_chars
	dw " +-<>[],."
	
.execute_code
	; lol
	RTS