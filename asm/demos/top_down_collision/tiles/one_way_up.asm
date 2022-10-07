..one_way_up
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	RTS
	
...north
	LDA #$08
	TSB !player_blocked
	RTS
	
...south
...east
...west
	RTS
	