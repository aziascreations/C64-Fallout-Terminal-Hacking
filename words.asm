!convtab scr

greetings
	!text ""

companies
	!text "robco industries (tm) termlink protocol"
	!byte $00
	
	!text "ecorp(tm) backup security system teminal"
	!byte $00
	!byte $00

fillers
	; Excluded characters: [](){}<> -> Used for special stuff 
	!text "\!#$%&*+-/:;=?"
	!byte $22, $00

passwords
	!text "hunter2"
	!byte $00
	!text "12345678"
	!byte $00
	!byte $00

fsocietytext
	!text "!temp!"
	!byte $00
	!byte $00

txt_test
	!text "title."
	!byte $00

txt_subtitle
	!text "text."
	!byte $00


!convtab raw
txt_asciistuff
	!text "C64 Fallout Terminal V0.1 | "
	!text "Created by Herwin Bozet (@AziasCreations) | "
	!text "Thanks to: Raffzahn (StackOverflow), ???"
