..one_way_right
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
	RTS
...north
...south
	JSR .move_y
...east
	RTS
...west
	JSR .move_x
	RTS
	