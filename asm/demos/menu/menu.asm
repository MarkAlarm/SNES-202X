namespace menu

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"

;########;
;# Code #;
;########;

table "defines/font_generic_table.txt"
incsrc "init.asm"
incsrc "main.asm"
incsrc "nmi.asm"
cleartable

namespace off
