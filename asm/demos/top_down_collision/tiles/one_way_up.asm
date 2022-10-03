..one_way_up
	JMP ...within : JMP ...left : JMP ...right : JMP ...up : JMP ...down
	
...within
	RTS
	
...left
...right
	JSR .move_x
	RTS
	
...down
	JSR .move_y
...up
	RTS
	