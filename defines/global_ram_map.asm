; scratch

!scratch_0 = $00
!scratch_1 = $01
!scratch_2 = $02
!scratch_3 = $03
!scratch_4 = $04
!scratch_5 = $05
!scratch_6 = $06
!scratch_7 = $07
!scratch_8 = $08
!scratch_9 = $09
!scratch_A = $0A
!scratch_B = $0B
!scratch_C = $0C
!scratch_D = $0D
!scratch_E = $0E
!scratch_F = $0F

; ppu hardware mirrors

!layer_1_mirror_x = $10
	!layer_1_mirror_x_low = $10
	!layer_1_mirror_x_high = $11

!layer_1_mirror_y = $12
	!layer_1_mirror_y_low = $12
	!layer_1_mirror_y_high = $13
	
!layer_2_mirror_x = $20
	!layer_2_mirror_x_low = $20
	!layer_2_mirror_x_high = $21

!layer_2_mirror_y = $22
	!layer_2_mirror_y_low = $22
	!layer_2_mirror_y_high = $23
	
!layer_3_mirror_x = $30
	!layer_3_mirror_x_low = $30
	!layer_3_mirror_x_high = $31

!layer_3_mirror_y = $32
	!layer_3_mirror_y_low = $32
	!layer_3_mirror_y_high = $33
	
!layer_4_mirror_x = $40
	!layer_4_mirror_x_low = $40
	!layer_4_mirror_x_high = $41

!layer_4_mirror_y = $42
	!layer_4_mirror_y_low = $42
	!layer_4_mirror_y_high = $43




; counters

!frame_counter = $FC
	!frame_counter_low = $FC
	!frame_counter_high = $FD
	
; other

!system_flag = $FE
!nmi_done = $FF

; primary pointers

!main_pointer = $0100
!nmi_pointer = $0103
!irq_pointer = $0106

; oam mirror

!OAM_start = $0A00

!OAM_x = !OAM_start+$00
!OAM_y = !OAM_start+$01
!OAM_tile = !OAM_start+$02
!OAM_props = !OAM_start+$03
!OAM_bit_size = !OAM_start+$200
!OAM_size = !OAM_start+$220

; controllers 1-8

!controller_start = $0CC0

struct controller !controller_start
	.held
		.high_held: skip 1
		.low_held: skip 1
	.pressed
		.high_pressed: skip 1
		.low_pressed: skip 1
	.released
		.high_released: skip 1
		.low_released: skip 1
	.disable
		.high_disable: skip 1
		.low_disable: skip 1
endstruct align $08

!layer_3_mirror = $7E2000
