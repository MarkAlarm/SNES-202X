struct PPU $2100
	.screen: skip 1
	
	.sprite_select: skip 1
	.oam_address:
		.oam_address_low: skip 1
		.oam_address_high: skip 1
	.oam_data: skip 1
	
	.background_mode: skip 1
	.mosaic: skip 1
	
	.layer_1_2_tilemap:
		.layer_1_tilemap: skip 1
		.layer_2_tilemap: skip 1
	.layer_3_4_tilemap:
		.layer_3_tilemap: skip 1
		.layer_4_tilemap: skip 1
	
	.layer_all_tiledata:
		.layer_1_2_tiledata: skip 1
		.layer_3_4_tiledata: skip 1

	.layer_1_scroll_x: skip 1 		; write twice
	.layer_1_scroll_y: skip 1 		; write twice
	.layer_2_scroll_x: skip 1 		; write twice
	.layer_2_scroll_y: skip 1 		; write twice
	.layer_3_scroll_x: skip 1 		; write twice
	.layer_3_scroll_y: skip 1 		; write twice
	.layer_4_scroll_x: skip 1 		; write twice
	.layer_4_scroll_y: skip 1 		; write twice
	
	.vram_control: skip 1
	.vram_address:
		.vram_address_low: skip 1
		.vram_address_high: skip 1
	.vram_data:
		.vram_data_low: skip 1
		.vram_data_high: skip 1
		
	.mode_7_settings: skip 1
	.fixed_point_mul_A:
	.mode_7_A: skip 1				; write twice
	.fixed_point_mul_B:
	.mode_7_B: skip 1				; write twice
	.mode_7_C: skip 1				; write twice
	.mode_7_D: skip 1				; write twice
	.mode_7_center_x: skip 1		; write twice
	.mode_7_center_y: skip 1		; write twice
	
	.cgram_address: skip 1
	.cgram_data: skip 1
	
	.window_layer_all_settings:
		.window_layer_1_2_settings: skip 1
		.window_layer_3_4_settings: skip 1
	.window_sprite_color_settings: skip 1
	
	.window_1:
		.window_1_left: skip 1
		.window_1_right: skip 1
	.window_2:
		.window_2_left: skip 1
		.window_2_right: skip 1
		
	.window_logic:
		.window_layer_logic: skip 1
		.window_sprite_color_logic: skip 1
	
	.screens:
		.main_screen: skip 1
		.sub_screen: skip 1
	
	.window_masks:
		.window_mask_main_screen: skip 1
		.window_mask_sub_screen: skip 1
	
	.color_math:
		.color_addition_logic: skip 1
		.color_math_settings: skip 1

	.display_control:
		.fixed_color: skip 1
		.video_mode: skip 1

	.product:
		.product_word:
			.product_low: skip 1
			.product_mid: skip 1
		.product_high: skip 1
	
	.latch: skip 1
	
	.oam_read: skip 1
	
	.vram_read:
		.vram_read_low: skip 1
		.vram_read_high: skip 1
		
	.cgram_read: skip 1
	
	.horizontal_scanline: skip 1	; read twice
	.vertical_scanline: skip 1		; read twice
	
	.status:
		.status_ppu1: skip 1
		.status_ppu2: skip 1
endstruct