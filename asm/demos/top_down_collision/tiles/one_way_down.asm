...one_way_down
	JSR .move_x

	LDA !player_direction
	AND #$04
	BEQ +
	
	JSR .move_y
	
	+
	RTS