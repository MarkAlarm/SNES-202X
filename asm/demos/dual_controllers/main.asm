dual_controllers_main:
	; copy the mirror upward by one row
	REP #$30
	LDA #$06BF
	LDX #!layer_3_mirror+$40
	LDY #!layer_3_mirror
	MVN $7E7E
	SEP #$10
	
	PHB
	PHK
	PLB
	
	; controller 1
	LDX #$04
	LDY #$00
	
	-
	LDA .button_default
	STA !scratch_0
	
	SEP #$20
	LDA controller[0].low_pressed
	AND .button_checks,y
	BEQ +
	
	REP #$20
	LDA .button_labels,x
	STA !scratch_0
	
	+
	REP #$20
	LDA !scratch_0
	STA !layer_3_mirror+$06C0,x
	
	INY
	INX #2
	CPX #$14
	BCC -
	
	LDY #$00
	-
	LDA .button_default
	STA !scratch_0
	
	SEP #$20
	LDA controller[0].high_pressed
	AND .button_checks,y
	BEQ +
	
	REP #$20
	LDA .button_labels,x
	STA !scratch_0
	
	+
	REP #$20
	LDA !scratch_0
	STA !layer_3_mirror+$06C0,x
	
	INY
	INX #2
	CPX #$1C
	BCC -
	
	; controller 2
	LDX #$04
	LDY #$00
	
	-
	LDA .button_default
	STA !scratch_0
	
	SEP #$20
	LDA controller[1].low_pressed
	AND .button_checks,y
	BEQ +
	
	REP #$20
	LDA .button_labels,x
	STA !scratch_0
	
	+
	REP #$20
	LDA !scratch_0
	STA !layer_3_mirror+$06E0,x
	
	INY
	INX #2
	CPX #$14
	BCC -
	
	LDY #$00
	-
	LDA .button_default
	STA !scratch_0
	
	SEP #$20
	LDA controller[1].high_pressed
	AND .button_checks,y
	BEQ +
	
	REP #$20
	LDA .button_labels,x
	STA !scratch_0
	
	+
	REP #$20
	LDA !scratch_0
	STA !layer_3_mirror+$06E0,x
	
	INY
	INX #2
	CPX #$1C
	BCC -
	
	SEP #$20

	PLB
	RTL
	
.button_checks
	db $80,$40,$20,$10,$08,$04,$02,$01

.button_default
	dw "-"
	
.button_labels
	dw "  BYET^v<>AXLR"
