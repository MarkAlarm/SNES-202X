struct DMA $4300
	.settings:
		.parameters: skip 1
		.destination: skip 1
		
	.source
		.source_word:
			.source_word_low: skip 1
			.source_word_high: skip 1
		.source_bank: skip 1
		
	.size:
		.size_low: skip 1
		.size_high: skip 5
	
	.unused_B: skip 4
	.unused_F: skip 1
endstruct align $10

struct HDMA $4300
	.settings:
		.parameters: skip 1
		.destination: skip 1
	
	.source
		.source_word:
			.source_word_low: skip 1
			.source_word_high: skip 1
		.source_bank: skip 1
		
	.indirect_source
		.indirect_source_word:
			.indirect_source_word_low: skip 1
			.indirect_source_word_high: skip 1
		.indirect_source_bank: skip 1
		
	.midframe_table:
		.midframe_table_low: skip 1
		.midframe_table_high: skip 1
		
	.counter: skip 1
	
	.unused_B: skip 4
	.unused_F: skip 1
endstruct align $10
