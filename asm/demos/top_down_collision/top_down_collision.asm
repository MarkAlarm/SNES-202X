namespace top_down_collision

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"
player: incbin "graphics/top_down_collision/player.bin"
tileset: incbin "graphics/top_down_collision/tileset.bin"

;########;
;# Code #;
;########;

incsrc "init.asm"
incsrc "main.asm"
incsrc "nmi.asm"
incsrc "irq.asm"

namespace off
