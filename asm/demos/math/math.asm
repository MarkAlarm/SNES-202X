namespace math

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"
; include graphics, palettes, etc here if needed

;########;
;# Code #;
;########;

table "table.txt"
incsrc "init.asm"
incsrc "main.asm"
cleartable

incsrc "nmi.asm"
incsrc "irq.asm"

namespace off
