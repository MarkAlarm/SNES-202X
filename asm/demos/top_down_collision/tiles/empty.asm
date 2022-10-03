..empty
	JMP ...within : JMP ...left : JMP ...right : JMP ...up : JMP ...down
	
...within
	RTS
	
...left
...right
	JSR .move_x
	RTS
	
...up
...down
	JSR .move_y
	RTS
	