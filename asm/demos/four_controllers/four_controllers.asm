namespace four_controllers

;########################;
;# Defines and Includes #;
;########################;

incsrc "defines.asm"

;########;
;# Code #;
;########;

table "defines/font_generic_table.txt"
incsrc "init.asm"
cleartable

incsrc "main.asm"
incsrc "nmi.asm"

namespace off
