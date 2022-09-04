fixed_bytes:
	!counter = $00
	while !counter < $100
		db !counter
		!counter #= !counter+1
	endif
