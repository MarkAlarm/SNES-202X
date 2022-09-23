main:
	PHB
	PHK
	PLB
	
	JSR .player_gfx
	JSR .move
	
	PLB
	RTL

.player_gfx
	LDY #$00
	LDX #$00
	
	LDA !player_x_pos_low
	STA !OAM_x,y
	LDA !player_y_pos_low
	STA !OAM_y,y
	
	LDA !frame_counter
	LSR #3
	AND #$03
	STA !scratch_0
	LDA !player_direction
	ASL #2
	CLC : ADC !scratch_0
	TAX
	
	LDA ..anim_tiles,x
	STA !OAM_tile,y
	
	LDA #$3E
	STA !OAM_props,y
	
	TYA
	LSR #2
	TAY
	
	LDA #$00
	STA !OAM_size,y
	
	RTS
	
	
..anim_tiles
	db $61,$64,$67,$6A		; ----
	db $62,$65,$68,$6B		; ---r
	db $60,$63,$66,$69		; --l-
	db $61,$64,$67,$6A		; --lr
	db $71,$74,$77,$7A		; -d--
	db $72,$75,$78,$7B		; -d-r
	db $70,$73,$76,$79		; -dl-
	db $71,$74,$77,$7A		; -dlr
	db $51,$54,$57,$5A		; u---
	db $52,$55,$58,$5B		; u--r
	db $50,$53,$56,$59		; u-l-
	db $51,$54,$57,$5A		; u-lr
	db $61,$64,$67,$6A		; ud--
	db $62,$65,$68,$6B		; ud-r
	db $60,$63,$66,$69		; udl-
	db $61,$64,$67,$6A		; udlr

.move
	LDA controller[0].low_held
	AND #$03
	TAY
	
	LDA !player_x_pos_low
	CLC : ADC ..x_checks,y
	AND #$F8
	LSR #3
	STA !scratch_0
	STZ !scratch_1
	
	LDA controller[0].low_held
	AND #$0C
	LSR #2
	TAY
	
	LDA #$00
	XBA
	LDA !player_y_pos_low
	CLC : ADC ..y_checks,y
	AND #$F8
	
	REP #$30
	ASL #2
	CLC : ADC !scratch_0
	STA !player_tile_index
	TAX
	SEP #$30
	
	LDA controller[0].low_held
	AND #$0F
	STA !player_direction
	TAX
	
	LDA ..x_movements,x
	CLC : ADC !player_x_pos_low
	STA !player_x_pos_low
	
	LDA ..y_movements,x
	CLC : ADC !player_y_pos_low
	STA !player_y_pos_low
	
	+
	RTS
	
..x_checks
	db !player_x_middle,!player_x_right,!player_x_left,!player_x_middle
	
..y_checks
	db !player_y_middle,!player_y_bottom,!player_y_top,!player_y_middle
	
..x_movements
	db $00,$01,$FF,$00
	db $00,$01,$FF,$00
	db $00,$01,$FF,$00
	db $00,$01,$FF,$00

..y_movements
	db $00,$00,$00,$00
	db $01,$01,$01,$01
	db $FF,$FF,$FF,$FF
	db $00,$00,$00,$00
	