nmi:
	%vram_write(!bf_ins_disp,$5080,$0400,0)
	%vram_write(!bf_dat_disp,$52A0,$0080,0)
	%vram_write(!bf_out_disp,$5300,$0100,0)
	RTL
