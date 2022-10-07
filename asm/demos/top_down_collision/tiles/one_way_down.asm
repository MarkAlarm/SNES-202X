..one_way_down
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
...north
	RTS
	
...south
	LDA #$04
	TSB !player_blocked
	RTS
	
...east
...west
	RTS
	