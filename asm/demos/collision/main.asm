; todo
; make block table so each thing right it does a different thing
; each block should have:
; collide left
; collide right
; collide top
; collide bottom


main:
	PHB
	PHK
	PLB
	
	JSR .graphics
	
	JSR .move
	JSR .input
	
	JSR .collide_y
	JSR .gravity
	JSR .ceiling
	
	JSR .collide_x
	JSR .walls
	
	PLB
	RTL
	
.graphics
	LDY #$00
	LDX #$00
	
	-
	LDA !collision_player_x_pos_low
	STA !OAM_x,y
	LDA !collision_player_y_pos_low
	CLC : ADC ..y_offsets,x
	STA !OAM_y,y
	LDA ..tiles,x
	STA !OAM_tile,y
	LDA #%00110000
	STA !OAM_props,y
	
	LDA #$00
	STA !OAM_size,y
	
	INY #4
	DEX
	BPL -
	
	RTS
	
..y_offsets
	db $00
	
..tiles
	db $08
	
.collide_x
	STZ !scratch_4
	STZ !scratch_5
	
	REP #$10
	
	LDX !collision_player_x_spd
	BNE +
	
	SEP #$10
	RTS
	
	+
	BMI +
	INC !scratch_4
	
	+
	SEP #$10
	
	LDA #$03
	TRB !collision_player_blocked
	
	LDY #$02
	-
	LDX !scratch_4
	
	LDA !collision_player_x_pos_low
	CLC : ADC ..x_interact_points,x
	LSR #3
	STA !scratch_0
	STZ !scratch_1
	
	LDA #$00
	XBA
	LDA !collision_player_y_pos_low
	CLC : ADC ..y_interact_points,y
	AND #$F8
	REP #$30
	ASL #2
	CLC : ADC !scratch_0
	TAX
	
	SEP #$20
	LDA !collision_interaction_table,x
	SEP #$10
	BEQ +
	INC !scratch_5
	
	+
	DEY
	BPL -
	
	LDA !scratch_5
	CMP #$02
	BCC +
	
	LDX !scratch_4
	LDA ..blocked_flags,x
	TSB !collision_player_blocked
	
	+
	RTS
	
..x_interact_points
	db !collision_player_x_left,!collision_player_x_right
	
..y_interact_points
	db !collision_player_y_top,!collision_player_y_middle,!collision_player_y_bottom
	
..blocked_flags
	db $02,$01
	
.collide_y
	STZ !scratch_4
	STZ !scratch_5
	
	REP #$10
	
	LDX !collision_player_y_spd
	BNE +
	
	SEP #$10
	RTS
	
	+
	BMI +
	INC !scratch_4
	
	+
	SEP #$10
	
	LDA #$0C
	TRB !collision_player_blocked
	
	LDY #$02
	-
	LDA !collision_player_x_pos_low
	CLC : ADC ..x_interact_points,y
	LSR #3
	STA !scratch_0
	STZ !scratch_1
	
	LDX !scratch_4
	
	LDA #$00
	XBA
	LDA !collision_player_y_pos_low
	CLC : ADC ..y_interact_points,x
	AND #$F8
	REP #$30
	ASL #2
	CLC : ADC !scratch_0
	TAX
	
	SEP #$20
	LDA !collision_interaction_table,x
	SEP #$10
	BEQ +
	INC !scratch_5
	
	+
	DEY
	BPL -
	
	LDA !scratch_5
	CMP #$02
	BCC +
	
	LDX !scratch_4
	LDA ..blocked_flags,x
	TSB !collision_player_blocked
	
	+
	RTS
	
..x_interact_points
	db !collision_player_x_left,!collision_player_x_middle,!collision_player_x_right
	
..y_interact_points
	db !collision_player_y_top,!collision_player_y_bottom
	
..blocked_flags
	db $08,$04
	
.walls
	LDA !collision_player_blocked
	AND #$03
	BNE +
	RTS
	
	+
	ASL
	TAY
	
	REP #$20
	LDA !collision_player_x_pos
	AND #$F8FF
	CLC : ADC ..position_offsets,y
	STA !collision_player_x_pos
	SEP #$20
	
	RTS
	
..position_offsets
	dw $0000,!collision_player_x_left<<8,!collision_player_x_right<<8,$0000
	
.gravity
	LDA !collision_player_blocked
	AND #$04
	BEQ +
	
	REP #$20
	LDA !collision_player_y_pos
	AND #$F8FF
	CLC : ADC.w #!collision_player_y_top<<8
	STA !collision_player_y_pos
	LDA #$0100
	STA !collision_player_y_spd
	SEP #$20
	
	RTS
	
	+
	REP #$20
	LDA !collision_player_y_spd
	BPL +
	
	CLC : ADC #$0060
	STA !collision_player_y_spd
	SEP #$20
	RTS
	
	+
	CMP #$0600
	BCS +
	
	CLC : ADC #$0060
	STA !collision_player_y_spd
	SEP #$20
	RTS
	
	+
	LDA #$0600
	STA !collision_player_y_spd
	SEP #$20
	RTS
	
.ceiling
	LDA !collision_player_blocked
	AND #$08
	BEQ +
	
	REP #$20
	LDA !collision_player_y_pos
	AND #$F8FF
	CLC : ADC.w #!collision_player_y_bottom<<8
	STA !collision_player_y_pos
	LDA #$0001
	STA !collision_player_y_spd
	SEP #$20
	
	+
	RTS
	
.input
	LDA controller[0].high_pressed
	BPL +
	
	LDA !collision_player_blocked
	AND #$04
	BEQ +
	
	REP #$20
	LDA #$FA40
	STA !collision_player_y_spd
	SEP #$20
	
	+
	LDA controller[0].low_held
	AND #$03
	ASL
	TAX
	
	REP #$20
	LDA ..x_speeds,x
	STA !collision_player_x_spd
	SEP #$20
	
	+
	RTS
	
..x_speeds
	dw $0000,$0200,$FE00,$0000
	
.move
	REP #$20
	
	LDA !collision_player_x_pos
	CLC : ADC !collision_player_x_spd
	STA !collision_player_x_pos
	
	LDA !collision_player_y_pos
	CLC : ADC !collision_player_y_spd
	STA !collision_player_y_pos
	
	SEP #$20
	
	RTS
