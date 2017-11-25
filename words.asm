!convtab scr

; Special values:
; $00 - End of Text (Next program step) (Or end of entry)
; $60 - Line return
; $E0 - Pause (Could be usefull with the intro)
; $00,$00 - End of section (Used for random selector loops)

intro
	!text "Connecting", $E0, ".", $E0, ".", $E0, "."
	!byte $60
	!text "unauthorized access detected !"
	!byte $60
	!text "???"
	!byte $00, $00

post_hack
	; This is the text that will scroll fast before post-hack.asm
	!byte $60
	!text "???"
	!byte $60
	!text "???"
	!byte $00, $00
	
companies
	!text "robco industries (tm) termlink protocol"
	!byte $00
	
	!text "ecorp(tm) backup security system terminal"
	!byte $00, $00

fillers
	; Excluded characters: [](){}<> -> Used for special stuff 
	!text "\!#$%&*+-/:;=?", $22
	!byte $00
fillers_mask
	!byte %00011111
fillers_max
	; Use the amount of filler characters + 1
	!byte #17
	
passwords
	; Temporary passwords
	
	; 4 chars long
	!text "poke"
	!byte $00
	!text "duck"
	!byte $00
	!byte $00
	
	; 5 chars long
	!text "night"
	!byte $00
	!text "vapor"
	!byte $00
	!byte $00
	
	; 6 chars long
	!text "hunter2"
	!byte $00
	!text "123456"
	!byte $00, $00, $00
	
	; The end here has 3 null bytes to
	;  prevent errors when customizing.

txt_test
	!text "title."
	!byte $00

txt_subtitle
	!text "text."
	!byte $00


!convtab raw
txt_asciistuff
	!text "C64 Fallout Terminal Hacking V0.1 | "
	!text "Created by Herwin Bozet (@AziasCreations) | "
	!text "Special thanks to: Raffzahn (StackOverflow), ..."
