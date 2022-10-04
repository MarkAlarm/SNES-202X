..empty
	JMP ...within : JMP ...up : JMP ...down : JMP ...left : JMP ...right
	
...within
	RTS
	
...up
...down
	JSR .move_y
	RTS
	
...left
...right
	JSR .move_x
	RTS
	