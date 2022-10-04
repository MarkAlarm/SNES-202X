..post
	JMP ...within : JMP ...north : JMP ...south : JMP ...east : JMP ...west
	
...within
...north
	RTS
...south
	LDA controller[0].high_pressed
	AND #$80
	BEQ +
	
	; read sign here
	
	+
	RTS
...east
...west
	RTS
	