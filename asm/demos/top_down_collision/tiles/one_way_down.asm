..one_way_down
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	RTS
...north
	JSR .move_y
	RTS
...south
	RTS
...east
...west
	JSR .move_x
	RTS
	