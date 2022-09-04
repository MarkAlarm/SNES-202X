struct DSP $00
	skip $0C
	
	.main_volume_L: skip 1
	.echo_feedback: skip 15
	
	.main_volume_R: skip 1
	.unused: skip 15

	.echo_volume_L: skip 1
	.pitch_modulation: skip 15
	
	.echo_volume_R: skip 1
	.noise_enable: skip 15
	
	.key_on: skip 1
	.echo_enable: skip 15
	
	.key_off: skip 1
	.source_directory: skip 15
	
	.flags: skip 1
	.echo_buffer_start: skip 15
	
	.voice_end: skip 1
	.echo_delay: skip 15
	
	skip -$8C
endstruct

struct voice extends DSP
	.volume:
		.volume_L: skip 1
		.volume_R: skip 1
	
	.pitch:
		.pitch_low: skip 1
		.pitch_high: skip 1
	
	.source: skip 1
	
	.adsr:
		.adsr_1: skip 1
		.adsr_2: skip 1
		
	.gain: skip 1
	.envelope: skip 1
	.sample_value: skip 1
	
	.unusedA: skip 1
	.unusedB: skip 3
	.unusedE: skip 1
	
	.fir: skip 1
endstruct align $10
