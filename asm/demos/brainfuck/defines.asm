!bf_ins_edit_index = $0120		; index within code editor
!bf_dat_edit_index = $0122		; index within data editor
!bf_ins_runtime_index = $0124	; index within code processing
!bf_arr_runtime_index = $0126	; index within data processing

!bf_edit_mode = $0127			; 0 = code, 1 = input

!bf_ins_raw = $7E3000			; 512 bytes of code
!bf_dat_raw = $7E3200			; 64 bytes of data
!bf_out_raw = $7E3400			; 128 bytes of output

!bf_ins_disp = $7E4000			; each of these doubled for display purposes
!bf_dat_disp = $7E4400
!bf_out_disp = $7E4480

!bf_array = $7F0000				; 1024 bytes of data buffer (not 30,000)

; code
; 512 bytes of code "+-<>[],."
; display is 1024 bytes

; data
; 64 bytes of data (anything 20-7E)
; display is 128 bytes

; output
; 128 bytes of data (00-FF)
; display is 256 bytes

; array
; 1024 bytes




; ok maybe this
; L/R to change the code/input
; start to execute code
; select to swap between code and input
; dpad to move within the editor/input bar