arch spc700

macro dsp_write(destaddr, value)
	mov SPC.dsp_address, #<destaddr>
	mov SPC.dsp_data, #<value>
endmacro

macro dsp_read(destaddr)
	
endmacro

arch 65816