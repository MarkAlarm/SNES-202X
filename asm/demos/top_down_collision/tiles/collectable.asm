..collectable
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	LDA #$80
	TSB !player_blocked
	BRA ...collect
	
...north
	LDA #$04
	TSB !player_blocked
	BRA ...collect
	
...south
	LDA #$08
	TSB !player_blocked
	BRA ...collect
	
...east
	LDA #$02
	TSB !player_blocked
	BRA ...collect
	
...west
	LDA #$01
	TSB !player_blocked
	
...collect
	LDA controller[0].high_pressed
	AND #$80
	BEQ +
	
	REP #$10
	LDX !player_tile_index
	LDA #$00
	STA !collision_interaction_table,x
	SEP #$10
	
	+
	RTS