init:
	; get rid of the comments after copy/pasted
	STZ CPU.interrupt_enable
	LDA #$8F
	STA PPU.screen
	
	; put the main address here
	%set_pointer_rom(!main_pointer,main)
	%set_pointer_rom(!nmi_pointer,nmi)
	%set_pointer_rom(!irq_pointer,irq)
	
	LDA #$0F
	STA PPU.screen
	LDA #$81
	STA CPU.interrupt_enable
	
	RTL
