..one_way_left
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
...north
...south
...east
	RTS
...west
	LDA #$01
	TSB !player_blocked
	RTS