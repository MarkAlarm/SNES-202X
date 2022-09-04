nmi_main:
	PHB
	PHK
	PLB
	
	SEP #$20
	
	; read nmi flag without modifying registers
	BIT CPU.nmi_flag
	
	BIT.w !nmi_done
	BPL +
	
	PLB
	RTI
	
	+
	; do the generic, global operations first
	REP #$20
	INC !frame_counter
	SEP #$20
	
	JSR .poll_controllers
	
	; JSL to the nmi pointer (RTL returns to the +)
	LDA #(+)>>16
	PHA
	PEA.w (+)-1
	
	JML [!nmi_pointer]
	
	+
	LDA #$FF
	STA !nmi_done
	
	PLB
	RTI

.poll_controllers
	LDA CPU.ppu_status
	AND #$01
	BNE .poll_controllers

	REP #$30
	
	LDA controller[0].disable
	EOR #$FFFF
	AND CPU.port_1_data_1
	STA !scratch_0
	TAX
	EOR controller[0].held
	AND controller[0].held
	STA controller[0].released
	TXA
	EOR controller[0].held
	AND !scratch_0
	STA controller[0].pressed
	STX controller[0].held
	
	LDA controller[1].disable
	EOR #$FFFF
	AND CPU.port_2_data_1
	STA !scratch_0
	TAX
	EOR controller[1].held
	AND controller[1].held
	STA controller[1].released
	TXA
	EOR controller[1].held
	AND !scratch_0
	STA controller[1].pressed
	STX controller[1].held
	
	SEP #$30
	
	RTS
