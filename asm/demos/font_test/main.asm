font_test_main:
	; if start pressed, return to menu
	LDA controller[0].low_pressed
	AND #$10
	BNE +
	RTL
	
	+
	%set_pointer_rom(!main_pointer,menu_init)
	RTL
