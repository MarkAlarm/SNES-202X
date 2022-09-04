engine:
	; main loop
	LDA !nmi_done
	BPL engine
	
	; JSL to the main pointer (RTL returns to the +)
	LDA #(+)>>16
	PHA
	PEA.w (+)-1
	
	JML [!main_pointer]
	
	+
	STZ !nmi_done
	JMP engine

null_pointer:
	RTL
