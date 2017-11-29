!convtab scr

; Special values:
; $00 - End of Text (Next program step) (Or end of entry)
; $60 - Line return (Not implemented, will require some tweaking in the way the pointer in zero page is used)
; $E0 - Pause (Could be usefull with the intro) (Will only work with titles and specific stuff)
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
	
titles
	!text "robco industries (tm) termlink protocol"
	!byte $00
	!text "nuka-cola corporation (tm) workstation"
	!byte $00
	!text "ecorp(tm) backup security system terminal"
	!byte $00, $00

subtitle_welcome
	!text "password required"
	!byte $00
subtitle_bonus
	!text "> tmp - bonus awarded"
	!byte $00
	
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
	; Never have more than 255 passwords of the same length.
	
	; 4 chars long
	; C words
	!text "coke"
	!byte $00
	!text "cola"
	!byte $00
	!text "city"
	!byte $00
	!text "coat"
	!byte $00
	!text "care"
	!byte $00
	!text "corn"
	!byte $00
	; D words
	!text "dock"
	!byte $00
	!text "duck"
	!byte $00
	!text "dark"
	!byte $00
	!text "dork"
	!byte $00
	!text "done"
	!byte $00
	!text "doll"
	!byte $00
	; F words
	!text "fire"
	!byte $00
	!text "fine"
	!byte $00
	!text "face"
	!byte $00
	!text "fugi"
	!byte $00
	!text "fork"
	!byte $00
	!text "file"
	!byte $00
	; N words
	!text "nice"
	!byte $00
	!text "nune"
	!byte $00
	!text "nany"
	!byte $00
	!text "noon"
	!byte $00
	!text "nuka"
	!byte $00
	!text "news"
	!byte $00
	; S words
	!text "soda"
	!byte $00
	!text "sock"
	!byte $00
	!text "sail"
	!byte $00
	!text "soul"
	!byte $00
	!text "slip"
	!byte $00
	!text "slue"
	!byte $00, 00
	
	; 5 chars long
	!text "night"
	!byte $00
	!text "vapor"
	!byte $00, $00
	
	; 6 chars long
	!text "hunter2"
	!byte $00
	!text "123456"
	!byte $00, $00, $00
	
	; The end here has 3 null bytes to
	;  prevent errors when customizing.


;!convtab raw
;txt_asciistuff
;	!text "C64 Fallout Terminal Hacking V0.1 | "
;	!text "Created by Herwin Bozet (@AziasCreations) | "
;	!text "Special thanks to: Raffzahn (StackOverflow), ..."
