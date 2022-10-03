...one_way_up
	JSR .move_x
	
	LDA !player_direction
	AND #$08
	BEQ +
	
	JSR .move_y
	
	+
	RTS