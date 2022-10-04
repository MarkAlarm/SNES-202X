..collectable
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	RTS
	
...north
...south
...east
...west
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
	