!player_x_pos = $0120
	!player_x_pos_frac = $0120
	!player_x_pos_low = $0121
	
!player_y_pos = $0122
	!player_y_pos_frac = $0122
	!player_y_pos_low = $0123
	
!player_x_spd = $0124
	!player_x_spd_frac = $0124
	!player_x_spd_low = $0125
	
!player_y_spd = $0126
	!player_y_spd_frac = $0126
	!player_y_spd_low = $0127

!player_dir_move = $0128	; ----udlr
!player_dir_face = $0129	; ----udlr 
!player_blocked = $012A		; c---udlr

!player_tile_index = $012E

!ppu_h = $0130
!ppu_v = $0132

!collision_interaction_table = $7FC000

!player_width = $08
!player_height = $08
!player_x_offset = $00
!player_y_offset = $00

!player_x_left = !player_x_offset-1
!player_x_middle = !player_x_offset+!player_width/2
!player_x_right = !player_x_offset+!player_width
!player_y_top = !player_y_offset-1
!player_y_middle = !player_y_offset+!player_height/2
!player_y_bottom = !player_y_offset+!player_height

!pbsp = $0100
!npsp = $10000-!pbsp