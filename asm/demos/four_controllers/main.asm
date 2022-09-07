main:
	PHB
	PHK
	PLB
	
	REP #$30
	
	LDY #$0016
	-
	LDA .button_tiles_not_held,y
	STA !scratch_0
	
	LDA controller[0].held
	AND .button_checks,y
	BEQ +
	LDA .button_tiles_held,y
	STA !scratch_0
	
	+
	LDX .hud_offsets,y
	LDA !scratch_0
	STA !four_controllers_hud+!four_controllers_P1_index,x
	
	DEY
	DEY
	BPL -
	
	LDY #$0016
	-
	LDA .button_tiles_not_held,y
	STA !scratch_0
	
	LDA controller[1].held
	AND .button_checks,y
	BEQ +
	LDA .button_tiles_held,y
	STA !scratch_0
	
	+
	LDX .hud_offsets,y
	LDA !scratch_0
	STA !four_controllers_hud+!four_controllers_P2_index,x
	
	DEY
	DEY
	BPL -
	
	LDY #$0016
	-
	LDA .button_tiles_not_held,y
	STA !scratch_0
	
	LDA controller[2].held
	AND .button_checks,y
	BEQ +
	LDA .button_tiles_held,y
	STA !scratch_0
	
	+
	LDX .hud_offsets,y
	LDA !scratch_0
	STA !four_controllers_hud+!four_controllers_P3_index,x
	
	DEY
	DEY
	BPL -
	
	LDY #$0016
	-
	LDA .button_tiles_not_held,y
	STA !scratch_0
	
	LDA controller[3].held
	AND .button_checks,y
	BEQ +
	LDA .button_tiles_held,y
	STA !scratch_0
	
	+
	LDX .hud_offsets,y
	LDA !scratch_0
	STA !four_controllers_hud+!four_controllers_P4_index,x
	
	DEY
	DEY
	BPL -
	
	SEP #$30
	
	PLB
	RTL
	
; button layout:

; +----------+
; | ^  LR  X |
; |< >    Y A|
; | v  ET  B |
; +----------+

; offsets for each button's location on the HUD
.hud_offsets
	dw $0002,$0008,$000A,$0010
	dw $0040,$0044,$004E,$0052
	dw $0082,$0088,$008A,$0090
	
.button_checks
	dw $0800,$0020,$0010,$0040
	dw $0200,$0100,$4000,$0080
	dw $0400,$2000,$1000,$8000

.button_tiles_not_held
	dw $0054,$0056,$4056,$0052
	dw $0055,$4055,$0052,$0052
	dw $8054,$0053,$0053,$0052
	
.button_tiles_held
	dw $0064,$0066,$4066,$0062
	dw $0065,$4065,$0062,$0062
	dw $8064,$0063,$0063,$0062
