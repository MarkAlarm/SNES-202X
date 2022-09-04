;########;
;# Init #;
;########;

table "table.txt"
incsrc "init.asm"

;########;
;# Main #;
;########;

incsrc "main.asm"
cleartable

;#######;
;# NMI #;
;#######;

incsrc "nmi.asm"
