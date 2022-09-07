main:
	PHB
	PHK
	PLB
	
	JSR stardew_clock_handle_controller
	JSR stardew_clock_update_tick
	JSR stardew_clock_prepare_hud

	PLB
	RTL
	
stardew_clock_handle_controller:
	; return to main menu
	LDA controller[0].low_pressed
	AND #$10
	BEQ +
	%set_pointer_rom(!main_pointer,menu_init)
	RTS
	+

	; increment/decrement tick rate
	LDA controller[0].low_held
	AND #$03
	CMP #$01
	BEQ .right
	CMP #$02
	BNE +
	
	REP #$20
	LDA !stardew_clock_tick_rate
	BEQ +
	DEC !stardew_clock_tick_rate
	BRA +
	
	.right
	REP #$20
	LDA !stardew_clock_tick_rate
	INC
	BEQ +
	STA !stardew_clock_tick_rate
	
	+
	SEP #$20
	
	; double/halve tick rate
	LDA controller[0].low_pressed
	AND #$0C
	CMP #$08
	BEQ .up
	CMP #$04
	BNE +
	
	REP #$20
	LSR !stardew_clock_tick_rate
	BRA +
	
	.up
	REP #$20
	ASL !stardew_clock_tick_rate
	
	+
	SEP #$20
	
	; reset tick rate
	LDA controller[0].high_pressed
	AND #$80
	BEQ +
	
	REP #$20
	LDA #$01A4
	STA !stardew_clock_tick_rate
	SEP #$20
	
	+
	RTS
	
stardew_clock_update_tick:
	REP #$20
	LDA !stardew_clock_tick
	CMP !stardew_clock_tick_rate
	BCC +
	
	STZ !stardew_clock_tick
	SEP #$20
	BRA stardew_clock_update_time
	
	+
	INC !stardew_clock_tick
	SEP #$20
	RTS

stardew_clock_update_time:
	LDA !stardew_clock_time
	INC
	CMP #$48
	BCC +

	STZ !stardew_clock_time
	
	LDA !stardew_clock_am_pm
	EOR #$01
	STA !stardew_clock_am_pm
	BEQ stardew_clock_update_day
	
	RTS

	+
	STA !stardew_clock_time
	RTS

stardew_clock_update_day:
	; update total days counter
	REP #$20
	LDA !stardew_clock_days
	INC
	CMP #$2710
	BCS +
	STA !stardew_clock_days
	+
	SEP #$20
	
	; update day in the week
	LDA !stardew_clock_day_in_week
	INC
	CMP #$07
	BCC +
	LDA #$00
	+
	STA !stardew_clock_day_in_week
	
	; update day in the season, season
	LDA !stardew_clock_day_in_season
	INC
	CMP #$1D
	BCC +
	
	LDA #$01
	STA !stardew_clock_day_in_season
	
	LDA !stardew_clock_season
	INC
	AND #$03
	STA !stardew_clock_season
	BEQ stardew_clock_update_year
	
	+
	STA !stardew_clock_day_in_season
	RTS
	
stardew_clock_update_year:
	; update total years counter
	LDA !stardew_clock_years
	INC
	CMP #$64
	BCS +
	STA !stardew_clock_years
	
	+
	RTS

stardew_clock_prepare_hud:
	; tick
	LDA !stardew_clock_tick+1
	LSR #4
	STA !layer_3_mirror+$00CE
	
	LDA !stardew_clock_tick+1
	AND #$0F
	STA !layer_3_mirror+$00D0
	
	LDA !stardew_clock_tick
	LSR #4
	STA !layer_3_mirror+$00D2
	
	LDA !stardew_clock_tick
	AND #$0F
	STA !layer_3_mirror+$00D4
	
	; tick rate
	LDA !stardew_clock_tick_rate+1
	LSR #4
	STA !layer_3_mirror+$0118
	
	LDA !stardew_clock_tick_rate+1
	AND #$0F
	STA !layer_3_mirror+$011A
	
	LDA !stardew_clock_tick_rate
	LSR #4
	STA !layer_3_mirror+$011C
	
	LDA !stardew_clock_tick_rate
	AND #$0F
	STA !layer_3_mirror+$011E
	
	; time
	LDA !stardew_clock_time
	STA !scratch_0
	LSR #4
	STA !layer_3_mirror+$018E
	
	LDA !scratch_0
	AND #$0F
	STA !layer_3_mirror+$0190
	
	LDA #$00
	XBA
	LDA !scratch_0
	
	REP #$30
	ASL #3
	CLC : ADC !scratch_0
	CLC : ADC !scratch_0
	TAX
	
	LDA .time_texts,x
	STA !layer_3_mirror+$0198
	LDA .time_texts+2,x
	STA !layer_3_mirror+$019A
	LDA .time_texts+4,x
	STA !layer_3_mirror+$019C
	LDA .time_texts+6,x
	STA !layer_3_mirror+$019E
	LDA .time_texts+8,x
	STA !layer_3_mirror+$01A0
	
	SEP #$30
	
	LDA !stardew_clock_am_pm
	ASL
	TAX
	
	LDA .am_pm_texts,x
	STA !layer_3_mirror+$01A4
	
	; day of week
	LDA !stardew_clock_day_in_week
	STA !scratch_0
	LSR #4
	STA !layer_3_mirror+$01DC
	
	LDA !scratch_0
	AND #$0F
	STA !layer_3_mirror+$01DE
	
	LDA !scratch_0
	ASL #2
	CLC : ADC !scratch_0
	CLC : ADC !scratch_0
	TAX
	
	REP #$20
	LDA .day_of_week_texts,x
	STA !layer_3_mirror+$01E6
	LDA .day_of_week_texts+2,x
	STA !layer_3_mirror+$01E8
	LDA .day_of_week_texts+4,x
	STA !layer_3_mirror+$01EA
	SEP #$20
	
	; day of season
	LDA !stardew_clock_day_in_season
	STA !scratch_0
	LSR #4
	STA !layer_3_mirror+$0220
	
	LDA !scratch_0
	AND #$0F
	STA !layer_3_mirror+$0222
	
	LDA !stardew_clock_season
	ASL #2
	STA !scratch_0
	LDA !stardew_clock_season
	ASL #3
	CLC : ADC !scratch_0
	TAX
	
	REP #$20
	LDA .season_texts,x
	STA !layer_3_mirror+$022A
	LDA .season_texts+2,x
	STA !layer_3_mirror+$022C
	LDA .season_texts+4,x
	STA !layer_3_mirror+$022E
	LDA .season_texts+6,x
	STA !layer_3_mirror+$0230
	LDA .season_texts+8,x
	STA !layer_3_mirror+$0232
	LDA .season_texts+10,x
	STA !layer_3_mirror+$0234
	SEP #$20
	
	; total days
	LDA !stardew_clock_days+1
	LSR #4
	STA !layer_3_mirror+$029A
	
	LDA !stardew_clock_days+1
	AND #$0F
	STA !layer_3_mirror+$029C
	
	LDA !stardew_clock_days
	LSR #4
	STA !layer_3_mirror+$029E
	
	LDA !stardew_clock_days
	AND #$0F
	STA !layer_3_mirror+$02A0
	
	; total years
	LDA !stardew_clock_years
	LSR #4
	STA !layer_3_mirror+$02DC
	
	LDA !stardew_clock_years
	AND #$0F
	STA !layer_3_mirror+$02DE
	
	; weather
	LDA !stardew_clock_weather
	LSR #4
	STA !layer_3_mirror+$0354
	
	LDA !stardew_clock_weather
	AND #$0F
	STA !layer_3_mirror+$0356
	
	LDA !stardew_clock_weather
	ASL #3
	STA !scratch_0
	LDA !stardew_clock_weather
	ASL #4
	CLC : ADC !scratch_0
	TAX
	
	REP #$20
	LDA .weather_texts,x
	STA !layer_3_mirror+$035E,x
	LDA .weather_texts+2,x
	STA !layer_3_mirror+$0360,x
	LDA .weather_texts+4,x
	STA !layer_3_mirror+$0362,x
	LDA .weather_texts+6,x
	STA !layer_3_mirror+$0364,x
	LDA .weather_texts+8,x
	STA !layer_3_mirror+$0366,x
	LDA .weather_texts+10,x
	STA !layer_3_mirror+$0368,x
	LDA .weather_texts+12,x
	STA !layer_3_mirror+$036A,x
	LDA .weather_texts+14,x
	STA !layer_3_mirror+$036C,x
	LDA .weather_texts+16,x
	STA !layer_3_mirror+$036E,x
	LDA .weather_texts+18,x
	STA !layer_3_mirror+$0370,x
	LDA .weather_texts+20,x
	STA !layer_3_mirror+$0372,x
	LDA .weather_texts+22,x
	STA !layer_3_mirror+$0374,x
	SEP #$20
	
	RTS
	
.am_pm_texts
	dw "a","p"
	
.time_texts
	dw "12:00","12:10","12:20","12:30","12:40","12:50"
	dw " 1:00"," 1:10"," 1:20"," 1:30"," 1:40"," 1:50"
	dw " 2:00"," 2:10"," 2:20"," 2:30"," 2:40"," 2:50"
	dw " 3:00"," 3:10"," 3:20"," 3:30"," 3:40"," 3:50"
	dw " 4:00"," 4:10"," 4:20"," 4:30"," 4:40"," 4:50"
	dw " 5:00"," 5:10"," 5:20"," 5:30"," 5:40"," 5:50"
	dw " 6:00"," 6:10"," 6:20"," 6:30"," 6:40"," 6:50"
	dw " 7:00"," 7:10"," 7:20"," 7:30"," 7:40"," 7:50"
	dw " 8:00"," 8:10"," 8:20"," 8:30"," 8:40"," 8:50"
	dw " 9:00"," 9:10"," 9:20"," 9:30"," 9:40"," 9:50"
	dw "10:00","10:10","10:20","10:30","10:40","10:50"
	dw "11:00","11:10","11:20","11:30","11:40","11:50"

.day_of_week_texts
	dw "Sun"
	dw "Mon"
	dw "Tue"
	dw "Wed"
	dw "Thu"
	dw "Fri"
	dw "Sat"

.season_texts
	dw "Spring"
	dw "Summer"
	dw "Autumn"
	dw "Winter"
	
.weather_texts
	dw "Sunny       "
	dw "Cloudy      "
	dw "Foggy       "
	dw "Windy       "
	dw "Raining     "
	dw "Snowing     "
	dw "Storming    "
	dw "Diamond Dust"