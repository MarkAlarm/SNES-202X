main:
	PHB
	PHK
	PLB
	
	JSR .highlight_option
	
	LDA !frame_counter_low
	AND #$03
	BNE +
	JSR .update_inputs
	
	+
	JSR .execute_operation
	JSR .update_display
	
	PLB
	RTL
	
.highlight_option
	; clear previous highlight
	LDA !math_current_option
	ASL
	TAX
	LDY #$00
	
	REP #$30
	LDA ..option_mirror_offsets,x
	TAX
	
	-
	LDA !layer_3_mirror,x
	AND #$00FF
	STA !layer_3_mirror,x
	
	INX #2
	INY #2
	CPY #$0020
	BCC -
	SEP #$30
	
	LDA !math_current_option
	AND #$01
	STA !scratch_0
	LDA !math_current_option
	AND #$0E
	STA !scratch_1
	
	; get current option
	LDA controller[0].high_held
	AND #$40
	BEQ ++
	
	LDA controller[0].low_pressed
	AND #$03
	BEQ +
	CMP #$03
	BEQ +
	
	LDA !scratch_0
	EOR #$01
	STA !scratch_0
	
	+
	LDA controller[0].low_pressed
	AND #$0C
	BEQ ++
	CMP #$0C
	BEQ ++
	
	CMP #$08
	BEQ +
	
	LDA !scratch_1
	CLC : ADC #$02
	AND #$0E
	STA !scratch_1
	BRA ++
	
	+
	LDA !scratch_1
	SEC : SBC #$02
	AND #$0E
	STA !scratch_1
	
	++
	LDA !scratch_0
	CLC : ADC !scratch_1
	STA !math_current_option
	
	; highlight current option
	LDA !math_current_option
	ASL
	TAX
	LDY #$00
	
	REP #$30
	LDA ..option_mirror_offsets,x
	TAX
	
	-
	LDA !layer_3_mirror,x
	AND #$00FF
	ORA #$0400
	STA !layer_3_mirror,x
	
	INX #2
	INY #2
	CPY #$0020
	BCC -
	SEP #$30
	
	RTS

..option_mirror_offsets
	dw $0400,$0420,$0440,$0460,$0480,$04A0,$04C0,$04E0
	dw $0500,$0520,$0540,$0560,$0580,$05A0,$05C0,$05E0
	
.update_inputs
	; update a
	LDA controller[0].high_held
	AND #$80
	BEQ ++
	
	LDA controller[0].low_held
	AND #$08
	BEQ +
	INC !math_a+1
	
	+
	LDA controller[0].low_held
	AND #$04
	BEQ +
	DEC !math_a+1
	
	+
	LDA controller[0].low_held
	AND #$02
	BEQ +
	REP #$20
	DEC !math_a
	SEP #$20
	
	+
	LDA controller[0].low_held
	AND #$01
	BEQ ++
	REP #$20
	INC !math_a
	SEP #$20
	
	++
	; update b
	LDA controller[0].low_held
	AND #$80
	BEQ ++
	
	LDA controller[0].low_held
	AND #$08
	BEQ +
	INC !math_b+1
	
	+
	LDA controller[0].low_held
	AND #$04
	BEQ +
	DEC !math_b+1
	
	+
	LDA controller[0].low_held
	AND #$02
	BEQ +
	REP #$20
	DEC !math_b
	SEP #$20
	
	+
	LDA controller[0].low_held
	AND #$01
	BEQ ++
	REP #$20
	INC !math_b
	SEP #$20
	
	++
	RTS
	
.update_display
	; display a
	LDA !math_a+1
	LSR #4
	STA !layer_3_mirror+$00D6
	LDA !math_a+1
	AND #$0F
	STA !layer_3_mirror+$00D8
	
	LDA !math_a
	LSR #4
	STA !layer_3_mirror+$00DA
	STA !layer_3_mirror+$009A
	LDA !math_a
	AND #$0F
	STA !layer_3_mirror+$00DC
	STA !layer_3_mirror+$009C
	
	; display b
	LDA !math_b+1
	LSR #4
	STA !layer_3_mirror+$0156
	LDA !math_b+1
	AND #$0F
	STA !layer_3_mirror+$0158
	
	LDA !math_b
	LSR #4
	STA !layer_3_mirror+$015A
	STA !layer_3_mirror+$011A
	LDA !math_b
	AND #$0F
	STA !layer_3_mirror+$015C
	STA !layer_3_mirror+$011C
	
	; display o
	LDA !math_o+3
	LSR #4
	STA !layer_3_mirror+$024E
	LDA !math_o+3
	AND #$0F
	STA !layer_3_mirror+$0250
	
	LDA !math_o+2
	LSR #4
	STA !layer_3_mirror+$0252
	LDA !math_o+2
	AND #$0F
	STA !layer_3_mirror+$0254
	
	LDA !math_o+1
	LSR #4
	STA !layer_3_mirror+$0256
	STA !layer_3_mirror+$0216
	LDA !math_o+1
	AND #$0F
	STA !layer_3_mirror+$0258
	STA !layer_3_mirror+$0218
	
	LDA !math_o
	LSR #4
	STA !layer_3_mirror+$025A
	STA !layer_3_mirror+$021A
	STA !layer_3_mirror+$01DA
	LDA !math_o
	AND #$0F
	STA !layer_3_mirror+$025C
	STA !layer_3_mirror+$021C
	STA !layer_3_mirror+$01DC
	
	; display description
	LDA !math_current_option
	ASL
	TAX
	
	REP #$30
	LDA ..operator_descriptions,x
	STA !scratch_0
	SEP #$10
	
	LDX #$00
	LDY #$00
	
	-
	LDA (!scratch_0),y
	STA !layer_3_mirror+$0640,x
	
	INX #2
	INY #2
	CPY #$80
	BCC -
	SEP #$30
	
	RTS
	
..operator_descriptions
	; dw ...sine_description,...add_description
	; dw ...cosine_description,...subtract_description
	; dw ...tangent_description,...multiply_description
	; dw ...arcsin_description,...divide_description
	; dw ...arccos_description,...modulo_description
	; dw ...arctan_description,...empty_description
	; dw ...square_root_description,...empty_description
	; dw ...inverse_sqrt_description,...randomize_description
	dw ...todo_description,...todo_description
	dw ...todo_description,...todo_description
	dw ...todo_description,...todo_description
	dw ...todo_description,...todo_description
	dw ...todo_description,...todo_description
	dw ...todo_description,...empty_description
	dw ...todo_description,...empty_description
	dw ...todo_description,...todo_description

...sine_description
	dw " sin(A8) = O16                  "
	dw "                                "

...add_description
	dw "                                "
	dw "                                "
	
...cosine_description
	dw " cos(A8) = O16                  "
	dw "                                "
	
...subtract_description
	dw "                                "
	dw "                                "
	
...tangent_description
	dw " tan(A8) = O16                  "
	dw "                                "
	
...multiply_description
	dw "                                "
	dw "                                "
	
...arcsin_description
	dw " arcsin(A16) = O8               "
	dw "                                "
	
...divide_description
	dw "                                "
	dw "                                "
	
...arccos_description
	dw " arccos(A16) = O8               "
	dw "                                "
	
...modulo_description
	dw "                                "
	dw "                                "
	
...arctan_description
	dw " arctan(A16) = O8               "
	dw "                                "
	
...square_root_description
	dw " sqrt(A16) = O8                 "
	dw "                                "
	
...inverse_sqrt_description
	dw "                                "
	dw "                                "
	
...randomize_description
	dw " randomize(A8) = O8             "
	dw "                                "
	
...empty_description
	dw "                                "
	dw "                                "
	
...todo_description
	dw " Description of operation here  "
	dw " <op>(<parameters>) = O<size>   "
	
.execute_operation
	LDA controller[0].low_pressed
	AND #$10
	BEQ +
	
	LDA !math_current_option
	ASL
	TAX
	REP #$20
	LDA ..operators,x
	STA !scratch_0
	SEP #$20
	JMP.w (!scratch_0)
	
	+
	RTS

..operators
	dw ...sine,...add
	dw ...cosine,...subtract
	dw ...tangent,...multiply
	dw ...arcsin,...divide
	dw ...arccos,...modulo
	dw ...arctan,...empty
	dw ...square_root,...empty
	dw ...inverse_sqrt,...randomize

...sine
...add
...cosine
...subtract
...tangent
...multiply
...arcsin
...divide
...arccos
...modulo
...arctan
...square_root
...inverse_sqrt
...randomize
...empty
	RTS
	