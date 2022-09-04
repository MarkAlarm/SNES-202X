reset_init:
	CLC
	XCE
	
	LDA #$01
	STA CPU.rom_speed
	
	JML reset_main
