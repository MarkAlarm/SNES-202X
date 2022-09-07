nmi:
	REP #$30
	LDA controller[2].disable
	EOR #$FFFF
	AND CPU.port_2_data_2
	STA !scratch_0
	TAX
	EOR controller[2].held
	AND controller[2].held
	STA controller[2].released
	TXA
	EOR controller[2].held
	AND !scratch_0
	STA controller[2].pressed
	STX controller[2].held
	SEP #$30
	
	LDA #$80
	TRB CPU.output_port
	
	LDA #$01
	STA joypad.port_0
	STZ joypad.port_0
	
	REP #$30
	LDX #$0010
	STZ !scratch_0
	
	-
	LDA joypad.port_1
	LSR
	ROL !scratch_0
	
	DEX
	BNE -
	
	LDA controller[3].disable
	EOR #$FFFF
	AND !scratch_0
	STA !scratch_0
	TAX
	EOR controller[3].held
	AND controller[3].held
	STA controller[3].released
	TXA
	EOR controller[3].held
	AND !scratch_0
	STA controller[3].pressed
	STX controller[3].held
	
	SEP #$30
	
	LDA #$80
	TSB CPU.output_port
	
	%vram_write(!four_controllers_hud,$5000,$0700,0)
	RTL