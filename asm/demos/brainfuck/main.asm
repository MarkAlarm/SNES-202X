main:
	PHB
	PHK
	PLB
	
	JSR .process_P1
	JSR .process_P2
	JSR .prep_disp
	
	PLB
	
	RTL
	
.process_P1
	; handle moving the index around the code/data menus
	LDA controller[0].low_pressed
	STA !scratch_0

	LDA !bf_edit_mode
	BNE ++
	
	LDA !scratch_0
	AND #$08
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	SEC : SBC #$0020
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$04
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	CLC : ADC #$0020
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$02
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	DEC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$01
	BEQ +++
	
	REP #$20
	LDA !bf_ins_edit_index
	INC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	BRA +++
	
	++
	LDA !scratch_0
	AND #$08
	BEQ +
	
	REP #$20
	LDA !bf_dat_edit_index
	SEC : SBC #$0020
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$04
	BEQ +
	
	REP #$20
	LDA !bf_dat_edit_index
	CLC : ADC #$0020
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$02
	BEQ +
	
	REP #$20
	LDA !bf_dat_edit_index
	DEC
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+
	LDA !scratch_0
	AND #$01
	BEQ +++
	
	REP #$20
	LDA !bf_dat_edit_index
	INC
	AND #$003F
	STA !bf_dat_edit_index
	SEP #$20
	
	+++
	; handle changing instructions/data values
	LDA !bf_edit_mode
	BNE +++
	
	LDA controller[0].high_pressed
	AND #$10
	BEQ ++
	
	REP #$10
	LDX !bf_ins_edit_index
	LDA !bf_ins_raw,x
	INC
	CMP #$09
	BCC +
	LDA #$00
	+
	STA !bf_ins_raw,x
	SEP #$10
	
	++
	LDA controller[0].high_pressed
	AND #$20
	BEQ ++++
	
	REP #$10
	LDX !bf_ins_edit_index
	LDA !bf_ins_raw,x
	DEC
	BPL +
	LDA #$08
	+
	STA !bf_ins_raw,x
	SEP #$10
	BRA ++++
	
	+++
	LDA !frame_counter
	AND #$03
	BNE +
	LDA controller[0].high_held
	AND #$10
	BEQ +
	
	REP #$10
	LDX !bf_dat_edit_index
	LDA !bf_dat_raw,x
	INC
	STA !bf_dat_raw,x
	SEP #$10
	
	+
	LDA !frame_counter
	AND #$03
	BNE +
	LDA controller[0].high_held
	AND #$20
	BEQ ++++
	
	REP #$10
	LDX !bf_dat_edit_index
	LDA !bf_dat_raw,x
	DEC
	STA !bf_dat_raw,x
	SEP #$10
	
	++++
	; handle menu swap and code execution
	LDA !scratch_0
	AND #$10
	BEQ +
	JMP .execute_code
	
	+
	LDA !scratch_0
	AND #$20
	BEQ +
	
	LDA !bf_edit_mode
	EOR #$01
	STA !bf_edit_mode
	
	+
	RTS
	
.process_P2
	REP #$20
	LDA controller[1].pressed
	STA !scratch_0
	SEP #$20
	
	; left = <
	LDA !scratch_1
	AND #$02
	BEQ +
	LDA #$02
	BRA ++
	
	; right = >
	+
	LDA !scratch_1
	AND #$01
	BEQ +
	LDA #$01
	BRA ++
	
	; up = +
	+
	LDA !scratch_1
	AND #$08
	BEQ +
	LDA #$03
	BRA ++
	
	; down = -
	+
	LDA !scratch_1
	AND #$04
	BEQ +
	LDA #$04
	BRA ++
	
	; A = ]
	+
	LDA !scratch_0
	AND #$80
	BEQ +
	LDA #$08
	BRA ++
	
	; B = .
	+
	LDA !scratch_1
	AND #$80
	BEQ +
	LDA #$05
	BRA ++
	
	; X = [
	+
	LDA !scratch_0
	AND #$40
	BEQ +
	LDA #$07
	BRA ++
	
	; Y = ,
	+
	LDA !scratch_1
	AND #$40
	BEQ +++
	LDA #$06
	
	++
	REP #$10
	LDX !bf_ins_edit_index
	STA !bf_ins_raw,x
	
	REP #$20
	LDA !bf_ins_edit_index
	INC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$30
	
	; L = move backward 1
	+++
	LDA !scratch_0
	AND #$20
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	DEC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	; R = move forward 1
	+
	LDA !scratch_0
	AND #$10
	BEQ +
	
	REP #$20
	LDA !bf_ins_edit_index
	INC
	AND #$01FF
	STA !bf_ins_edit_index
	SEP #$20
	
	; select = clear
	+
	LDA !scratch_1
	AND #$20
	BEQ +
	
	REP #$10
	LDX !bf_ins_edit_index
	LDA #$00
	STA !bf_ins_raw,x
	SEP #$10
	
	; start = execute
	+
	LDA !scratch_1
	AND #$10
	BEQ +
	JMP .execute_code
	
	+
	RTS

.prep_disp
	REP #$30
	
	LDX #$0000
	
	-
	LDA !bf_ins_raw,x
	AND #$00FF
	ASL
	TAY
	
	LDA ..ins_chars,y
	STA !scratch_0
	
	PHX
	TXA
	ASL
	TAX
	LDA !scratch_0
	STA !bf_ins_disp,x
	PLX
	
	INX
	CPX #$0200
	BCC -
	
	LDX #$0000
	
	-
	LDA !bf_dat_raw,x
	AND #$00FF
	STA !scratch_0
	
	PHX
	TXA
	ASL
	TAX
	LDA !scratch_0
	STA !bf_dat_disp,x
	PLX
	
	INX
	CPX #$0040
	BCC -
	
	LDX #$0000
	
	-
	LDA !bf_out_raw,x
	AND #$00FF
	STA !scratch_0
	
	PHX
	TXA
	ASL
	TAX
	LDA !scratch_0
	STA !bf_out_disp,x
	PLX
	
	INX
	CPX #$0080
	BCC -
	
	SEP #$30
	
	; now highlight the currently edited thing
	
	LDA !bf_edit_mode
	REP #$30
	BNE +
	
	LDA !bf_ins_edit_index
	ASL
	TAX
	INX
	
	SEP #$20
	LDA #$04
	STA !bf_ins_disp,x
	
	SEP #$30
	RTS
	
	+
	REP #$30
	
	LDA !bf_dat_edit_index
	ASL
	TAX
	INX
	
	SEP #$20
	LDA #$04
	STA !bf_dat_disp,x
	
	SEP #$30
	RTS
	
..ins_chars
	dw "_><+-.,[]"
	
.execute_code
	STZ !bf_edit_mode

	REP #$20
	STZ !bf_ins_edit_index
	STZ !bf_dat_edit_index
	STZ !bf_ins_run_index
	STZ !bf_arr_run_index
	SEP #$20
	
	STZ !bf_inp_run_index
	STZ !bf_out_run_index
	
	%wram_fill($00,!bf_array,$0400,0)
	%wram_fill($20,!bf_out_raw,$0080,0)
	
	; code processing here
	%wdm()
	
	-
	REP #$30
	LDX !bf_ins_run_index
	LDA !bf_ins_raw,x
	AND #$00FF
	ASL
	TAX
	
	JSR (..ins_table,x)
	
	REP #$30
	
	LDA !bf_ins_run_index
	INC
	STA !bf_ins_run_index
	CMP #$0200
	BCC -
	
	SEP #$30
	
	RTS
	
..ins_table
	dw ...nop
	dw ...inc_ptr
	dw ...dec_ptr
	dw ...inc_dat
	dw ...dec_dat
	dw ...dat_out
	dw ...dat_in
	dw ...loop_start
	dw ...loop_end
	
...nop
	RTS
	
...inc_ptr
	LDA !bf_arr_run_index
	INC
	AND #$01FF
	STA !bf_arr_run_index
	RTS
	
...dec_ptr
	LDA !bf_arr_run_index
	DEC
	AND #$01FF
	STA !bf_arr_run_index
	RTS
	
...inc_dat
	SEP #$20
	LDX !bf_arr_run_index
	LDA !bf_array,x
	INC
	STA !bf_array,x
	RTS
	
...dec_dat
	SEP #$20
	LDX !bf_arr_run_index
	LDA !bf_array,x
	DEC
	STA !bf_array,x
	RTS
	
...dat_out
	SEP #$30
	
	LDY !bf_out_run_index
	BMI +
	
	REP #$10
	LDX !bf_arr_run_index
	LDA !bf_array,x
	SEP #$10
	TYX
	STA !bf_out_raw,x
	
	INC !bf_out_run_index
	
	+
	RTS
	
...dat_in
	SEP #$30
	
	LDA !bf_inp_run_index
	CMP #$40
	BCS +
	
	LDX !bf_inp_run_index
	LDA !bf_dat_raw,x
	
	REP #$10
	LDX !bf_arr_run_index
	STA !bf_array,x
	SEP #$10
	
	INC !bf_inp_run_index
	
	+
	RTS
	
...loop_start
	SEP #$20
	
	LDX !bf_arr_run_index
	LDA !bf_array,x
	BNE +
	
	LDX !bf_ins_run_index
	-
	INX
	LDA !bf_ins_raw,x
	CMP #$08
	BNE -
	
	STX !bf_ins_run_index
	
	+
	RTS
	
...loop_end
	SEP #$20
	
	LDX !bf_arr_run_index
	LDA !bf_array,x
	BEQ +
	
	LDX !bf_ins_run_index
	
	-
	DEX
	LDA !bf_ins_raw,x
	CMP #$07
	BNE -
	
	DEX
	STX !bf_ins_run_index
	
	+
	RTS
