;###########;
;# Defines #;
;###########;

incsrc "defines.asm"

;############;
;# Includes #;
;############;

; include graphics, palettes, etc here if needed

;########;
;# Init #;
;########;

table "table.txt"
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
