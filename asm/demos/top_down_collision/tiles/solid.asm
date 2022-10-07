..solid
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	LDA #$80
	TSB !player_blocked
	RTS
	
...north
	LDA #$04
	TSB !player_blocked
	RTS
	
...south
	LDA #$08
	TSB !player_blocked
	RTS
	
...east
	LDA #$02
	TSB !player_blocked
	RTS
	
...west
	LDA #$01
	TSB !player_blocked
	RTS
	