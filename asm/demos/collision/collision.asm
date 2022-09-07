namespace collision

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"

;########;
;# Code #;
;########;

table "table.txt"
incsrc "init.asm"
cleartable

incsrc "main.asm"
incsrc "nmi.asm"

namespace off
