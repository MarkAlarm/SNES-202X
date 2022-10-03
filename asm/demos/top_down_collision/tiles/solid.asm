...solid
	LDA !player_direction
	AND #$03
	BNE +
	
	JSR .move_x

	+
	LDA !player_direction
	AND #$0C
	BNE +
	
	JSR .move_y
	
	+
	RTS