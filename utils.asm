rngSetup ; Use $D41B to get the random nbr
	lda #$FF
	sta $D40E
	sta $D40F
	lda #$80
	sta $D412
	rts
	
.clear_screen ; A-Character | Y-Color
	ldx #$00
.clear_screen_chars
	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $06e8,x
	inx
	bne .clear_screen_chars
	tya
	ldx #$00
.clear_screen_color
	sta $d800,x
	sta $d900,x
	sta $da00,x
	sta $dae8,x
	inx
	bne .clear_screen_color
	rts