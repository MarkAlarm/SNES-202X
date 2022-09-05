;###########;
;# Defines #;
;###########;

incsrc "defines.asm"

;########;
;# Init #;
;########;

table "defines/font_generic_table.txt"
incsrc "init.asm"

;########;
;# Main #;
;########;

incsrc "main.asm"

;#######;
;# NMI #;
;#######;

incsrc "nmi.asm"
cleartable
