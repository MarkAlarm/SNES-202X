..one_way_left
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	RTS
...north
...south
	JSR .move_y
	RTS
...east
	JSR .move_x
...west
	RTS
	