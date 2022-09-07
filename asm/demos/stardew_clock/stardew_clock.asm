namespace stardew_clock

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"

;########;
;# Code #;
;########;

table "table.txt"
incsrc "init.asm"
incsrc "main.asm"
incsrc "nmi.asm"
cleartable

namespace off
