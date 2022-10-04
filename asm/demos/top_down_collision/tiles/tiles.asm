.tiles
	dw ..empty,..solid,..collectable,..death,..post,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty
	dw ..one_way_up,..one_way_down,..one_way_left,..one_way_right,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty,..empty
	
incsrc "empty.asm"
incsrc "solid.asm"
incsrc "collectable.asm"
incsrc "death.asm"
incsrc "post.asm"
incsrc "one_way_up.asm"
incsrc "one_way_down.asm"
incsrc "one_way_left.asm"
incsrc "one_way_right.asm"

