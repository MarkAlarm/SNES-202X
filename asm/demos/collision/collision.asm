;###########;
;# Defines #;
;###########;

incsrc "defines.asm"

;########;
;# Init #;
;########;

table "table.txt"
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
