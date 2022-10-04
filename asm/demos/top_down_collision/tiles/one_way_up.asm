..one_way_up
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	RTS
...north
	RTS
...south
	JSR .move_y
	RTS
...east
...west
	JSR .move_x
	RTS
	