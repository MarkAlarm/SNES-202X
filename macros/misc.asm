macro set_pointer_rom(pointer, destaddr)
	PHP
	
	REP #$20
	LDA #<destaddr>
	STA <pointer>
	SEP #$30
	LDY.b #<destaddr>>>16
	STY <pointer>+2
	
	PLP
endmacro

macro set_pointer_ram(pointer, destaddr)
	PHP
	
	REP #$20
	LDA <destaddr>
	STA <pointer>
	SEP #$30
	LDY <destaddr>+2
	STY <pointer>+2
	
	PLP
endmacro