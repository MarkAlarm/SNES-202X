...one_way_right
	JSR .move_y
	
	LDA !player_direction
	AND #$01
	BEQ +
	
	JSR .move_x
	
	+
	RTS