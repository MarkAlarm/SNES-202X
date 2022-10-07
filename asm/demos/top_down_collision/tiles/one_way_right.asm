..one_way_right
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
...north
...south
	RTS
	
...east
	LDA #$02
	TSB !player_blocked
	RTS
	
...west
	RTS
	