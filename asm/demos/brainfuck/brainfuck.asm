namespace brainfuck

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"
font: incbin "font.bin"

;########;
;# Code #;
;########;

table "table.txt"

incsrc "init.asm"
incsrc "main.asm"
incsrc "nmi.asm"

cleartable

incsrc "irq.asm"

namespace off
