...one_way_left
	JSR .move_y
	
	LDA !player_direction
	AND #$02
	BEQ +
	
	JSR .move_x
	
	+
	RTS