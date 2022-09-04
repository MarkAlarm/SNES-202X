struct joypad $4016
	.ports:
		.port_0: skip 1
		.port_1: skip 1
endstruct

struct CPU $4200
	.interrupt_enable: skip 1
	.output_port: skip 1
	
	.multiply:
		.multiplicand: skip 1
		.multiplier: skip 1
	.dividend:
		.dividend_low: skip 1
		.dividend_high: skip 1
	.divisor: skip 1
	
	.horizontal_timer:
		.horizontal_timer_low: skip 1
		.horizontal_timer_high: skip 1
	
	.vertical_timer:
		.vertical_timer_low: skip 1
		.vertical_timer_high: skip 1
	
	.enable_dma: skip 1
	.enable_hdma: skip 1
	
	.rom_speed: skip 1
	
	.openbus: skip 2
	
	.nmi_flag: skip 1
	.irq_flag: skip 1
	.ppu_status: skip 1
	.input_port: skip 1
	
	.quotient:
		.quotient_low: skip 1
		.quotient_high: skip 1
		
	.product:
	.remainder:
		.product_low:
		.remainder_low: skip 1
		.product_high:
		.remainder_high: skip 1
		
	.controllers:
		.port_1_data_1:
			.port_1_data_1_low: skip 1
			.port_1_data_1_high: skip 1
		.port_2_data_1:
			.port_2_data_1_low: skip 1
			.port_2_data_1_high: skip 1
		.port_1_data_2:
			.port_1_data_2_low: skip 1
			.port_1_data_2_high: skip 1
		.port_2_data_2:
			.port_2_data_2_low: skip 1
			.port_2_data_2_high: skip 1
endstruct
