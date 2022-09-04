!collision_map_size = $0380
!collision_interaction_table = $7FC000

!collision_player_x_pos = $0120
	!collision_player_x_pos_frac = $0120
	!collision_player_x_pos_low = $0121
	
!collision_player_y_pos = $0122
	!collision_player_y_pos_frac = $0122
	!collision_player_y_pos_low = $0123
	
!collision_player_x_spd = $0124
	!collision_player_x_spd_frac = $0124
	!collision_player_x_spd_low = $0125
	
!collision_player_y_spd = $0126
	!collision_player_y_spd_frac = $0126
	!collision_player_y_spd_low = $0127

!collision_player_blocked = $0128	; c---udlr




!collision_player_width = $06
!collision_player_height = $06
!collision_player_x_offset = $01
!collision_player_y_offset = $01

!collision_player_x_left = !collision_player_x_offset
!collision_player_x_middle = !collision_player_x_offset+!collision_player_width/2
!collision_player_x_right = !collision_player_x_offset+!collision_player_width
!collision_player_y_top = !collision_player_y_offset
!collision_player_y_middle = !collision_player_y_offset+!collision_player_height/2
!collision_player_y_bottom = !collision_player_y_offset+!collision_player_height
