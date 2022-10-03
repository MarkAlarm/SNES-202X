.tiles
	dw ..empty,..solid,..empty,..death,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty
	dw ..one_way_up,..one_way_down,..one_way_left,..one_way_right,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty
	
incsrc "empty.asm"
incsrc "solid.asm"
incsrc "death.asm"
incsrc "one_way_up.asm"
incsrc "one_way_down.asm"
incsrc "one_way_left.asm"
incsrc "one_way_right.asm"
