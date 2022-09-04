;########;
;# Init #;
;########;

table "defines/font_generic_table.txt"
incsrc "init.asm"
cleartable

;########;
;# Main #;
;########;

incsrc "main.asm"

;#######;
;# NMI #;
;#######;

incsrc "nmi.asm"
