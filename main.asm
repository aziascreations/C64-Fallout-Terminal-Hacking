
!source "constants.asm"

MEM_CHARSLOW = $3000
MEM_CHARSHIGH = $30C0

MEM_KEYSTATUS = $3190

MEM_PRINTERSTATUS = $3191
;7 -> 0
;7 - Has encountered a null terminator (Next line)
;6 - Title printed status
;5 - Subtitle printed
;    00-Doing title
;    01-Doing subtitle
;    11-Doing main text
;4->0 Current line (0 -> 32+) (25 max)
MASK_PRINTER_EOL = %10000000
MASK_PRINTER_TITLEDONE = %01000000
MASK_PRINTER_SUBTITLEDONE = %00100000
MASK_PRINTER_CURRENTLINE = %00011111

; Values used for the fake addresses on the side
; Max value 0xFFFF - 0x0198 (0xFE67)
MEM_TEXT_ADRH = $3192
MEM_TEXT_ADRL = $3193
MEM_TEXT_ADRSTATUS = $3194
;7 -> 0
;7 - Is ADRH equal to FE ?
;6->0 ???
MASK_TEXT_ADR_ISHEQL = %10000000

MEM_PWD_LENGTH = $31F0
MEM_PWD_AMOUNT = $31F1

; Pointer to the start of the section with
;  the password with the required length
MEM_PWD_DATA_PTRL = $31F2
MEM_PWD_DATA_PTRH = $31F3

; Direct pointer to the solution word
MEM_PWD_SOLUTION_PTRL = $31F4
MEM_PWD_SOLUTION_PTRH = $31F5

; Data structure: (Temporary)
;  * n*2 bytes
;    * Pointers to word in Data zone.
;  * $00*2
MEM_PWD_DATA = $31F6

;CONTS_PRINTERTIMER = #04
;MEM_SETTINGS = $3191
;MASK_DIFFICULTY

* = $1000

!zone Initialization
init
	; Setting up screen colors
	lda #$00
	sta SCR_FRAME
	sta SCR_BKGND
	
init_screen
	; Preparing cursor (Doesn't work as intended)
	;lda #$02
	;sta SCR_CURSOR_X
	;lda #$10
	;sta SCR_CURSOR_Y
	;lda #$00
	;sta SCR_CURSOR_STATE
	
	; Preparing values for util_clear_screen
	lda #$20
	ldy #$05
	jsr Utils.clear_screen

; This part is not nescessary since this area will be overwritten later. 
init_memory
	; Preparing values for init_memory_loop
	lax #$01
init_memory_loop
	; Cleaning memory from MEM_CHARSLOW to MEM_CHARSLOW + 192(C0) * 2
	sta MEM_CHARSLOW,x
	sta MEM_CHARSHIGH,x
	inx
	cpx #$C0
	bne init_memory_loop


!zone Generate
generate
	; Prepare the SID for later
	jsr rngSetup
	
	; See http://www.6502.org/tutorials/compare_beyond.html
	; Values Reset
	lda #$00
	sta MEM_TEXT_ADRSTATUS
	
; Generating fake start address
.gen_adr_high
	lda MSC_SIDRNG
	cmp #$FE
	bcc .gen_adr_high
	sta MEM_TEXT_ADRH
	beq .gen_adr_high_eql
	jmp .gen_adr_low
.gen_adr_high_eql
	lda MEM_TEXT_ADRSTATUS
	ora #MASK_TEXT_ADR_ISHEQL
	sta MEM_TEXT_ADRSTATUS
	; For future cpy
	ldy #$01
	
.gen_adr_low
	lda MSC_SIDRNG
	cpy #$01
	bne .gen_adr_end
	cmp #$68
	bcs .gen_adr_low ; Check if generated nbr is >= to limit+1
.gen_adr_end
	sta MEM_TEXT_ADRL

.gen_screen_bckgnd
	ldx #$00
.gen_screen_bckgnd_loop
	jsr Utils.get_filler
	sta MEM_CHARSLOW, x
	jsr Utils.get_filler
	sta MEM_CHARSHIGH, x
	inx
	cpx #$C0
	bne .gen_screen_bckgnd_loop

.gen_words
	; The amount and length will be hard coded for
	;  the moment, they will be random later.
	lda #$04
	sta MEM_PWD_LENGTH
	lda #$06
	sta MEM_PWD_AMOUNT
	
.gen_words_count
	; Init
	
.gen_words_count_loop
	; tmp
	

.gen_unk
	jmp render
	; Selecting words (do settings too)


	
!zone Rendering
render
	nop
; A lot of these "functions"/"subroutines"
;  will be moved in the Utils zone later.
print_all
	; Reseting X for the second timer
	ldx #$00
	ldy #$00
	
	; Setting up Input pointers
	; Starting with title
	lda #<txt_test
	sta ZP_ADR_IN_LOW
	lda #>txt_test
	sta ZP_ADR_IN_HIGH
	
	; Setting up Output pointers
	; 
	TMPVAR01 = $0400
	lda #<TMPVAR01
	sta ZP_ADR_OUT_LOW
	lda #>TMPVAR01
	sta ZP_ADR_OUT_HIGH
	
.main
	lda #$fb
.main_wait_raster
	cmp $d012
	bne .main_wait_raster
	
	inc ZP_TIMER
	lda ZP_TIMER
	cmp #$32
	bne .main_skip1
	
	lda #$00
	sta ZP_TIMER
	
	; CODE (Executed every second)
.main_skip1
	lda $d012
.main_wait_next_raster
	cmp $d012
	beq .main_wait_next_raster
	
	; CODE START (Executed every frame)
	; Text printer timer loop
	inx
	cpx #$04 ;Originally #$04
	bne .main
	
	; Starting to print stuff
	;ldy #$00
	lda (ZP_ADR_IN_LOW), y
	
	; Checking for a null terminator byte
	beq .nt_main
	
	sta (ZP_ADR_OUT_LOW), y
	
	;inc ZP_ADR_IN_LOW
	;inc ZP_ADR_OUT_LOW
	
	; Preparing value for next loops
	ldx #$00
	iny
	jmp .main

.nt_main
	lda MEM_PRINTERSTATUS
	and #MASK_PRINTER_TITLEDONE
	;bne .nt_subtitle

.nt_title
	lda MEM_PRINTERSTATUS
	ora #MASK_PRINTER_TITLEDONE
	sta MEM_PRINTERSTATUS
	
	; TODO: Use the subtitle selector subroutine here
	; Changing text address to subtitle
	lda #<txt_subtitle
	sta ZP_ADR_IN_LOW
	lda #>txt_subtitle
	sta ZP_ADR_IN_HIGH
	
	;clc
	;lda ZP_ADR_OUT_LOW
	;adc #$28
	;sta ZP_ADR_OUT_LOW
    ;bcc .nt_end
	;
	;;inc SCR_FRAME
	;inc ZP_ADR_OUT_HIGH
	jsr .nt_nextline
	
	jmp .nt_end

.nt_subtitle
	rts
	jmp .nt_end
	
.nt_end
	ldx #$00
	ldy #$00
	jmp .main

.nt_nextline
	clc
	lda ZP_ADR_OUT_LOW
	adc #$28
	sta ZP_ADR_OUT_LOW
    bcc .nt_nextline_end
	inc ZP_ADR_OUT_HIGH
.nt_nextline_end
	rts

!zone Core
.main
	jmp .main


!zone End
quit
	; Restoring screen colors
	lda #$0E
	sta SCR_FRAME
	lda #$06
	sta SCR_BKGND
	
	; Preparing values for util_clear_screen
	ldx #$00
	lda #$20
	ldy #$0E
	jsr Utils.clear_screen
	
	; Return to basic
	rts 


!zone Utils
!source "utils.asm"
; TODO: Add text printer stuff here

.get_filler
	lda MSC_SIDRNG
	and fillers_mask
	cmp fillers_max
	bcs .get_filler
	rts

!zone Data
!source "words.asm"
