main:
	JSR lcg_rng
	RTL

lcg_rng:
	LDA !lcg_rng_input
	STA CPU.multiplicand
	LDA #!lcg_rng_multiplier
	STA CPU.multiplier
	
	NOP #4
	
	REP #$20
	LDA CPU.product
	STA CPU.dividend
	SEP #$20
	
	LDA #!lcg_rng_modulo
	STA CPU.divisor
	
	NOP #8
	
	LDA CPU.remainder_low
	STA !lcg_rng_input
	STA !lcg_rng_output
	
	REP #$30
	LDA !lcg_rng_index
	ASL
	TAX
	SEP #$20
	
	LDA !lcg_rng_output
	LSR #4
	STA !layer_3_mirror,x
	LDA !lcg_rng_output
	AND #$0F
	STA !layer_3_mirror+2,x
	
	REP #$20
	INC !lcg_rng_index
	INC !lcg_rng_index
	SEP #$30

	RTS