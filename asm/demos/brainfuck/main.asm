main:
	PHB
	PHK
	PLB
	
	JSR .process_buttons
	JSR .prep_disp
	
	PLB
	
	RTL
	
.process_buttons
	RTS

.prep_disp
	REP #$30
	
	LDX #$0000
	
	-
	LDA !bf_ins_raw,x
	ASL
	TAY
	LDA ..ins_chars,y
	AND #$00FF
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
	
	RTS
	
..ins_chars
	dw " +-<>[],."
	